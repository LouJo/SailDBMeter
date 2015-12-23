import QtQuick 2.0
import Sailfish.Silica 1.0

/**
 * Silica page with level meter and average indicator
 *
 * Need reference to meter object that provide level,
 * running and avgLevel values
 *
 */

Page {
	id: pageMeter

	property int fontSize: 50
	property color textColor: meter.running ? Theme.primaryColor : Theme.secondaryColor

	property QtObject meter

	signal togglePause()
	signal resetAverage()

	anchors.fill: parent

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

			//anchors.horizontalCenter : parent.horizontalCenter
			anchors.left: parent.left
			anchors.leftMargin: parent.width / 8
			anchors.top: levelText.bottom
			anchors.topMargin: 40
			anchors.bottom: parent.bottom
			anchors.bottomMargin: 60
			width: parent.width / 8
		}

		Column {
			anchors.left: levelMeter.right
			anchors.leftMargin: parent.width / 8
			anchors.top: levelMeter.top
			anchors.topMargin: levelMeter.height / 8
			anchors.right: parent.right
			anchors.rightMargin: parent.width / 16

			Label {
				text: qsTr("Average")
				font.pixelSize: 50
				color: pageMeter.textColor
			}
			Text {
				text: pageMeter.meter.avgLevel.toFixed(2) + " dB"
				font.pixelSize: 70
				color: pageMeter.textColor
			}
			Button {
				text: qsTr("Reset")
				onClicked: pageMeter.resetAverage()
				anchors.topMargin: 50
				color: pageMeter.textColor
			}
		}

		MouseArea {
			anchors.fill: parent
			onClicked: {
				pageMeter.togglePause()
			}
		}
	}
}
