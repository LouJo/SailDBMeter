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

	property int fontSizeLabel: 40
	property int fontSizeLevel: 50
	property int topMarginElement: 50

	property color textColor: meter.running ? Theme.primaryColor : Theme.secondaryColor

	property QtObject meter

	signal togglePause()
	signal resetAverage()

	allowedOrientations: Orientation.All

	SilicaFlickable {
		anchors.fill: parent

		Menu {
		}

		LevelMeter {
			id: levelMeter
			level: pageMeter.meter.level

			//anchors.horizontalCenter : parent.horizontalCenter
			anchors.left: parent.left
			anchors.leftMargin: parent.width / 8
			anchors.top: parent.top
			anchors.topMargin: 60
			anchors.bottom: parent.bottom
			anchors.bottomMargin: 60
			width: parent.width / 12
			opacity: 0.5
		}

		LevelMeter {
			id: levelMeterAverage
			level: pageMeter.meter.avgLevel

			//anchors.horizontalCenter : parent.horizontalCenter
			anchors.left: levelMeter.right
			anchors.leftMargin: parent.width / 16
			anchors.top: parent.top
			anchors.topMargin: 60
			anchors.bottom: parent.bottom
			anchors.bottomMargin: 60
			width: parent.width / 12
		}

		MouseArea {
			anchors.fill: parent
			onClicked: {
				pageMeter.togglePause()
			}
		}

		Column {
			anchors.left: levelMeterAverage.right
			anchors.leftMargin: parent.width / 16
			anchors.top: levelMeter.top
			anchors.topMargin: levelMeter.height / 8
			anchors.right: parent.right
			anchors.rightMargin: parent.width / 16

			Label {
				text: qsTr("Live")
				font.pixelSize: pageMeter.fontSizeLabel
				color: pageMeter.textColor
			}
			Text {
				text: pageMeter.meter.level.toFixed(2) + " dB"
				font.pixelSize: pageMeter.fontSizeLevel
				color: pageMeter.textColor
			}
			Label {
				text: qsTr("Average")
				font.pixelSize: pageMeter.fontSizeLabel
				color: pageMeter.textColor
				anchors.margins: pageMeter.topMarginElement
			}
			Text {
				text: pageMeter.meter.avgLevel.toFixed(2) + " dB"
				font.pixelSize: pageMeter.fontSizeLevel
				color: pageMeter.textColor
			}
			Button {
				text: qsTr("Reset")
				onClicked: {
					console.log("reset avg")
					pageMeter.resetAverage()
				}
				anchors.margins: pageMeter.topMarginElement
				color: pageMeter.textColor
			}
		}
	}
}
