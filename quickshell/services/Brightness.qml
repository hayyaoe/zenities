pragma Singleton
pragma ComponentBehavior: Bound
import QtQuick
import Quickshell
import Quickshell.Io

QtObject {
	id: root

	property list<Monitor> monitors: variants.instances
	property string device: ""
	property int maxBrightness: 1
	property string connector: ""
	property var ddcMap: ({})

	function forScreen(name: string): Monitor {
		for (let i = 0; i < monitors.length; i++) {
			if (monitors[i].modelData.name === name)
				return monitors[i];
		}
		return null;
	}

	function onEventLine(line: string): void {
		if (root.device === "" || line.indexOf("/" + root.device) === -1)
			return;
		root.ctlGet.exec(root.ctlGet.command);
	}

	function onBrightnessRead(raw: int): void {
		for (let i = 0; i < root.monitors.length; i++) {
			if (root.monitors[i].isInternal)
				root.monitors[i].brightness = Math.min(raw / root.maxBrightness, 1.0);
		}
	}

	function parseDdc(text: string): void {
		const out = ({});
		for (const block of text.trim().split("\n\n")) {
			if (!block.startsWith("Display "))
				continue;
			const bus = block.match(/I2C bus:[ ]*\/dev\/i2c-([0-9]+)/);
			const conn = block.match(/DRM connector:\s+(.*)/);
			if (bus && conn)
				out[conn[1].replace(/^card\d+-/, "")] = ({
						"busNum": bus[1]
					});
		}
		root.ddcMap = out;
	}

	property Variants variants: Variants {
		id: variants
		model: Quickshell.screens
		Monitor {}
	}

	onMonitorsChanged: {
		root.ctlProbe.exec(root.ctlProbe.command);
		root.ddcDetect.exec(root.ddcDetect.command);
	}

	property Process ctlProbe: Process {
		command: ["brightnessctl", "i", "-m"]
		running: true
		stdout: SplitParser {
			onRead: line => {
				const parts = line.split(",");
				root.device = parts[0];
				const max = parseInt(parts[parts.length - 1]);
				if (max > 0)
					root.maxBrightness = max;
			}
		}
	}

	property Process connectorProbe: Process {
		command: ["readlink", "-f", "/sys/class/backlight/" + root.device]
		stdout: SplitParser {
			onRead: line => {
				const m = line.match(/card\d+-([^/]+)\//);
				if (m)
					root.connector = m[1];
			}
		}
	}
	onDeviceChanged: if (device !== "")
		connectorProbe.exec(["readlink", "-f", "/sys/class/backlight/" + device])

	property Process ctlGet: Process {
		command: ["brightnessctl", "-d", root.device, "g"]
		stdout: SplitParser {
			onRead: line => {
				const raw = parseInt(line);
				if (!isNaN(raw))
					root.onBrightnessRead(raw);
			}
		}
	}
	onConnectorChanged: if (connector !== "")
		ctlGet.exec(ctlGet.command)

	property Process ddcDetect: Process {
		command: ["ddcutil", "detect", "--brief"]
		running: true
		stdout: StdioCollector {
			onStreamFinished: root.parseDdc(text)
		}
	}

	property Process events: Process {
		command: ["udevadm", "monitor", "--kernel", "--subsystem-match=backlight"]
		running: true
		stdout: SplitParser {
			onRead: line => root.onEventLine(line)
		}
		onExited: reconnectTimer.restart()
	}

	property Timer reconnectTimer: Timer {
		interval: 2000
		onTriggered: root.events.exec(root.events.command)
	}

	property IpcHandler ipc: IpcHandler {
		target: "brightness"
		function status(): string {
			let out = `device=${root.device} connector=${root.connector}`;
			for (let i = 0; i < root.monitors.length; i++) {
				const m = root.monitors[i];
				out += ` | ${m.modelData.name}:${m.backend}:${Math.round(m.brightness * 100)}%`;
			}
			return out;
		}
	}

	component Monitor: QtObject {
		id: mon

		required property ShellScreen modelData

		readonly property bool isInternal: root.connector !== "" && root.connector === modelData.name
		readonly property bool isDdc: root.ddcMap[modelData.name] !== undefined
		readonly property bool isControllable: isInternal || isDdc
		readonly property string backend: isInternal ? "internal" : (isDdc ? "ddc" : "none")
		readonly property string ddcBus: isDdc ? root.ddcMap[modelData.name].busNum : ""

		property real brightness: 0.0
		property real queuedBrightness: NaN

		readonly property Timer ddcQueue: Timer {
			interval: 500
			onTriggered: {
				if (!isNaN(mon.queuedBrightness)) {
					const q = mon.queuedBrightness;
					mon.queuedBrightness = NaN;
					mon.setBrightness(q);
				}
			}
		}

		readonly property Process ddcInit: Process {
			command: ["ddcutil", "-b", mon.ddcBus, "getvcp", "10", "--brief"]
			stdout: SplitParser {
				onRead: line => {
					const m = line.match(/[Vv]alue\D+(\d+)\D+[Mm]ax\D+(\d+)/) || line.match(/(\d+)\s*\/\s*(\d+)/);
					if (m)
						mon.brightness = Math.min(parseInt(m[1]) / parseInt(m[2]), 1.0);
				}
			}
		}
		onDdcBusChanged: if (mon.isDdc)
			mon.ddcInit.exec(mon.ddcInit.command)

		function setBrightness(pct: real): void {
			const v = Math.min(Math.max(pct, 0.0), 1.0);
			if (mon.isInternal) {
				Quickshell.execDetached(["brightnessctl", "-d", root.device, "set", Math.round(v * 100) + "%"]);
			} else if (mon.isDdc) {
				if (mon.ddcQueue.running) {
					mon.queuedBrightness = v;
					return;
				}
				mon.brightness = v;
				Quickshell.execDetached(["ddcutil", "-b", mon.ddcBus, "setvcp", "10", "" + Math.round(v * 100)]);
				mon.ddcQueue.restart();
			}
		}
	}
}
