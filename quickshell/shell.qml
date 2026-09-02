import QtQuick
import Quickshell
import Quickshell.Wayland

import "theme"
import "modules/background"

ShellRoot{
	settings.watchFiles: true

	Wallpaper{}

	PanelWindow{
		id: mainCanvas
		screen: Quickshell.screens[0]

		anchors{
			top: true
			bottom: true
			left: true
			right: true
		}

		color: "transparent"

		WlrLayershell.layer: WlrLayer.Top
		WlrLayershell.exclusionMode: ExclusionMode.Ignore
		WlrLayershell.keyboardFocus: WlrKeyboardFocus.None
		WlrLayershell.namespace: "quickshell-canvas"
		
		mask: Region {}

		Item {id: fullMask; anchors.fill: parent}
	}

}
