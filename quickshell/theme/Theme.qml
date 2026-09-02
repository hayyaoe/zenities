pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

QtObject{
	id: root

	property FileView configFile: FileView{
		path: Quickshell.env("HOME") + "/.config/zenities/config.json"
		watchChanges: true
		onFileChanged: reload()
		onAdapterUpdated: writeAdapter()

		JsonAdapter{
			id: settingsAdapter
			property string wallpaperPath: ""
		}
	}

	property string wallpaperPath: settingsAdapter.wallpaperPath

	function setWallpaper(path){
		settingsAdapter.wallpaperPath = path;
	}

	// Colors
	readonly property color bg: ThemeColors.bg
	readonly property color fg: ThemeColors.fg
	readonly property color accent: ThemeColors.accent
	readonly property color surface: ThemeColors.surface
	readonly property color textMuted: ThemeColors.textMuted
	readonly property color border: ThemeColors.border

	// Spacings
	readonly property int padding: 8
	readonly property int spacing: 4

	// Rounding
	readonly property int radius: 4

	// Typography
	readonly property string font: "IosevkaMono"

	// Animation Settings
	readonly property int animationDuration: 200
	readonly property var animationCurve: Easing.OutQuad
}
