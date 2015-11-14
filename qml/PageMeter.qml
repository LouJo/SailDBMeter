import QtQuick 2.0
import LJDBMeter 1.0

Item {
	id: pageMeter

	property int fontSize: 50
	property int textMaxFontSize: 14
	property color textColor: "black"
	property color textColorPaused: "gray"
	property double level: meter.level
	property double levelMax: maxBar.level
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
		level: parent.level

		//anchors.horizontalCenter : parent.horizontalCenter
		anchors.left: parent.left
		anchors.leftMargin: parent.width / 8
		anchors.top: levelText.bottom
		anchors.topMargin: 40
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 60 
		width: parent.width / 4
	}
	Rectangle {
		id: maxBar

		signal reset()

		property int counter: 0
		property int delayMs: 2000
		property int counterMax: delayMs / meter.computeFrameMs
		property double level: 0
		property double ref: parent.level

		width: levelMeter.width
		height: 2
		color: parent.userRunning ? parent.textColor : parent.textColorPaused
		anchors.left: levelMeter.left
		anchors.bottom: levelMeter.bottom
		anchors.bottomMargin: Math.min(100, level) / 100 * levelMeter.height

		onRefChanged: {
			if (ref >= level) {
				level = ref
				counter = 0
			}
			else if (counter++ >= counterMax) {
				level = ref
				counter = 0
			}
		}

		onReset: { level = ref; counter = 0 }
	}
	Text {
		id: maxText
		color: parent.userRunning ? parent.textColor : parent.textColorPaused
		text: maxBar.level.toFixed(2) + " dB"
		anchors.left: maxBar.right
		anchors.verticalCenter: maxBar.verticalCenter
		anchors.leftMargin: 10
		font.pixelSize: parent.textMaxFontSize
	}
	DBMeter {
		id: meter
		running: pageMeter.running && pageMeter.userRunning

		onRunningChanged: {
			console.log("DBMeter run " + running)
			if (running) maxBar.reset()
		}
	}

	MouseArea {
		anchors.fill: parent
		onClicked: {
			console.log("click")
			parent.userRunning = parent.userRunning ? false : true
		}
	}
}
