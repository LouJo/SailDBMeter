import QtQuick 2.0
import LJDBMeter 1.0

Item {
	property int fontSize: 50

	anchors.fill: parent

	Text {
		id: levelText
		width: parent.top * 0.8
		text: meter.level.toFixed(2) + " db"

		anchors.horizontalCenter : parent.horizontalCenter
		anchors.top: parent.top
		anchors.topMargin:20
		font.pixelSize: parent.fontSize
	}
	LevelMeter {
		id: levelMeter
		level: meter.level

		anchors.horizontalCenter : parent.horizontalCenter
		anchors.top: levelText.bottom
		anchors.topMargin: 40
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 60 
		width: parent.width * 0.8
	}
	DBMeter {
		id: meter
	}
	Component.onCompleted: {
		meter.running = 1
	}
}
