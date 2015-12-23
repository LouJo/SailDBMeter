import QtQuick 2.0
import Sailfish.Silica 1.0

Item {
	id: pageMeter

	property int fontSize: 50
	property int textMaxFontSize: 14
	property color textColor: "black"
	property color textColorPaused: "gray"
	property double level
	property double levelMax: maxBar.level
	property bool running: false
	property alias computeFrameMs: maxBar.computeFrameMs

	anchors.fill: parent

	Text {
		id: levelText
		width: parent.top * 0.8
		text: parent.level.toFixed(2) + " dB"

		anchors.horizontalCenter : parent.horizontalCenter
		anchors.top: parent.top
		anchors.topMargin:20
		font.pixelSize: parent.fontSize
		color: parent.running ? parent.textColor : parent.textColorPaused
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
		color: parent.running ? parent.textColor : parent.textColorPaused
		textMaxFontSize: parent.textMaxFontSize
	}

	onRunningChanged: {
		console.log("DBMeter pageMeter run " + running)
		if (running) maxBar.reset()
	}
}
