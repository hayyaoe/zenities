pragma Singleton
import QtQuick

QtObject {
	id: root

	// Raw date object
	property var now: new Date()

	// Formatted values
	readonly property string hours: Qt.formatDateTime(now, "hh")
	readonly property string minutes: Qt.formatDateTime(now, "mm")
	readonly property string seconds: Qt.formatDateTime(now, "ss")
	readonly property string time: `${hours}:${minutes}`

	// Date & Day
	readonly property string dayName: Qt.formatDateTime(now, "ddd")
	readonly property string dateString: Qt.formatDateTime(now, "ddd, dd MMM")
	readonly property string fullDate: Qt.formatDateTime(now, "dddd, dd MMMM yyyy")

	// 1-second interval timer
	property Timer timer: Timer {
		interval: 1000
		running: true
		repeat: true
		onTriggered: {
			root.now = new Date();
		}
	}
}
