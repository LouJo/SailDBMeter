import QtQuick 2.0
import Sailfish.Silica 1.0

/**
 * Silica page with level meter and average indicator
 *
 * Need reference to meter object that provide level,
 * running and avgLevel, avgMinLevel and avgMaxLevel values
 *
 */

Page {
	id: pageMeter

	property int fontSize: 100
	property int fontSizeLabel: 40
	property int fontSizeLevel: 70
	property int fontSizeTime: 50
	property int topMarginElement: 30

	property color textColor: meter.running ? Theme.primaryColor : Theme.secondaryColor

	property QtObject meter

	property int avgTimeSec: meter.avgCounter * meter.computeFrameMs / 1000

	signal togglePause()
	signal resetAverage()

	allowedOrientations: Orientation.All

	SilicaFlickable {
		anchors.fill: parent

		Menu {
		}

		Text {
			id: levelText
			width: parent.top * 0.8
			text: pageMeter.meter.level.toFixed(2) + " dB"

			anchors.horizontalCenter : parent.horizontalCenter
			anchors.top: parent.top
			anchors.topMargin:20
			font.pixelSize: pageMeter.fontSize
			color: pageMeter.textColor
		}

		LevelMeter {
			id: levelMeter
			level: pageMeter.meter.level

			anchors.left: parent.left
			anchors.leftMargin: parent.width / 8
			anchors.top: levelText.bottom
			anchors.topMargin: 40
			anchors.bottom: parent.bottom
			anchors.bottomMargin: 60
			width: parent.width / 8
		}

		Rectangle {
			id: minMaxBar
			width: levelMeter.width
			height: 2
			color: pageMeter.textColor
			opacity: 0.5

			property int yTop: Math.min(100, pageMeter.meter.avgMaxLevel) / 100 * levelMeter.height
			property int yBottom: Math.min(100, pageMeter.meter.avgMinLevel) / 100 * levelMeter.height

			Behavior on yTop {
				NumberAnimation {
					duration: 2000
					easing.type: Easing.Linear
					easing.amplitude: levelMeter.height
				}
			}

			Behavior on yBottom {
				NumberAnimation {
					duration: 2000
					easing.type: Easing.Linear
					easing.amplitude: levelMeter.height
				}
			}

			anchors.left: levelMeter.left

			anchors.top: levelMeter.top
			anchors.topMargin: levelMeter.height - yTop
			anchors.bottom: levelMeter.bottom
			anchors.bottomMargin: yBottom
		}

		MouseArea {
			anchors.fill: parent
			onClicked: {
				pageMeter.togglePause()
			}
		}

		Item {
			anchors.left: levelMeter.right
			anchors.leftMargin: parent.width / 8
			anchors.right: parent.right
			anchors.rightMargin: parent.width / 8
			anchors.top: levelMeter.top
			anchors.topMargin: levelMeter.height / 8

			Label {
				id: timeLabel
				text: qsTr("Time")
				font.pixelSize: pageMeter.fontSizeLabel
				color: pageMeter.textColor
				anchors.horizontalCenter: parent.horizontalCenter
				anchors.top: parent.top
			}
			Text {
				id: timeText
				text: avgTimeSec + " sec"
				font.pixelSize: pageMeter.fontSizeTime
				color: pageMeter.textColor
				anchors.horizontalCenter: parent.horizontalCenter
				anchors.top: timeLabel.bottom
				anchors.topMargin: pageMeter.topMarginElement
			}
			Label {
				id: avgLabel
				text: qsTr("Average")
				font.pixelSize: pageMeter.fontSizeLabel
				color: pageMeter.textColor
				anchors.horizontalCenter: parent.horizontalCenter
				anchors.top: timeText.bottom
				anchors.topMargin: pageMeter.topMarginElement
			}
			Text {
				id: avgText
				text: pageMeter.meter.avgLevel.toFixed(1) + " dB"
				font.pixelSize: pageMeter.fontSizeLevel
				color: pageMeter.textColor
				anchors.horizontalCenter: parent.horizontalCenter
				anchors.top: avgLabel.bottom
				anchors.topMargin: pageMeter.topMarginElement
			}
			Button {
				text: qsTr("Reset")
				onClicked: {
					console.log("reset avg")
					pageMeter.resetAverage()
				}
				color: pageMeter.textColor
				anchors.horizontalCenter: parent.horizontalCenter
				anchors.top: avgText.bottom
				anchors.topMargin: pageMeter.topMarginElement
			}
		}
	}
}
