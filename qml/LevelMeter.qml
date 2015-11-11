import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
	property double level

	Rectangle {
		anchors.fill: parent
		color: "#cccccc"

		Rectangle {
			id: levelGradient
			visible: false
			anchors.fill: parent
			gradient: Gradient {
				GradientStop { position: 0.0; color: "red" }
				GradientStop { position: 0.2; color: "yellow" }
				GradientStop { position: 0.3; color: "yellow" }
				GradientStop { position: 1.0; color: "green" }
			}
		}
		Rectangle {
			id: levelMask
			visible: false
			anchors.fill: parent
			color: "transparent"
			Rectangle {
				// mask
				anchors.bottom: parent.bottom
				width: parent.width
				height: parent.height * level / 20
			}
		}
		OpacityMask {
			anchors.fill: parent
			source: levelGradient
			maskSource: levelMask
		}
	}
}
