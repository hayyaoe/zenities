import QtQuick
import Quickshell
import Quickshell.Wayland

import "theme"
import "modules"
import "components"
import "modules/background"
import "modules/overlay"

ShellRoot{
	settings.watchFiles: true

	Wallpaper{}
	MainCanvas{}
	ClassicBar{}
}
