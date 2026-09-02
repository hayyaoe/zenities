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
		WlrLayershell.namespace: "zenities-wallpaper"

		color: "black"

		Image{
			id: bgImage
			anchors.fill: parent
			fillMode: Image.PreserveAspectCrop
			asynchronous: true
			source: Theme.wallpaperPath
			opacity: 0

			sourceSize: Qt.size(modelData.width, modelData.height)

			onStatusChanged:{
				if(status === Image.Ready){
					opacity = 1
				}else if(status === Image.Loading){
					opacity = 0
				}
			}

			Behavior on opacity{
				NumberAnimation{
					duration: Theme.animationDuration
					easing.type: Theme.animationCurve
				}
			}
		}
	}
}
