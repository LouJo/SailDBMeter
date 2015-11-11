import QtQuick 2.0
import LJDBMeter 1.0

Item {
	id: pageMeter

	property int fontSize: 50
	property color textColor: "black"
	property color textColorPaused: "gray"
	property double level: meter.level
	property bool running: false
	property bool userRunning: true

	anchors.fill: parent

	Text {
		id: levelText
		width: parent.top * 0.8
		text: parent.level.toFixed(2) + " dB"

		anchors.horizontalCenter : parent.horizontalCenter
		anchors.top: parent.top
		anchors.topMargin:20
		font.pixelSize: parent.fontSize
		color: parent.userRunning ? parent.textColor : parent.textColorPaused
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
		running: pageMeter.running && pageMeter.userRunning

		onRunningChanged: console.log("DBMeter run " + running)
	}

	MouseArea {
		anchors.fill: parent
		onClicked: {
			console.log("click")
			parent.userRunning = parent.userRunning ? false : true
		}
	}
}
