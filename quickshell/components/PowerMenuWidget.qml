import QtQuick
import Quickshell
import "./base"
import "../theme"

BaseWidget {
	id: root

	readonly property var actions: [
		{
			icon: "",
			cmd: ["systemctl", "poweroff"]
		},
		{
			icon: "",
			cmd: ["systemctl", "reboot"]
		},
		{
			icon: "",
			cmd: ["systemctl", "suspend"]
		},
		{
			icon: "",
			cmd: ["hyprlock"]
		},
		{
			icon: "",
			cmd: ["hyprctl", "dispatch", "exit"]
		}
	]

	readonly property bool isHovered: hover.containsMouse
	property bool stripHovered: false

	function syncStripHovered(): void {
		let hovered = false;
		for (let i = 0; i < menuButtons.count; i++) {
			const item = menuButtons.itemAt(i);
			if (item && item.containsCursor)
				hovered = true;
		}
		root.stripHovered = hovered;
	}

	MouseArea {
		id: hover
		anchors.fill: parent
		hoverEnabled: true
		acceptedButtons: Qt.NoButton
	}

	MouseArea {
		anchors.fill: logoText
		acceptedButtons: Qt.LeftButton
		cursorShape: Qt.PointingHandCursor
		onClicked: {}
	}

	clipContent: false

	readonly property real logoInsetWidth: Theme.spacing
	readonly property real logoInsetHeight: Theme.spacing
	readonly property real logoWidth: logoText.implicitWidth + logoInsetWidth
	readonly property real logoHeight: logoText.implicitHeight + logoInsetHeight
	readonly property real menuWidth: menuReveal.revealed ? menuReveal.implicitWidth + Theme.spacing : 0
	readonly property real menuHeight: menuReveal.revealed ? menuReveal.implicitHeight + Theme.spacing : 0

	targetWidth: isVertical ? logoWidth : logoWidth + menuWidth
	targetHeight: isVertical ? logoHeight + menuHeight : Theme.widgetSize

	Text {
		id: logoText
		text: "󰣇"
		font.family: Theme.font
		font.pixelSize: Theme.fontLarge * 1.4
		color: root.isHovered ? Theme.accent : Theme.fg
		Behavior on color {
			ColorAnimation {
				duration: Theme.animationDuration
			}
		}

		anchors {
			verticalCenter: !root.isVertical ? parent.verticalCenter : undefined
			left: !root.isVertical ? parent.left : undefined
			leftMargin: !root.isVertical ? root.logoInsetWidth : 0

			horizontalCenter: root.isVertical ? parent.horizontalCenter : undefined
			top: root.isVertical ? parent.top : undefined
			topMargin: root.isVertical ? root.logoInsetHeight : 0
		}
	}

	HoverReveal {
		id: menuReveal
		revealed: root.isHovered || root.stripHovered
		isVertical: root.isVertical
		animate: root.animateSize
		side: HoverReveal.After

		anchors {
			verticalCenter: !root.isVertical ? parent.verticalCenter : undefined
			left: !root.isVertical ? logoText.right : undefined
			leftMargin: !root.isVertical ? Theme.spacing : 0

			horizontalCenter: root.isVertical ? parent.horizontalCenter : undefined
			top: root.isVertical ? logoText.bottom : undefined
			topMargin: root.isVertical ? Theme.spacing : 0
		}

		Repeater {
			id: menuButtons
			model: root.actions
			delegate: Item {
				required property int index
				required property var modelData

				readonly property real slot: Theme.widgetSize
				property bool containsCursor: buttonArea.containsMouse
				onContainsCursorChanged: root.syncStripHovered() * 0.2

				x: root.isVertical ? 0 : index * slot
				y: root.isVertical ? index * slot : 0
				width: Theme.widgetSize
				height: Theme.widgetSize

				Text {
					anchors.centerIn: parent
					text: modelData.icon
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
					onClicked: Quickshell.execDetached(modelData.cmd)
				}
			}
		}
	}
}
