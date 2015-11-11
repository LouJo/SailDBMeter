import QtQuick 2.0
import LJDBMeter 1.0

Item {
	property int fontSize: 50
	property color textColor: "black"

	anchors.fill: parent

	Text {
		id: levelText
		width: parent.top * 0.8
		text: meter.level.toFixed(2) + " dB"

		anchors.horizontalCenter : parent.horizontalCenter
		anchors.top: parent.top
		anchors.topMargin:20
		font.pixelSize: parent.fontSize
		color: parent.textColor
	}
	LevelMeter {
		id: levelMeter
		level: meter.level

		//anchors.horizontalCenter : parent.horizontalCenter
		anchors.left: parent.left
		anchors.leftMargin: parent.width / 8
		anchors.top: levelText.bottom
		anchors.topMargin: 40
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 60 
		width: parent.width / 4
	}
	DBMeter {
		id: meter
	}
	Component.onCompleted: {
		meter.running = 1
	}
}
