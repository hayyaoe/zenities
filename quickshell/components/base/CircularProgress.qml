import QtQuick
import QtQuick.Shapes
import "../../theme"

Item {
	id: root
	property real value: 0.0
	property color trackColor: Theme.surfaceContainerHigh
	property color progressColor: Theme.primary
	property real strokeWidth: 4 * Theme.scale
	property real size: Math.round(16 * Theme.scale)

	width: size
	height: size

	layer.enabled: true
	layer.samples: 4

	property real targetAngle: Math.min(Math.max(value, 0), 1) * 360
	Behavior on targetAngle {
		NumberAnimation {
			duration: 400
			easing.type: Easing.OutCubic
		}
	}

	Shape {
		anchors.fill: parent

		ShapePath {
			strokeColor: root.trackColor
			strokeWidth: root.strokeWidth
			fillColor: "transparent"
			capStyle: ShapePath.FlatCap
			PathAngleArc {
				centerX: root.width * 0.5
				centerY: root.height * 0.5
				radiusX: root.width * 0.4
				radiusY: root.height * 0.4
				startAngle: -90
				sweepAngle: 360
			}
		}

		ShapePath {
			strokeColor: root.progressColor
			strokeWidth: root.strokeWidth
			fillColor: "transparent"
			capStyle: ShapePath.FlatCap
			PathAngleArc {
				centerX: root.width * 0.5
				centerY: root.height * 0.5
				radiusX: root.width * 0.4
				radiusY: root.height * 0.4
				startAngle: -90
				sweepAngle: root.targetAngle
			}
		}
	}
}
