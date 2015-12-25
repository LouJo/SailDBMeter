import QtQuick 2.0
import Sailfish.Silica 1.0

CoverBackground {
	id: cover

	property double level: 0
	property double maxLevel: 0
	property double avgLevel: 0

	LevelMeter {
		id: levelMeter
		anchors.top: parent.top
		anchors.topMargin: parent.height / 8
		anchors.left: parent.left
		anchors.leftMargin: parent.width / 12
		width: parent.width / 8
		height: parent.height * 6 / 8
		level: parent.level
	}

	Item {
		anchors.top: parent.top
		anchors.left: levelMeter.right
		anchors.right: parent.right
		anchors.topMargin: parent.height / 12

		Label {
			id: coverLabel
			text: "dB Meter"
			anchors.horizontalCenter: parent.horizontalCenter
			anchors.top: parent.top
			anchors.topMargin: Theme.paddingLarge
			anchors.bottomMargin: Theme.paddingLarge
		}
		Text {
			id: coverLevel
			text: level.toFixed(2) + " dB"
			anchors.horizontalCenter: parent.horizontalCenter
			anchors.top: coverLabel.bottom
			anchors.topMargin: Theme.paddingLarge
			color: Theme.primaryColor
			font.pixelSize: 35
		}

		Text {
			id: coverMaxLevel
			text: "max: " + maxLevel.toFixed(2) + " dB"
			anchors.horizontalCenter: parent.horizontalCenter
			anchors.top: coverLevel.bottom
			anchors.topMargin: Theme.paddingLarge
			color: Theme.primaryColor
			font.pixelSize: 28
		}

		Text {
			id: coverAvgLevel
			text: "avg: " + avgLevel.toFixed(2) + " dB"
			anchors.horizontalCenter: parent.horizontalCenter
			anchors.top: coverMaxLevel.bottom
			anchors.topMargin: Theme.paddingLarge
			color: Theme.primaryColor
			font.pixelSize: 28
		}
	}
}
