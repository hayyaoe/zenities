import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import QtQuick.Window

import "../theme"
import "../components"
import "../components/base"

PanelWindow {
	id: root
	visible: ready

	color: "transparent"
	WlrLayershell.layer: WlrLayer.Top
	WlrLayershell.namespace: "quickshell-bar"
	WlrLayershell.exclusionMode: ready ? ExclusionMode.Normal : ExclusionMode.Ignore
	WlrLayershell.exclusiveZone: ready ? (activeFloating ? Theme.barThickness + Theme.barMargin : Theme.barThickness) : 0

	readonly property ShellScreen targetScreen: {
		const name = Theme.barScreen;
		const screens = Quickshell.screens;
		if (name !== "") {
			for (let i = 0; i < screens.length; i++) {
				if (screens[i].name === name)
					return screens[i];
			}
		}
		return screens.length > 0 ? screens[0] : null;
	}

	screen: targetScreen

	property bool ready: false
	property bool activeFloating: Theme.barFloating || false
	property string activePosition: Theme.barPosition || "top"

	readonly property bool isFloating: Theme.barFloating || false
	readonly property bool isVertical: activePosition === "left" || activePosition === "right"

	function syncAndEnter() {
		if (ready)
			return;
		root.activePosition = Theme.barPosition || "top";
		root.activeFloating = Theme.barFloating || false;
		let s = Theme.barThickness + (root.activeFloating ? Theme.barMargin * 2 : (Theme.screenCorners ? Theme.screenRadius : 0));
		barTranslate.x = 0;
		barTranslate.y = 0;
		if (root.activePosition === "top")
			barTranslate.y = -s;
		else if (root.activePosition === "bottom")
			barTranslate.y = s;
		else if (root.activePosition === "left")
			barTranslate.x = -s;
		else if (root.activePosition === "right")
			barTranslate.x = s;
		ready = true;
		enterAnim.restart();
	}

	Timer {
		id: syncTimer
		interval: Theme.animationDuration * 0.08
		onTriggered: syncAndEnter()
	}
	Connections {
		target: Theme.configFile
		function onAdapterUpdated() {
			if (!ready)
				syncTimer.restart();
		}
	}
	Connections {
		target: Theme
		function onBarPositionChanged() {
			if (ready)
				barTransition.restart();
			else
				syncTimer.restart();
		}
		function onBarFloatingChanged() {
			if (ready)
				barTransition.restart();
			else
				syncTimer.restart();
		}
	}
	Timer {
		id: fallback
		interval: Theme.animationDuration * 0.4
		running: !ready
		repeat: true
		onTriggered: if (!ready && Theme.configFile.loaded)
			syncTimer.restart()
	}
	Timer {
		id: missingFallback
		interval: Theme.animationDuration * 2
		running: !ready
		onTriggered: if (!ready)
			syncAndEnter()
	}

	// animate position changes
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
		PropertyAction {
			target: barCanvas
			property: "opacity"
			value: 0
		}
		ScriptAction {
			script: {
				let nextPos = Theme.barPosition;
				let nextFloating = Theme.barFloating;
				let targetSize = Theme.barThickness + (nextFloating ? Theme.barMargin * 2 : (Theme.screenCorners ? Theme.screenRadius : 0));
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
		PauseAnimation {
			duration: Theme.animationDuration * 0.16
		}
		PropertyAction {
			target: barCanvas
			property: "opacity"
			value: 1
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

	ParallelAnimation {
		id: enterAnim
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

	PropertyAnimation {
		id: dummy
	}

	implicitWidth: isVertical ? Theme.barThickness + (activeFloating ? Theme.barMargin * 2 : (Theme.screenCorners ? Theme.screenRadius : 0)) : 0
	implicitHeight: !isVertical ? Theme.barThickness + (activeFloating ? Theme.barMargin * 2 : (Theme.screenCorners ? Theme.screenRadius : 0)) : 0

	anchors {
		top: activePosition !== "bottom"
		bottom: activePosition !== "top"
		left: activePosition !== "right"
		right: activePosition !== "left"
	}

	Rectangle {
		id: barCanvas
		color: Theme.surface
		radius: (root.activeFloating && Theme.barRounded) ? Theme.radius : 0
		x: {
			if (root.activeFloating)
				return Theme.barMargin;
			if (!root.activeFloating && Theme.screenCorners && root.activePosition === "right")
				return Theme.screenRadius;
			return 0;
		}
		y: {
			if (root.activeFloating)
				return Theme.barMargin;
			if (!root.activeFloating && Theme.screenCorners && root.activePosition === "bottom")
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
			enabled: ready && !barTransition.running && !enterAnim.running
			SmoothAnim {}
		}
		Behavior on x {
			enabled: ready && !barTransition.running && !enterAnim.running
			SmoothAnim {}
		}
		Behavior on y {
			enabled: ready && !barTransition.running && !enterAnim.running
			SmoothAnim {}
		}
		Behavior on width {
			enabled: ready && !barTransition.running && !enterAnim.running
			SmoothAnim {}
		}
		Behavior on height {
			enabled: ready && !barTransition.running && !enterAnim.running
			SmoothAnim {}
		}

		Loader {
			anchors.fill: parent
			anchors.leftMargin: !root.isVertical ? Theme.padding : 0
			anchors.rightMargin: !root.isVertical ? Theme.padding : 0
			anchors.topMargin: root.isVertical ? Theme.padding : 0
			anchors.bottomMargin: root.isVertical ? Theme.padding : 0
			sourceComponent: root.isVertical ? verticalLayout : horizontalLayout
		}
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

	component SmoothAnim: NumberAnimation {
		duration: Theme.animationDuration
		easing.type: Easing.OutCubic
	}

	Component {
		id: horizontalLayout
		RowLayout {
			anchors.fill: parent
			spacing: Theme.spacing * 2
			PowerMenuWidget {
				Layout.rightMargin: -Theme.spacing
				animateSize: !barTransition.running
			}
			WorkspaceIndicatorWidget {
				animateSize: !barTransition.running
			}
			Item {
				Layout.fillWidth: true
			}
			AudioWidget {
				animateSize: !barTransition.running
			}
			BrightnessWidget {
				animateSize: !barTransition.running
			}
			BatteryWidget {
				animateSize: !barTransition.running
			}
			ClockWidget {
				animateSize: !barTransition.running
			}
		}
	}
	Component {
		id: verticalLayout
		ColumnLayout {
			anchors.fill: parent
			spacing: Theme.spacing
			PowerMenuWidget {
				isVertical: root.isVertical
				Layout.bottomMargin: -Theme.spacing
				animateSize: !barTransition.running
				Layout.alignment: Qt.AlignHCenter
			}
			WorkspaceIndicatorWidget {
				isVertical: root.isVertical
				animateSize: !barTransition.running
				Layout.alignment: Qt.AlignHCenter
			}
			Item {
				Layout.fillHeight: true
			}
			AudioWidget {
				isVertical: root.isVertical
				animateSize: !barTransition.running
				Layout.alignment: Qt.AlignHCenter
			}
			BrightnessWidget {
				isVertical: root.isVertical
				animateSize: !barTransition.running
				Layout.alignment: Qt.AlignHCenter
			}
			BatteryWidget {
				isVertical: root.isVertical
				animateSize: !barTransition.running
				Layout.alignment: Qt.AlignHCenter
			}
			ClockWidget {
				isVertical: root.isVertical
				animateSize: !barTransition.running
				Layout.alignment: Qt.AlignHCenter
			}
		}
	}
}
