import QtQuick 2.0
import Sailfish.Silica 1.0

CoverBackground {
	id: cover

	property double level: 0
	property double maxLevel: 0
	property double avgLevel: 0

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
		text: parent.level.toFixed(2) + " dB"
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.top: coverLabel.bottom
		anchors.topMargin: Theme.paddingLarge
		color: Theme.primaryColor
		font.pixelSize: 40
	}

	Text {
		id: coverMaxLevel
		text: "max: " + parent.maxLevel.toFixed(2) + " dB"
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.top: coverLevel.bottom
		anchors.topMargin: Theme.paddingLarge
		color: Theme.primaryColor
		font.pixelSize: 30
	}

	Text {
		id: coverAvgLevel
		text: "avg: " + parent.avgLevel.toFixed(2) + " dB"
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.top: coverMaxLevel.bottom
		anchors.topMargin: Theme.paddingLarge
		color: Theme.primaryColor
		font.pixelSize: 30
	}
}
