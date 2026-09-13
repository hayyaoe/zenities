pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

QtObject {
	id: root

	property FileView configFile: FileView {
		path: (Quickshell.env("XDG_CONFIG_HOME") || (Quickshell.env("HOME") + "/.config")) + "/zenities/config.json"
		watchChanges: true
		onFileChanged: reload()
		onAdapterUpdated: writeAdapter()
		Component.onCompleted: {
			reload();
		}

		JsonAdapter {
			id: settingsAdapter
			property bool darkMode: (Quickshell.env("ZENITIES_DARK_MODE") !== "false")
			property bool barFloating: false
			property bool barRounded: false
			property bool screenCorners: false
			property string wallpaperPath: Quickshell.env("ZENITIES_WALLPAPER") || ""
			property string barPosition: "top"
			property real scale: 1.0
		}
	}

	property bool darkMode: settingsAdapter.darkMode
	property bool barFloating: settingsAdapter.barFloating
	property bool barRounded: settingsAdapter.barRounded
	property bool screenCorners: settingsAdapter.screenCorners
	property string barPosition: settingsAdapter.barPosition || "top"
	property string wallpaperPath: settingsAdapter.wallpaperPath
	property real scale: settingsAdapter.scale || 1.0

	function setWallpaper(path) {
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

	// Bar Thickness
	readonly property int barThickness: Math.round(32 * scale)

	// Spacings
	readonly property int padding: Math.round(8 * scale)
	readonly property int spacing: Math.round(4 * scale)
	readonly property int barMargin: Math.round(8 * scale)

	// Rounding
	readonly property int radius: Math.round(12 * scale)

	// Screen Rounding
	readonly property int screenRadius: Math.round(16 * scale)

	// Typography
	readonly property string font: "IosevkaMono"

	// Animation Settings
	readonly property int animationDuration: 200
	readonly property var animationCurve: Easing.OutQuad
}
