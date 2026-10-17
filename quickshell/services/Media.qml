pragma Singleton
pragma ComponentBehavior: Bound
import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.Mpris

QtObject {
	id: root

	readonly property MprisPlayer active: {
		const players = Mpris.players.values;
		for (let i = 0; i < players.length; i++) {
			if (players[i].isPlaying)
				return players[i];
		}
		return players.length > 0 ? players[0] : null;
	}

	readonly property bool hasActive: active !== null
	readonly property bool isPlaying: hasActive ? active.isPlaying : false
	readonly property string trackTitle: hasActive ? active.trackTitle : ""
	readonly property string trackArtist: hasActive ? active.trackArtist : ""
	readonly property real trackLength: hasActive ? active.length : 0.0
	readonly property real position: hasActive ? active.position : 0.0
	readonly property bool canGoNext: hasActive ? active.canGoNext : false
	readonly property bool canGoPrevious: hasActive ? active.canGoPrevious : false

	// Only schemes Qt Quick's Image can actually load (verified by probe:
	// file:// and http(s):// reach Ready; mpris:/qrc: cannot). Bare absolute
	// paths are normalised so players that emit them stay loadable.
	readonly property string trackArtSource: {
		if (!hasActive)
			return "";
		const url = active.trackArtUrl ?? "";
		if (url.startsWith("file://") || url.startsWith("http://") || url.startsWith("https://"))
			return url;
		if (url.startsWith("/"))
			return "file://" + url;
		return "";
	}

	readonly property bool canSeek: hasActive ? (active.canSeek && active.lengthSupported
			&& active.positionSupported && active.length > 0) : false

	function seekTo(fraction: real): void {
		if (canSeek)
			active.position = Math.min(Math.max(fraction, 0.0), 1.0) * active.length;
	}

	function toggle(): void {
		if (hasActive && active.canTogglePlaying)
			active.togglePlaying();
	}

	function next(): void {
		if (canGoNext)
			active.next();
	}

	function previous(): void {
		if (canGoPrevious)
			active.previous();
	}

	property IpcHandler ipc: IpcHandler {
		target: "mpris"

		function status(): string {
			const p = root.active;
			if (!p)
				return `players=${Mpris.players.values.length} active=none`;
			return `players=${Mpris.players.values.length} bus=${p.dbusName} id=${p.identity} playing=${p.isPlaying} title="${p.trackTitle}" artist="${p.trackArtist}" len=${p.length.toFixed(1)} pos=${p.position.toFixed(1)} canToggle=${p.canTogglePlaying} next=${p.canGoNext} prev=${p.canGoPrevious} canSeek=${root.canSeek} art="${root.trackArtSource}"`;
		}

		function toggle(): void {
			root.toggle();
		}

		function next(): void {
			root.next();
		}

		function previous(): void {
			root.previous();
		}

		function seekTo(fraction: real): void {
			root.seekTo(fraction);
		}
	}
}
