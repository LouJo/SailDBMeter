import QtQuick 2.0
import Sailfish.Silica 1.0

/**
 * Silica page with level meter and max indicator
 *
 * Need reference to meter object that provide level,
 * running and maxLevel values
 *
 */

Page {
	id: pageMeter

	property int fontSize: 100
	property int textMaxFontSize: Theme.fontSizeLarge
	property color textColor: meter.running ? Theme.primaryColor : Theme.secondaryColor

	property QtObject meter

	signal togglePause()

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
			anchors.left: levelMeter.left
			anchors.bottom: levelMeter.bottom
			height: levelMeter.height
			barWidth: levelMeter.width
			color: pageMeter.textColor
			textMaxFontSize: pageMeter.textMaxFontSize
			maxLevel: pageMeter.meter.maxLevel
		}

		MouseArea {
			anchors.fill: parent
			onClicked: {
				pageMeter.togglePause()
			}
		}
	}
}
