pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

QtObject {
	id: root

	property var invalidKeys: ({})

	property string lastValidatedText: ""

	property int transientRetries: 0

	property Timer settleTimer: Timer {
		interval: 400
		onTriggered: root.configFile.reload()
	}

	function retryLoad() {
		if (transientRetries < 2) {
			transientRetries++;
			settleTimer.restart();
			return true;
		}
		return false;
	}

	function reportConfigError(messages) {
		var text = messages.join("\n");
		console.warn("[zenities] Config validation error:\n" + text);
		Quickshell.execDetached(["notify-send", "-a", "zenities", "Zenities Config Error", text]);
	}

	function configChecks(raw) {
		return [
			{
				key: "darkMode",
				ok: typeof raw.darkMode === "boolean",
				message: "darkMode must be a boolean"
			},
			{
				key: "barFloating",
				ok: typeof raw.barFloating === "boolean",
				message: "barFloating must be a boolean"
			},
			{
				key: "barRounded",
				ok: typeof raw.barRounded === "boolean",
				message: "barRounded must be a boolean"
			},
			{
				key: "screenCorners",
				ok: typeof raw.screenCorners === "boolean",
				message: "screenCorners must be a boolean"
			},
			{
				key: "barPosition",
				ok: ["top", "bottom", "left", "right"].indexOf(raw.barPosition) !== -1,
				message: "barPosition must be one of: top, bottom, left, right"
			},
			{
				key: "scale",
				ok: typeof raw.scale === "number" && isFinite(raw.scale) && raw.scale > 0,
				message: "scale must be a positive number"
			},
			{
				key: "wallpaperPath",
				ok: typeof raw.wallpaperPath === "string",
				message: "wallpaperPath must be a string"
			}
		];
	}

	function validateConfig() {
		if (!configFile.loaded)
			return;

		var text = configFile.text();
		if (text === lastValidatedText)
			return;
		lastValidatedText = text;

		var raw;
		try {
			raw = JSON.parse(text);
		} catch (e) {
			if (retryLoad())
				return;
			invalidKeys = ({});
			reportConfigError(["config.json is not valid JSON. Using defaults."]);
			return;
		}
		if (typeof raw !== "object" || raw === null) {
			if (retryLoad())
				return;
			invalidKeys = ({});
			reportConfigError(["config.json must contain a JSON object. Using defaults."]);
			return;
		}
		transientRetries = 0;

		var map = ({});
		var messages = [];
		var checks = configChecks(raw);
		for (var i = 0; i < checks.length; ++i) {
			if (checks[i].key in raw && !checks[i].ok) {
				map[checks[i].key] = true;
				messages.push(checks[i].message + " (using default)");
			}
		}
		invalidKeys = map;
		if (messages.length !== 0)
			reportConfigError(messages);
	}

	function clearInvalid(key) {
		if (!(key in invalidKeys))
			return;
		var map = ({});
		for (var k in invalidKeys) {
			if (k !== key)
				map[k] = true;
		}
		invalidKeys = map;
	}

	property FileView configFile: FileView {
		path: (Quickshell.env("XDG_CONFIG_HOME") || (Quickshell.env("HOME") + "/.config")) + "/zenities/config.json"
		watchChanges: true
		onFileChanged: root.settleTimer.restart()
		onLoaded: {
			root.validateConfig();
		}
		onLoadFailed: error => {
			if (retryLoad())
				return;
			if (error.type === FileViewError.FileNotFound) {
				reportConfigError(["config.json was not found. Using defaults."]);
				return;
			}
			reportConfigError(["config.json could not be read: " + FileViewError.toString(error)]);
		}
		onAdapterUpdated: {
			writeAdapter();
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

	property bool darkMode: invalidKeys.darkMode ? (Quickshell.env("ZENITIES_DARK_MODE") !== "false") : settingsAdapter.darkMode
	property bool barFloating: invalidKeys.barFloating ? false : settingsAdapter.barFloating
	property bool barRounded: invalidKeys.barRounded ? false : settingsAdapter.barRounded
	property bool screenCorners: invalidKeys.screenCorners ? false : settingsAdapter.screenCorners
	property string barPosition: invalidKeys.barPosition ? "top" : (settingsAdapter.barPosition || "top")
	property string wallpaperPath: invalidKeys.wallpaperPath ? "" : settingsAdapter.wallpaperPath
	property real scale: invalidKeys.scale ? 1.0 : (settingsAdapter.scale || 1.0)

	function setWallpaper(path) {
		settingsAdapter.wallpaperPath = path;
		root.clearInvalid("wallpaperPath");
	}

	function setDarkMode(enabled) {
		settingsAdapter.darkMode = enabled;
		root.clearInvalid("darkMode");
	}
}
