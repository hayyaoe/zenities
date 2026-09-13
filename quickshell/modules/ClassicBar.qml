import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import QtQuick.Window

import "../theme"
import "../components"

PanelWindow {
	id: root

	// Window Config
	color: "transparent"
	WlrLayershell.layer: WlrLayer.Top
	WlrLayershell.namespace: "quickshell-bar"
	WlrLayershell.exclusionMode: ExclusionMode.Normal
	WlrLayershell.exclusiveZone: isFloating ? (Theme.barThickness + Theme.barMargin) : Theme.barThickness

	implicitWidth: isVertical ? (Theme.barThickness + (activeFloating ? Theme.barMargin * 2 : Theme.screenRadius)) : 0
	implicitHeight: !isVertical ? (Theme.barThickness + (activeFloating ? Theme.barMargin * 2 : Theme.screenRadius)) : 0

	anchors {
		top: activePosition !== "bottom"
		bottom: activePosition !== "top"
		left: activePosition !== "right"
		right: activePosition !== "left"
	}

	mask: Region {
		item: barCanvas
	}

	// State & Properties
	property bool activeFloating: Theme.barFloating || false
	property string activePosition: Theme.barPosition || "top"

	readonly property bool isFloating: Theme.barFloating || false
	readonly property string position: Theme.barPosition || "top"
	readonly property bool isVertical: activePosition === "left" || activePosition === "right"

	// Event Listeners
	Connections {
		target: Theme
		function onBarPositionChanged() {
			barTransition.restart();
		}
		function onBarFloatingChanged() {
			barTransition.restart();
		}
	}

	// Transition Animation
	SequentialAnimation {
		id: barTransition

		ParallelAnimation {
			NumberAnimation {
				target: barTranslate
				property: root.activePosition === "top" || root.activePosition === "bottom" ? "y" : "x"
				to: {
					if (root.activePosition === "top")
						return -root.implicitHeight;
					if (root.activePosition === "bottom")
						return root.implicitHeight;
					if (root.activePosition === "left")
						return -root.implicitWidth;
					if (root.activePosition === "right")
						return root.implicitWidth;
					return 0;
				}
				duration: Theme.animationDuration
				easing.type: Easing.InQuad
			}
		}

		ScriptAction {
			script: {
				let nextPos = Theme.barPosition;
				let nextFloating = Theme.barFloating;
				let targetSize = Theme.barThickness + (nextFloating ? Theme.barMargin * 2 : Theme.screenRadius);

				if (nextPos === "top") {
					barTranslate.x = 0;
					barTranslate.y = -targetSize;
				} else if (nextPos === "bottom") {
					barTranslate.x = 0;
					barTranslate.y = targetSize;
				} else if (nextPos === "left") {
					barTranslate.x = -targetSize;
					barTranslate.y = 0;
				} else if (nextPos === "right") {
					barTranslate.x = targetSize;
					barTranslate.y = 0;
				}

				root.activePosition = nextPos;
				root.activeFloating = nextFloating;
			}
		}

		ParallelAnimation {
			NumberAnimation {
				target: barTranslate
				property: "x"
				to: 0
				duration: Theme.animationDuration
				easing.type: Easing.OutCubic
			}
			NumberAnimation {
				target: barTranslate
				property: "y"
				to: 0
				duration: Theme.animationDuration
				easing.type: Easing.OutCubic
			}
		}
	}

	// Bar Canvas
	Rectangle {
		id: barCanvas
		color: Theme.surface
		radius: (root.activeFloating && Theme.barRounded) ? Theme.radius : 0

		x: {
			if (root.activeFloating)
				return Theme.barMargin;
			if (root.activePosition === "right")
				return Theme.screenRadius;
			return 0;
		}
		y: {
			if (root.activeFloating)
				return Theme.barMargin;
			if (root.activePosition === "bottom")
				return Theme.screenRadius;
			return 0;
		}

		width: root.isVertical ? Theme.barThickness : Screen.width - (root.activeFloating ? Theme.barMargin * 2 : 0)
		height: root.isVertical ? Screen.height - (root.activeFloating ? Theme.barMargin * 2 : 0) : Theme.barThickness

		transform: Translate {
			id: barTranslate
			x: 0
			y: 0
		}

		Behavior on radius {
			SmoothAnim {}
		}
		Behavior on x {
			SmoothAnim {}
		}
		Behavior on y {
			SmoothAnim {}
		}
		Behavior on width {
			SmoothAnim {}
		}
		Behavior on height {
			SmoothAnim {}
		}

		// Bar Content
		Loader {
			anchors.fill: parent
			anchors.margins: Theme.padding
			sourceComponent: root.isVertical ? verticalLayout : horizontalLayout
		}

		// Bar Corners
		Repeater {
			model: (!root.activeFloating && Theme.screenCorners) ? 2 : 0

			CornerShape {
				property bool isSecond: index === 1

				x: {
					if (root.activePosition === "right")
						return -width;
					if (root.activePosition === "left")
						return parent.width;
					return isSecond ? parent.width - width : 0;
				}
				y: {
					if (root.activePosition === "top")
						return parent.height;
					if (root.activePosition === "bottom")
						return -height;
					return isSecond ? parent.height - height : 0;
				}
				rotation: {
					if (root.activePosition === "top")
						return isSecond ? 90 : 0;
					if (root.activePosition === "bottom")
						return isSecond ? 180 : 270;
					if (root.activePosition === "left")
						return isSecond ? 270 : 0;
					if (root.activePosition === "right")
						return isSecond ? 180 : 90;
					return 0;
				}
			}
		}
	}

	// Morphing Animations
	component SmoothAnim: NumberAnimation {
		duration: barTransition.running ? 0 : Theme.animationDuration
		easing.type: Easing.OutCubic
	}

	// Layouts
	Component {
		id: horizontalLayout
		RowLayout {
			spacing: Theme.spacing
			Item {
				Layout.fillWidth: true
			}
			Item {
				Layout.fillWidth: true
			}
		}
	}

	Component {
		id: verticalLayout
		ColumnLayout {
			spacing: Theme.spacing
			Item {
				Layout.fillHeight: true
			}
			Item {
				Layout.fillHeight: true
			}
		}
	}
}
