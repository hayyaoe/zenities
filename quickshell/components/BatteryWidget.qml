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

	targetWidth: isVertical ? ring.width : ring.width + Theme.widgetPadding + (chargingReveal.revealed ? chargingReveal.implicitWidth + Theme.spacing : 0) + (percentReveal.revealed ? percentReveal.implicitWidth + Theme.spacing : 0)
	targetHeight: isVertical ? ring.height + Theme.widgetPadding + (chargingReveal.revealed ? chargingReveal.implicitHeight + Theme.spacing : 0) + (percentReveal.revealed ? percentReveal.implicitHeight + Theme.spacing : 0) : Theme.widgetSize

	layer.enabled: true
	layer.samples: 4

	CircularProgress {
		id: ring
		value: Battery.percentage / 100
		progressColor: Battery.statusColor
		anchors {
			verticalCenter: !root.isVertical ? parent.verticalCenter : undefined
			right: !root.isVertical ? parent.right : undefined
			rightMargin: !root.isVertical ? Theme.widgetPadding : 0
			horizontalCenter: root.isVertical ? parent.horizontalCenter : undefined
			bottom: root.isVertical ? parent.bottom : undefined
			bottomMargin: root.isVertical ? Theme.widgetPadding : 0
		}
	}

	HoverReveal {
		id: chargingReveal
		revealed: Battery.isPresent && Battery.isCharging
		isVertical: root.isVertical
		animate: root.animateSize
		side: HoverReveal.Before
		anchors {
			verticalCenter: !root.isVertical ? parent.verticalCenter : undefined
			right: !root.isVertical ? ring.left : undefined
			rightMargin: !root.isVertical ? (revealed ? Theme.spacing : -8) : 0
			horizontalCenter: root.isVertical ? parent.horizontalCenter : undefined
			bottom: root.isVertical ? ring.top : undefined
			bottomMargin: root.isVertical ? (revealed ? Theme.spacing : -8) : 0
		}
		Text {
			text: ""
			font.family: Theme.font
			font.pixelSize: Theme.fontLarge
			color: Battery.statusColor
			horizontalAlignment: Text.AlignHCenter
		}
	}

	HoverReveal {
		id: percentReveal
		revealed: root.isHovered && Battery.isPresent
		isVertical: root.isVertical
		animate: root.animateSize
		side: HoverReveal.Before
		anchors {
			verticalCenter: !root.isVertical ? parent.verticalCenter : undefined
			right: !root.isVertical ? (chargingReveal.revealed ? chargingReveal.left : ring.left) : undefined
			rightMargin: !root.isVertical ? (revealed ? Theme.spacing : -4) : 0
			horizontalCenter: root.isVertical ? parent.horizontalCenter : undefined
			bottom: root.isVertical ? (chargingReveal.revealed ? chargingReveal.top : ring.top) : undefined
			bottomMargin: root.isVertical ? (revealed ? Theme.spacing : -4) : 0
		}
		Text {
			id: percentLabel
			text: root.isVertical ? `${Battery.percentage}` : `${Battery.percentage}%`
			font.family: Theme.font
			font.pixelSize: root.isVertical ? Theme.fontSmall : Theme.fontLarge
			horizontalAlignment: Text.AlignHCenter
			color: Theme.fg
		}
	}
}
