import QtQuick
import "./base"
import "../theme"
import "../services"

BaseWidget {
	id: root

	visible: Media.hasActive && Media.trackTitle !== ""

	readonly property bool isHovered: hover.containsMouse
	property bool stripHovered: false

	function syncStripHovered(): void {
		let hovered = false;
		for (let i = 0; i < controlButtons.count; i++) {
			const item = controlButtons.itemAt(i);
			if (item && item.containsCursor)
				hovered = true;
		}
		root.stripHovered = hovered;
	}

	readonly property var controls: [
		{ icon: "\uF048", action: "previous" },
		{ icon: "", action: "toggle" },
		{ icon: "\uF051", action: "next" }
	]

	function resetTitleScroll(): void {
		if (titleView.overflowing)
			marquee.restart();
		else {
			marquee.stop();
			titleText.x = 0;
		}
	}

	Connections {
		target: Media
		function onTrackTitleChanged() {
			root.resetTitleScroll();
		}
	}

	Component.onCompleted: resetTitleScroll()

	MouseArea {
		id: hover
		anchors.fill: parent
		hoverEnabled: true
		acceptedButtons: Qt.NoButton
	}

	clipContent: false

	readonly property real coverSize: Math.round(Theme.widgetSize * 0.8)
	readonly property real coverAdvance: coverSize + Theme.spacing * 2
	readonly property real artGap: Theme.spacing * 2.5
	readonly property real titleAdvance: titleView.width + artGap
	readonly property real controlsWidth: controlsReveal.revealed ? controlsReveal.implicitWidth + Theme.spacing * 2 : 0
	readonly property real controlsHeight: controlsReveal.revealed ? controlsReveal.implicitHeight + Theme.spacing : 0

	targetWidth: isVertical ? Theme.widgetSize : coverAdvance + titleAdvance + controlsWidth
	targetHeight: isVertical ? coverAdvance + titleView.width + artGap + controlsHeight : Theme.widgetSize

	Item {
		id: titleView
		transform: Rotation {
			origin.x: 0
			origin.y: 0
			angle: root.isVertical ? 270 : 0
		}
		readonly property bool overflowing: titleText.implicitWidth > width
		width: Math.min(titleText.implicitWidth, Theme.widgetSize * 5)
		height: titleText.implicitHeight
		clip: true

		anchors {
			verticalCenter: !root.isVertical ? parent.verticalCenter : undefined
			left: !root.isVertical ? coverRect.right : undefined
			leftMargin: !root.isVertical ? root.artGap : 0

			horizontalCenter: root.isVertical ? parent.horizontalCenter : undefined
			horizontalCenterOffset: root.isVertical ? (width - height) / 2 : 0
			bottom: root.isVertical ? coverRect.top : undefined
			bottomMargin: root.isVertical ? root.artGap - height : 0
		}

		Text {
			id: titleText
			text: Media.trackTitle
			anchors.verticalCenter: parent.verticalCenter
			font.family: Theme.font
			font.pixelSize: Theme.fontLarge
			color: root.isHovered ? Theme.accent : Theme.fg
			Behavior on color {
				ColorAnimation {
					duration: Theme.animationDuration
				}
			}
		}

		SequentialAnimation {
			id: marquee
			loops: Animation.Infinite
			paused: !root.visible
			PropertyAction {
				target: titleText
				property: "x"
				value: 0
			}
			PauseAnimation {
				duration: Theme.animationDuration * 3
			}
			NumberAnimation {
				target: titleText
				property: "x"
				to: -titleText.implicitWidth
				duration: Math.max(1000, Math.round(titleText.implicitWidth * 40))
				easing.type: Easing.Linear
			}
			PropertyAction {
				target: titleText
				property: "x"
				value: titleView.width
			}
			NumberAnimation {
				target: titleText
				property: "x"
				to: 0
				duration: Math.max(400, Math.round(titleView.width * 40))
				easing.type: Easing.Linear
			}
		}
	}

	MouseArea {
		anchors.fill: coverRect
		acceptedButtons: Qt.LeftButton
		cursorShape: Qt.PointingHandCursor
		onClicked: Media.toggle()
	}

	Rectangle {
		id: coverRect
		width: root.coverSize
		height: root.coverSize
		color: "transparent"

		anchors {
			verticalCenter: !root.isVertical ? parent.verticalCenter : undefined
			left: !root.isVertical ? parent.left : undefined
			leftMargin: !root.isVertical ? Theme.spacing : 0

			horizontalCenter: root.isVertical ? parent.horizontalCenter : undefined
			bottom: root.isVertical ? parent.bottom : undefined
			bottomMargin: root.isVertical ? Theme.spacing : 0
		}

		Image {
			id: coverArt
			anchors.fill: parent
			asynchronous: false
			fillMode: Image.PreserveAspectCrop
			sourceSize: Qt.size(root.coverSize * 2, root.coverSize * 2)
			source: Media.trackArtSource
			onStatusChanged: if (status === Image.Error && source !== "")
				artRetry.restart()
		}

		Timer {
			id: artRetry
			interval: 1500
			onTriggered: {
				coverArt.source = ""
				coverArt.source = Qt.binding(() => Media.trackArtSource)
			}
		}

		Text {
			visible: coverArt.status !== Image.Ready || coverArt.source === ""
			anchors.centerIn: parent
			text: "\uF001"
			font.family: Theme.font
			font.pixelSize: Theme.fontLarge
			color: Theme.fg
		}
	}

	HoverReveal {
		id: controlsReveal
		revealed: (root.isHovered || root.stripHovered) && root.visible
		isVertical: root.isVertical
		animate: root.animateSize
		side: root.isVertical ? HoverReveal.Before : HoverReveal.After

		anchors {
			verticalCenter: !root.isVertical ? parent.verticalCenter : undefined
			left: !root.isVertical ? titleView.right : undefined
			leftMargin: !root.isVertical ? Theme.spacing : 0

			horizontalCenter: root.isVertical ? parent.horizontalCenter : undefined
			bottom: root.isVertical ? titleView.top : undefined
			bottomMargin: root.isVertical ? (revealed ? titleView.width + Theme.spacing : -8) : 0
		}

		Repeater {
			id: controlButtons
			model: root.controls
			delegate: Item {
				required property int index
				required property var modelData

				readonly property real slot: Theme.widgetSize
				property bool containsCursor: buttonArea.containsMouse
				onContainsCursorChanged: root.syncStripHovered()

				x: root.isVertical ? 0 : index * slot
				y: root.isVertical ? index * slot : 0
				width: slot
				height: slot

				Text {
					anchors.centerIn: parent
					text: modelData.action === "toggle" ? (Media.isPlaying ? "\uF04C" : "\uF04B") : modelData.icon
					font.family: Theme.font
					font.pixelSize: Theme.fontLarge
					color: buttonArea.containsMouse ? Theme.accent : Theme.fg
					Behavior on color {
						ColorAnimation {
							duration: Theme.animationDuration
						}
					}
				}

				MouseArea {
					id: buttonArea
					anchors.fill: parent
					hoverEnabled: true
					cursorShape: Qt.PointingHandCursor
					onClicked: {
						if (modelData.action === "previous")
							Media.previous();
						else if (modelData.action === "next")
							Media.next();
						else
							Media.toggle();
					}
				}
			}
		}
	}
}
