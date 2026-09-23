import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland

import "./base"
import "../theme"

BaseWidget {
	id: root

	readonly property int workspaceCount: Hyprland.workspaces ? Hyprland.workspaces.values.length : 0
	readonly property int activeWorkspaceCount: Hyprland.workspaces ? Hyprland.workspaces.values.filter(ws => ws.focused || ws.active).length : 0

	// Cell extents along the stacking axis (the cross axis is always widgetSize)
	readonly property real activeCellLength: Theme.widgetSize * 0.45
	readonly property real inactiveCellLength: Theme.widgetSize * 0.2

	readonly property real activeExtent: Math.max(0, activeWorkspaceCount) * activeCellLength
	readonly property real inactiveExtent: Math.max(0, workspaceCount - (1 + activeWorkspaceCount)) * inactiveCellLength
	readonly property real gapExtent: Math.max(0, workspaceCount - 1) * Theme.spacing * 2
	readonly property real paddingExtent: Theme.padding * 2
	readonly property real stackExtent: activeExtent + inactiveExtent + gapExtent + paddingExtent

	targetWidth: isVertical ? Theme.widgetSize : stackExtent
	targetHeight: isVertical ? stackExtent : Theme.widgetSize

	GridLayout {
		anchors.top: isVertical ? parent.top : undefined
		anchors.left: isVertical ? undefined : parent.left
		anchors.margins: Theme.padding

		anchors.horizontalCenter: isVertical ? parent.horizontalCenter : undefined
		anchors.verticalCenter: isVertical ? undefined : parent.verticalCenter

		columnSpacing: isVertical ? 0 : Theme.spacing * 1.6
		rowSpacing: isVertical ? Theme.spacing * 1.6 : 0
		columns: isVertical ? 1 : workspaceCount
		rows: isVertical ? workspaceCount : 1

		Repeater {
			id: workspaceRepeater
			model: Hyprland.workspaces

			delegate: Item {
				id: delegateItem

				implicitWidth: Math.round(isVertical ? root.inactiveCellLength : (modelData.active ? root.activeCellLength : root.inactiveCellLength))
				implicitHeight: Math.round(isVertical ? (modelData.active ? root.activeCellLength : root.inactiveCellLength) : root.inactiveCellLength)

				readonly property bool isHovered: mouseArea.containsMouse

				Behavior on implicitWidth {
					enabled: root.animateSize
					NumberAnimation {
						duration: Theme.animationDuration
						easing.type: Easing.OutCubic
					}
				}

				Behavior on implicitHeight {
					enabled: root.animateSize
					NumberAnimation {
						duration: Theme.animationDuration
						easing.type: Easing.OutCubic
					}
				}

				Rectangle {
					id: visualShape

					readonly property real size: Math.max(parent.width, parent.height)

					width: size
					height: size
					anchors.centerIn: parent

					color: "transparent"
					border.color: modelData.focused || delegateItem.isHovered ? Theme.fg : Theme.tertiary
					border.width: Math.round(1 * Theme.scale)
					radius: modelData.focused ? size / 4 : size / 2
					rotation: modelData.focused ? 135 : 0

					Behavior on rotation {
						enabled: root.animateSize
						NumberAnimation {
							duration: Theme.animationDuration
							easing.type: Easing.OutCubic
						}
					}

					Behavior on radius {
						enabled: root.animateSize
						NumberAnimation {
							duration: Theme.animationDuration
							easing.type: Easing.OutCubic
						}
					}

					Behavior on border.color {
						enabled: root.animateSize
						ColorAnimation {
							duration: Theme.animationDuration
						}
					}
				}

				MouseArea {
					id: mouseArea
					anchors.fill: parent
					cursorShape: Qt.PointingHandCursor
					hoverEnabled: true
					onClicked: Hyprland.dispatch(`hl.dsp.focus({workspace = ${modelData.id}})`)
				}
			}
		}
	}
}
