import QtQuick
import "../../theme"

Rectangle {
	id: root
	property bool isVertical: false
	property real targetWidth: Theme.widgetSize
	property real targetHeight: Theme.widgetSize
	default property alias content: contentItem.data

	implicitWidth: Math.round(targetWidth)
	implicitHeight: Math.round(targetHeight)

	property bool clipContent: true
	property bool animateSize: true
	radius: Theme.radius
	color: "transparent"
	clip: clipContent

	Behavior on targetWidth {
		enabled: animateSize
		NumberAnimation {
			duration: Theme.animationDuration
			easing.type: Easing.OutCubic
		}
	}

	Behavior on targetHeight {
		enabled: animateSize
		NumberAnimation {
			duration: Theme.animationDuration
			easing.type: Easing.OutCubic
		}
	}

	Behavior on color {
		ColorAnimation {
			duration: Theme.animationDuration
		}
	}

	Item {
		id: contentItem
		anchors.fill: parent
	}
}
