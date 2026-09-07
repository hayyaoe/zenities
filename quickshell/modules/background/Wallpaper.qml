import QtQuick
import Quickshell
import Quickshell.Wayland
import "../../theme"

Variants{
	id: root
	model: Quickshell.screens

	delegate: PanelWindow{
		required property ShellScreen modelData
		screen: modelData

		anchors{
			top: true
			bottom: true
			left: true
			right: true
		}

		WlrLayershell.layer: WlrLayer.Background
		WlrLayershell.exclusionMode: ExclusionMode.Ignore
		WlrLayershell.keyboardFocus: WlrKeyboardFocus.None
		WlrLayershell.namespace: "zenities-wallpaper"

		color: "black"

	Image {
            id: bgImage
            anchors.fill: parent
            fillMode: Image.PreserveAspectCrop
            asynchronous: true
            sourceSize: Qt.size(modelData.width, modelData.height)

            source: (Theme.wallpaperPath && Theme.wallpaperPath.startsWith("/")) 
                ? ("file://" + Theme.wallpaperPath) 
                : ""

            opacity: status === Image.Ready ? 1 : 0

            Behavior on opacity {
                NumberAnimation {
                    duration: Theme.animationDuration
                    easing.type: Theme.animationCurve
                }
            }
    	}
    }
}
