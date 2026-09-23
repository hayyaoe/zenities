import QtQuick
import "../../theme"

Item {
	id: root

	enum Side {
		Before,
		After
	}

	property bool revealed: false
	property bool isVertical: false
	property int side: HoverReveal.Before
	property bool animate: true
	default property alias content: container.data

	clip: true
	// Opacity 0 alone still hit-tests child MouseAreas; drop out of input only once the fade-out finishes
	visible: revealed || opacity > 0
	opacity: revealed ? 1 : 0
	implicitWidth: container.implicitWidth
	implicitHeight: container.implicitHeight

	Behavior on opacity {
		enabled: animate
		NumberAnimation {
			duration: Theme.animationDuration * 0.5
		}
	}
	Behavior on anchors.rightMargin {
		enabled: animate
		NumberAnimation {
			duration: Theme.animationDuration
			easing.type: Easing.OutCubic
		}
	}
	Behavior on anchors.bottomMargin {
		enabled: animate
		NumberAnimation {
			duration: Theme.animationDuration
			easing.type: Easing.OutCubic
		}
	}

	Item {
		id: container
		width: childrenRect.width
		height: childrenRect.height
		implicitWidth: childrenRect.width
		implicitHeight: childrenRect.height
	}
}
