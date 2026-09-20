import QtQuick
import "../../theme"
import "../../components"
import "../../components/base"

Item {
	id: root
	anchors.fill: parent

	// States & Properties
	readonly property bool isFloating: Theme.barFloating
	readonly property string position: Theme.barPosition || "top"

	// Screen Corners
	Repeater {
		model: 4

		CornerShape {
			x: (index === 1 || index === 2) ? parent.width - width : 0
			y: (index >= 2) ? parent.height - height : 0
			rotation: index * 90

			visible: {
				if (root.isFloating)
					return true;
				let pos = root.position;
				if (index === 0)
					return pos !== "top" && pos !== "left";
				if (index === 1)
					return pos !== "top" && pos !== "right";
				if (index === 2)
					return pos !== "bottom" && pos !== "right";
				if (index === 3)
					return pos !== "bottom" && pos !== "left";
				return true;
			}
		}
	}
}
