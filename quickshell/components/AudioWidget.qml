import QtQuick
import "./base"
import "../theme"
import "../services"

BaseWidget {
	id: root

	property bool showPercent: false

	readonly property bool isHovered: hover.containsMouse

	MouseArea {
		id: hover
		anchors.fill: parent
		hoverEnabled: true
		acceptedButtons: Qt.NoButton
	}

	MouseArea {
		anchors.fill: iconText
		acceptedButtons: Qt.LeftButton
		cursorShape: Qt.PointingHandCursor
		onClicked: Audio.toggleMute()
	}

	clipContent: false

	readonly property real iconInsetWidth: Theme.spacing * 2
	readonly property real iconInsetHeight: Theme.spacing * 0.9
	readonly property real iconOpticalX: -Math.round(Theme.spacing * 0.5)
	readonly property real iconSlotWidth: Audio.iconAdvanceMax
	readonly property real iconWidth: iconText.width + iconInsetWidth
	readonly property real iconHeight: iconText.implicitHeight + iconInsetHeight
	readonly property real percentWidth: percentReveal.revealed ? percentReveal.implicitWidth + Theme.spacing : 0
	readonly property real percentHeight: percentReveal.revealed ? percentReveal.implicitHeight + Theme.spacing : 0
	readonly property real sliderWidth: sliderReveal.revealed ? sliderReveal.implicitWidth + Theme.spacing * 2 : 0
	readonly property real sliderHeight: sliderReveal.revealed ? sliderReveal.implicitHeight + Theme.spacing : 0

	targetWidth: isVertical ? iconWidth * 0.8 : iconWidth + percentWidth + sliderWidth
	targetHeight: isVertical ? iconHeight + percentHeight + sliderHeight : Theme.widgetSize

	Text {
		id: iconText
		text: Audio.icon
		width: root.iconSlotWidth
		horizontalAlignment: Text.AlignHCenter
		font.family: Theme.font
		font.pixelSize: Theme.fontLarge
		color: root.isHovered ? Theme.accent : Audio.statusColor
		Behavior on color {
			ColorAnimation {
				duration: Theme.animationDuration
			}
		}

		anchors {
			verticalCenter: !root.isVertical ? parent.verticalCenter : undefined
			right: !root.isVertical ? parent.right : undefined
			rightMargin: !root.isVertical ? root.iconInsetWidth : 0

			horizontalCenter: root.isVertical ? parent.horizontalCenter : undefined
			horizontalCenterOffset: root.isVertical ? root.iconOpticalX : 0
			bottom: root.isVertical ? parent.bottom : undefined
			bottomMargin: root.isVertical ? root.iconInsetHeight : 0
		}
	}

	HoverReveal {
		id: percentReveal
		revealed: root.showPercent && root.isHovered
		isVertical: root.isVertical
		animate: root.animateSize
		side: HoverReveal.Before

		anchors {
			verticalCenter: !root.isVertical ? parent.verticalCenter : undefined
			right: !root.isVertical ? iconText.left : undefined
			rightMargin: !root.isVertical ? (revealed ? Theme.spacing : -8) : 0

			horizontalCenter: root.isVertical ? parent.horizontalCenter : undefined
			bottom: root.isVertical ? iconText.top : undefined
			bottomMargin: root.isVertical ? (revealed ? Theme.spacing : -8) : 0
		}

		Text {
			text: `${Audio.volumePercent}%`
			font.family: Theme.font
			font.pixelSize: root.isVertical ? Theme.fontSmall * 1.4 : Theme.fontLarge * 1.2
			horizontalAlignment: Text.AlignHCenter
			color: root.isHovered ? Theme.accent : Theme.fg
		}
	}

	HoverReveal {
		id: sliderReveal
		revealed: root.isHovered
		isVertical: root.isVertical
		animate: root.animateSize
		side: HoverReveal.Before

		anchors {
			verticalCenter: !root.isVertical ? parent.verticalCenter : undefined
			right: !root.isVertical ? (percentReveal.revealed ? percentReveal.left : iconText.left) : undefined
			rightMargin: !root.isVertical ? (revealed ? Theme.spacing * 2 : -8) : 0

			horizontalCenter: root.isVertical ? parent.horizontalCenter : undefined
			bottom: root.isVertical ? (percentReveal.revealed ? percentReveal.top : iconText.top) : undefined
			bottomMargin: root.isVertical ? (revealed ? Theme.spacing : -8) : 0
		}

		Slider {
			id: slider
			isVertical: root.isVertical
			icon: ""
			length: Math.round(Theme.widgetSize * 2)
			width: implicitWidth
			height: implicitHeight
			value: Audio.volume
			onMoved: val => Audio.setVolume(val)
		}
	}
}
