import QtQuick
import QtQuick.Layouts
import "../../theme"

Item {
	id: root

	// Direction & Dimention
	property bool isVertical: false
	property bool isIconStart: false
	property real length: Theme.widgetSize * 1.8
	property real thickness: Theme.widgetSize * 0.24

	// Value & Style
	property real value: 0.0
	property string icon: ""
	property real iconSpacing: Theme.spacing

	// Signal
	signal moved(real val)

	implicitWidth: isVertical ? Math.max(thickness, iconText.implicitWidth) : length
	implicitHeight: isVertical ? length : Math.max(thickness, iconText.implicitHeight)

	GridLayout {
		anchors.fill: parent
		columns: root.isVertical ? 1 : 2
		rows: root.isVertical ? 2 : 1
		columnSpacing: root.isVertical ? 0 : root.iconSpacing
		rowSpacing: root.isVertical ? root.iconSpacing : 0

		// Icon
		Text {
			id: iconText
			text: root.icon
			color: Theme.accent
			font.family: Theme.font
			font.pixelSize: Theme.fontLarge
			horizontalAlignment: Text.AlignHCenter
			verticalAlignment: Text.AlignVCenter
			visible: text !== ""

			Layout.alignment: Qt.AlignCenter
			Layout.row: root.isVertical ? (root.isIconStart ? 0 : 1) : 0
			Layout.column: root.isVertical ? 0 : (root.isIconStart ? 0 : 1)
		}

		// Slider Track
		Rectangle {
			id: track

			Layout.fillWidth: !root.isVertical
			Layout.fillHeight: root.isVertical
			Layout.preferredWidth: root.isVertical ? root.thickness : -1
			Layout.preferredHeight: !root.isVertical ? root.thickness : -1
			Layout.alignment: Qt.AlignCenter
			Layout.row: root.isVertical ? ((root.icon === "" || !root.isIconStart) ? 0 : 1) : 0
			Layout.column: root.isVertical ? 0 : ((root.icon === "" || !root.isIconStart) ? 0 : 1)

			color: Theme.surfaceContainerHigh
			radius: root.thickness / 2

			Rectangle {
				width: root.isVertical ? parent.width : parent.width * Math.min(Math.max(root.value, 0.0), 1.0)
				height: root.isVertical ? parent.height * Math.min(Math.max(root.value, 0.0), 1.0) : parent.height

				anchors.bottom: parent.bottom
				anchors.left: parent.left

				color: Theme.accent
				radius: parent.radius

				Behavior on width {
					enabled: !root.isVertical && !mouseArea.pressed
					NumberAnimation {
						duration: Theme.animationDuration
					}
				}

				Behavior on height {
					enabled: root.isVertical && !mouseArea.pressed
					NumberAnimation {
						duration: Theme.animationDuration
					}
				}
			}

			// Interaction
			MouseArea {
				id: mouseArea
				anchors.fill: parent
				cursorShape: Qt.PointingHandCursor

				function updateValue(mouse): void {
					let pct = 0.0;
					if (root.isVertical) {
						pct = 1.0 - (mouse.y / height);
					} else {
						pct = mouse.x / width;
					}
					pct = Math.min(Math.max(pct, 0.0), 1.0);
					root.moved(pct);
				}

				onPressed: mouse => updateValue(mouse)
				onPositionChanged: mouse => {
					if (pressed)
						updateValue(mouse);
				}
			}
		}
	}
}
