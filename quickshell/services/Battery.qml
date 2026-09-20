pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Services.UPower

import "../theme"

QtObject {
	id: root

	// Battery Device
	readonly property var device: UPower.displayDevice

	// Battery Presence Check
	readonly property bool isPresent: device ? device.isPresent : false

	// Percentage
	readonly property int percentage: {
		if (!device)
			return 0;
		let val = device.percentage;
		return val <= 1.0 ? Math.round(val * 100) : Math.round(val);
	}

	// Charging Status
	readonly property bool isCharging: {
		if (!device)
			return false;
		return device.state === UPowerDeviceState.Charging || device.state === UPowerDeviceState.PendingCharge;
	}

	// Battery Full Status
	readonly property bool isFull: {
		if (!device)
			return false;
		return device.state === UPowerDeviceState.FullyCharged;
	}

	// Time to empty or time to full in seconds
	readonly property real timeRemainingSeconds: {
		if (!device)
			return 0;
		return isCharging ? device.timeToFull : device.timeToEmpty;
	}

	// Readable time format
	readonly property string timeRemainingString: {
		if (!device || timeRemainingSeconds <= 0)
			return "";
		let totalMinutes = Math.round(timeRemainingSeconds / 60);
		let hours = Math.floor(totalMinutes / 60);
		let minutes = totalMinutes % 60;
		return hours > 0 ? `${hours}h ${minutes}m` : `${minutes}m`;
	}

	// Icons (Nerd Fonts)
	readonly property string icon: {
		if (!isPresent)
			return "󰂑";
		if (isCharging) {
			if (percentage >= 90)
				return "󰂅";
			if (percentage >= 80)
				return "󰂋";
			if (percentage >= 70)
				return "󰂊";
			if (percentage >= 60)
				return "󰂉";
			if (percentage >= 50)
				return "󰂈";
			if (percentage >= 40)
				return "󰂇";
			if (percentage >= 30)
				return "󰂆";
			if (percentage >= 20)
				return "󰢝";
			return "󰢜";
		}
		if (isFull || percentage >= 95)
			return "󰁹";
		if (percentage >= 80)
			return "󰂂";
		if (percentage >= 70)
			return "󰂁";
		if (percentage >= 60)
			return "󰂀";
		if (percentage >= 50)
			return "󰁿";
		if (percentage >= 40)
			return "󰁾";
		if (percentage >= 30)
			return "󰁽";
		if (percentage >= 20)
			return "󰁼";
		if (percentage >= 10)
			return "󰁻";
		return "󰁺";
	}

	// Dynamic Colors
	readonly property color statusColor: {
		if (isCharging)
			return Theme.primary;
		if (percentage <= 20)
			return Theme.error;
		if (percentage <= 35)
			return Theme.tertiary;
		return Theme.fg;
	}
}
