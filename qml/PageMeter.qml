import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.saildbmeter.dbmeter 1.0

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

	property double gainForPhone: 160000
	property double gainForTablet: 2000

	property double postGainForPhone: 1
	property double postGainForTablet: 1.4

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
	MaxBar {
		id: maxBar
		ref: parent.level
		anchors.left: levelMeter.left
		anchors.bottom: levelMeter.bottom
		height: levelMeter.height
		barWidth: levelMeter.width
		color: parent.userRunning ? parent.textColor : parent.textColorPaused
		textMaxFontSize: parent.textMaxFontSize
		computeFrameMs: meter.computeFrameMs
	}
	DBMeter {
		id: meter
		running: pageMeter.running && pageMeter.userRunning
		gain: (Screen.sizeCategory > Screen.Medium) ? pageMeter.gainForTablet : pageMeter.gainForPhone
		postGain: (Screen.sizeCategory > Screen.Medium) ? pageMeter.postGainForTablet : pageMeter.postGainForPhone

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
