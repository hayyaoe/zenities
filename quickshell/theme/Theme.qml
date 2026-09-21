pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

QtObject {
	id: root

	readonly property FileView configFile: ConfigLoader.configFile
	readonly property bool darkMode: ConfigLoader.darkMode
	readonly property bool barFloating: ConfigLoader.barFloating
	readonly property bool barRounded: ConfigLoader.barRounded
	readonly property bool screenCorners: ConfigLoader.screenCorners
	readonly property string barPosition: ConfigLoader.barPosition
	readonly property string wallpaperPath: ConfigLoader.wallpaperPath
	readonly property real scale: ConfigLoader.scale

	function setWallpaper(path) {
		ConfigLoader.setWallpaper(path);
	}

	function setDarkMode(enabled) {
		ConfigLoader.setDarkMode(enabled);
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

	// Bar
	readonly property int barThickness: Math.round(32 * scale)

	// Bar Widgets
	// Sizing
	readonly property int widgetSize: Math.round(26 * scale)
	readonly property int widgetRadius: Math.round(widgetSize / 2)
	readonly property int widgetPadding: Math.round(4 * scale)

	// Spacings
	readonly property int padding: Math.round(8 * scale)
	readonly property int spacing: Math.round(4 * scale)
	readonly property int barMargin: Math.round(8 * scale)

	// Container Rounding
	readonly property int radius: Math.round(12 * scale)

	// Screen Rounding
	readonly property int screenRadius: Math.round(16 * scale)

	// Typography
	readonly property string font: "IosevkaMono"

	// Text Size
	readonly property int fontSmall: Math.round(8 * scale)
	readonly property int fontNormal: Math.round(10 * scale)
	readonly property int fontLarge: Math.round(12 * scale)

	// Icons Size
	readonly property int iconSmall: Math.round(9 * scale)
	readonly property int iconNormal: Math.round(14 * scale)

	// Animation Settings
	readonly property int animationDuration: 200
	readonly property var animationCurve: Easing.OutQuad
}
