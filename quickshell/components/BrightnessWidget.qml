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
	targetWidth: isVertical ? Theme.widgetSize : iconText.implicitWidth + Theme.spacing + (sliderReveal.revealed ? sliderReveal.implicitWidth + Theme.spacing * 2 : 0)
	targetHeight: isVertical ? iconText.implicitHeight + Theme.spacing + (sliderReveal.revealed ? sliderReveal.implicitHeight + Theme.spacing : 0) : Theme.widgetSize

	Text {
		id: iconText
		text: ""
		font.family: Theme.font
		font.pixelSize: Theme.fontLarge * 1.2
		color: root.isHovered ? Theme.accent : Theme.fg
		Behavior on color {
			ColorAnimation {
				duration: Theme.animationDuration
			}
		}

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
		id: sliderReveal
		revealed: root.isHovered
		isVertical: root.isVertical
		animate: root.animateSize
		side: HoverReveal.Before

		anchors {
			verticalCenter: !root.isVertical ? parent.verticalCenter : undefined
			right: !root.isVertical ? iconText.left : undefined
			rightMargin: !root.isVertical ? (revealed ? Theme.spacing * 2 : -8) : 0

			horizontalCenter: root.isVertical ? parent.horizontalCenter : undefined
			bottom: root.isVertical ? iconText.top : undefined
			bottomMargin: root.isVertical ? (revealed ? Theme.spacing : -8) : 0
		}

		Slider {
			id: slider
			isVertical: root.isVertical
			icon: ""
			length: Math.round(Theme.widgetSize * 2)
			width: implicitWidth
			height: implicitHeight
			value: Brightness.brightness
			onMoved: val => Brightness.setBrightness(Math.max(val, 0.01))
		}
	}
}
