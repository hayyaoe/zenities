import QtQuick
import Quickshell
import Quickshell.Wayland

import "../../theme"

PanelWindow {
	id: mainCanvas
	screen: Quickshell.screens[0]
	color: "transparent"

	// Window Config
	WlrLayershell.layer: WlrLayer.Overlay
	WlrLayershell.exclusionMode: ExclusionMode.Ignore
	WlrLayershell.keyboardFocus: WlrKeyboardFocus.None
	WlrLayershell.namespace: "quickshell-canvas"

	anchors {
		top: true
		bottom: true
		left: true
		right: true
	}

	// Click Mask
	mask: Region {}

	// Overlay Modules
	Loader {
		anchors.fill: parent
		active: Theme.screenCorners
		source: "ScreenCorners.qml"
	}

	Item {
		id: fullMask
		anchors.fill: parent
	}
}
