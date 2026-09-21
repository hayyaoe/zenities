pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

QtObject {
	id: root

	// Public property
	readonly property real brightness: parseFloat(brightnessRaw) / 100.0

	// Internal property for cache
	property string brightnessRaw: "0.0"

	// Update brightness value
	function updateBrightness(): void {
		brightnessGet.exec(brightnessGet.command);
	}

	// Brightness adjust function
	function setBrightness(pct: real): void {
		const pctInt = Math.round(pct * 100);
		Quickshell.execDetached(["brightnessctl", "set", pctInt + "%"]);
		updateTimer.restart();
	}

	// Timer to trigger update after execDetached execution
	property Timer updateTimer: Timer {
		interval: 50
		onTriggered: updateBrightness()
	}

	// Get brightness status
	property Process brightnessGet: Process {
		command: ["brightnessctl", "-m"]
		stdout: SplitParser {
			onRead: text => {
				const parts = text.split(",");
				if (parts.length >= 4) {
					const pctStr = parts[3].replace("%", "");
					root.brightnessRaw = pctStr.trim() || "0.0";
				}
			}
		}
	}

	property Timer pollTimer: Timer {
		interval: 2000
		running: true
		repeat: true
		triggeredOnStart: true
		onTriggered: updateBrightness()
	}

	property IpcHandler ipc: IpcHandler {
		target: "brightness"
		function update(): void {
			root.updateBrightness();
		}
	}
}
