import QtQuick
import QtQuick.Shapes
import "../theme"

Shape {
	id: root

	// properties
	property int radius: Theme.screenRadius
	property color color: Theme.surface

	// Geometry
	width: radius
	height: radius

	// Quality
	layer.enabled: true
	layer.samples: 4

	// Corner Vector Path
	ShapePath {
		fillColor: root.color
		strokeColor: "transparent"
		startX: 0
		startY: 0
		PathLine {
			x: root.radius
			y: 0
		}
		PathArc {
			x: 0
			y: root.radius
			radiusX: root.radius
			radiusY: root.radius
			direction: PathArc.Counterclockwise
		}
		PathLine {
			x: 0
			y: 0
		}
	}
}
