pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

import "../theme"

QtObject {
	id: root

	property real volumeCache: 0.0
	property bool mutedCache: false
	property bool sinkPresent: false

	property real inputVolumeCache: 0.0
	property bool inputMutedCache: false
	property bool sourcePresent: false

	readonly property bool isReady: sinkPresent
	readonly property real volume: volumeCache
	readonly property int volumePercent: Math.round(Math.min(volume, 1.0) * 100)
	readonly property bool muted: sinkPresent ? mutedCache : true

	function setVolume(pct: real): void {
		const v = Math.min(Math.max(pct, 0.0), 1.0);
		if (Math.abs(v - volumeCache) < 0.005 && !(v > 0.0 && mutedCache))
			return;
		Quickshell.execDetached(["pactl", "set-sink-volume", "@DEFAULT_SINK@", Math.round(v * 100) + "%"]);
		if (v > 0.0 && mutedCache)
			Quickshell.execDetached(["pactl", "set-sink-mute", "@DEFAULT_SINK@", "0"]);
		volumeCache = v;
		if (v > 0.0)
			mutedCache = false;
	}

	function setMuted(m: bool): void {
		Quickshell.execDetached(["pactl", "set-sink-mute", "@DEFAULT_SINK@", m ? "1" : "0"]);
		mutedCache = m;
	}

	function toggleMute(): void {
		setMuted(!muted);
	}

	readonly property real inputVolume: inputVolumeCache
	readonly property int inputVolumePercent: Math.round(Math.min(inputVolume, 1.0) * 100)
	readonly property bool inputMuted: sourcePresent ? inputMutedCache : true

	function setInputVolume(pct: real): void {
		const v = Math.min(Math.max(pct, 0.0), 1.0);
		if (Math.abs(v - inputVolumeCache) < 0.005)
			return;
		Quickshell.execDetached(["pactl", "set-source-volume", "@DEFAULT_SOURCE@", Math.round(v * 100) + "%"]);
		inputVolumeCache = v;
	}

	function setInputMuted(m: bool): void {
		Quickshell.execDetached(["pactl", "set-source-mute", "@DEFAULT_SOURCE@", m ? "1" : "0"]);
		inputMutedCache = m;
	}

	function toggleInputMute(): void {
		setInputMuted(!inputMuted);
	}

	function parseVolume(text: string, isSink: bool): void {
		const m = text.match(/^Volume:.*?([0-9]+)%/);
		if (!m)
			return;
		const v = parseInt(m[1]) / 100.0;
		if (isSink) {
			sinkPresent = true;
			volumeCache = v;
		} else {
			sourcePresent = true;
			inputVolumeCache = v;
		}
	}

	function parseMute(text: string, isSink: bool): void {
		const m = text.match(/^Mute: (yes|no)/);
		if (!m)
			return;
		if (isSink)
			mutedCache = m[1] === "yes";
		else
			inputMutedCache = m[1] === "yes";
	}

	function update(): void {
		sinkGet.exec(sinkGet.command);
		sinkMuteGet.exec(sinkMuteGet.command);
		sourceGet.exec(sourceGet.command);
		sourceMuteGet.exec(sourceMuteGet.command);
	}

	property Process sinkGet: Process {
		command: ["pactl", "get-sink-volume", "@DEFAULT_SINK@"]
		stdout: SplitParser {
			onRead: text => root.parseVolume(text, true)
		}
	}

	property Process sinkMuteGet: Process {
		command: ["pactl", "get-sink-mute", "@DEFAULT_SINK@"]
		stdout: SplitParser {
			onRead: text => root.parseMute(text, true)
		}
	}

	property Process sourceGet: Process {
		command: ["pactl", "get-source-volume", "@DEFAULT_SOURCE@"]
		stdout: SplitParser {
			onRead: text => root.parseVolume(text, false)
		}
	}

	property Process sourceMuteGet: Process {
		command: ["pactl", "get-source-mute", "@DEFAULT_SOURCE@"]
		stdout: SplitParser {
			onRead: text => root.parseMute(text, false)
		}
	}

	property Process events: Process {
		command: ["pactl", "subscribe"]
		running: true
		stdout: SplitParser {
			onRead: line => {
				if (line.indexOf("on sink") !== -1 || line.indexOf("on source") !== -1 || line.indexOf("on server") !== -1)
					root.update();
			}
		}
		onStarted: root.update()
		onExited: reconnectTimer.restart()
	}

	property Timer reconnectTimer: Timer {
		interval: 2000
		onTriggered: root.events.exec(root.events.command)
	}

	property IpcHandler ipc: IpcHandler {
		target: "audio"
		function update(): void {
			root.update();
		}

		function status(): string {
			return `sinkPresent=${root.sinkPresent} vol=${root.volumeCache} muted=${root.mutedCache} sourcePresent=${root.sourcePresent} inVol=${root.inputVolumeCache}`;
		}
	}

	readonly property string icon: {
		if (!sinkPresent || muted || volume <= 0.0)
			return "";
		if (volume < 0.5)
			return "";
		return "";
	}

	component GlyphMetric: TextMetrics {
		required property int codePoint
		font.family: Theme.font
		font.pixelSize: Theme.fontLarge
		text: String.fromCharCode(codePoint)
	}

	property GlyphMetric metricXmark: GlyphMetric {
		codePoint: 0xF026
	}
	property GlyphMetric metricLow: GlyphMetric {
		codePoint: 0xF027
	}
	property GlyphMetric metricHigh: GlyphMetric {
		codePoint: 0xF028
	}
	readonly property real iconAdvanceMax: Math.max(metricXmark.width, metricLow.width, metricHigh.width)

	readonly property string inputIcon: {
		if (!sourcePresent || inputMuted || inputVolume <= 0.0)
			return "";
		return "";
	}

	readonly property color statusColor: (muted || volume <= 0.0) ? Theme.textMuted : Theme.fg
}
