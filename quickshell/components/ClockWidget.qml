import QtQuick
import "./base"
import "../theme"
import "../services"

BaseWidget {
	id: root

	readonly property bool isHovered: hover.containsMouse
	MouseArea {
		id: hover
		anchors.fill: parent
		hoverEnabled: true
		cursorShape: Qt.PointingHandCursor
		acceptedButtons: Qt.NoButton
	}

	clipContent: false

	readonly property real timeWidth: timeText.implicitWidth + Theme.widgetPadding
	readonly property real timeHeight: timeText.implicitHeight + Theme.widgetPadding
	readonly property real dateWidth: dateReveal.revealed ? dateLabel.implicitWidth + Theme.spacing * 2 : 0
	readonly property real dateHeight: dateReveal.revealed ? dateLabel.implicitHeight + Theme.spacing : 0
	readonly property real revealGap: dateReveal.revealed ? Theme.spacing * 2.5 : 0

	targetWidth: isVertical ? timeText.implicitWidth + Theme.spacing : timeWidth + dateWidth + revealGap
	targetHeight: isVertical ? timeHeight + dateHeight : Theme.widgetSize

	Text {
		id: timeText
		text: root.isVertical ? `${Time.hours}\n${Time.minutes}` : Time.time
		font.family: Theme.font
		font.pixelSize: Theme.fontLarge
		color: Theme.fg

		anchors {
			verticalCenter: !root.isVertical ? parent.verticalCenter : undefined
			right: !root.isVertical ? parent.right : undefined
			rightMargin: !root.isVertical ? Theme.spacing : 0

			horizontalCenter: root.isVertical ? parent.horizontalCenter : undefined
			bottom: root.isVertical ? parent.bottom : undefined
			bottomMargin: root.isVertical ? Theme.spacing : 0
		}
	}

	HoverReveal {
		id: dateReveal
		revealed: root.isHovered
		isVertical: root.isVertical
		animate: root.animateSize
		side: HoverReveal.Before

		anchors {
			verticalCenter: !root.isVertical ? parent.verticalCenter : undefined
			right: !root.isVertical ? timeText.left : undefined
			rightMargin: !root.isVertical ? (revealed ? Theme.spacing * 2 : -8) : 0

			horizontalCenter: root.isVertical ? parent.horizontalCenter : undefined
			bottom: root.isVertical ? timeText.top : undefined
			bottomMargin: root.isVertical ? (revealed ? Theme.spacing : -8) : 0
		}

		Text {
			id: dateLabel
			text: root.isVertical ? Time.dayName : Time.dateString
			font.family: Theme.font
			font.pixelSize: root.isVertical ? Theme.fontSmall : Theme.fontLarge
			color: Theme.fg
		}
	}
}
