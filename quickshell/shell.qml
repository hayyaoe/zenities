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
	}
}
