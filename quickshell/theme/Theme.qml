pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

QtObject{
	id: root

	property FileView configFile: FileView{
		path: (Quickshell.env("XDG_CONFIG_HOME") || (Quickshell.env("HOME") + "/.config")) + "/zenities/config.json"
		watchChanges: true
		onFileChanged: reload()
		onAdapterUpdated: writeAdapter()
		Component.onCompleted: {
            		reload()
        	}

		JsonAdapter{
			id: settingsAdapter
			property bool darkMode: (Quickshell.env("ZENITIES_DARK_MODE") !== "false")
			property string wallpaperPath: Quickshell.env("ZENITIES_WALLPAPER") || ""
		}
	}

	readonly property bool darkMode: settingsAdapter.darkMode
	property string wallpaperPath: settingsAdapter.wallpaperPath

	function setWallpaper(path){
		settingsAdapter.wallpaperPath = path;
	}

	function setDarkMode(enabled) {
        	settingsAdapter.darkMode = enabled;
    	}

	// Colors
	// Surfaces & Backgrounds
	readonly property color background: QuickshellTheme.background
    	readonly property color surface: QuickshellTheme.surface
    	readonly property color surfaceContainer: QuickshellTheme.surfaceContainer
    	readonly property color surfaceContainerHigh: QuickshellTheme.surfaceContainerHigh

    	// Outlines & Borders
    	readonly property color outline: QuickshellTheme.outline
    	readonly property color outlineVariant: QuickshellTheme.outlineVariant

    	// Text & Foreground Content
    	readonly property color textSurface: QuickshellTheme.on_surface
    	readonly property color textSurfaceVariant: QuickshellTheme.on_surface_variant

    	// Primary Accents
    	readonly property color primary: QuickshellTheme.primary
    	readonly property color textPrimary: QuickshellTheme.on_primary
    	readonly property color primaryContainer: QuickshellTheme.primaryContainer
    	readonly property color textPrimaryContainer: QuickshellTheme.on_primary_container

    	// Secondary & Tertiary
    	readonly property color secondary: QuickshellTheme.secondary
    	readonly property color textSecondary: QuickshellTheme.on_secondary
    	readonly property color tertiary: QuickshellTheme.tertiary
    	readonly property color textTertiary: QuickshellTheme.on_tertiary

    	// Error
    	readonly property color error: QuickshellTheme.error
    	readonly property color textError: QuickshellTheme.on_error
    	readonly property color errorContainer: QuickshellTheme.errorContainer
    	readonly property color textErrorContainer: QuickshellTheme.on_error_container

    	// Semantic Shortcuts
    	readonly property color bg: background
    	readonly property color fg: textSurface
    	readonly property color accent: primary
    	readonly property color textMuted: textSurfaceVariant
    	readonly property color border: outlineVariant
    
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
