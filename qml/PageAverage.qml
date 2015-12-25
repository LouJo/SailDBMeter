import QtQuick 2.0
import Sailfish.Silica 1.0

/**
 * Silica page with level meter and average indicator
 *
 * Inherit from PageMeterGeneric
 *
 */

PageMeterGeneric {
	id: pageMeter

	barWidth: width / 8

	property int fontSizeLabel: 30
	property int fontSizeLevel: largeHeight ? 70 : 40
	property int fontSizeTime: 40
	property int topMarginElement: largeHeight ? 30 : 0

	property int avgTimeSec: meter.avgCounter * meter.computeFrameMs / 1000
	signal resetAverage()

	itemToAdd: Component { Item {
		anchors.fill: parent

		Rectangle {
			id: minMaxBar
			color: pageMeter.textColor
			opacity: 0.8

			property double yTop: Math.min(100, pageMeter.meter.avgMaxLevel)
			property double yBottom: Math.min(100, pageMeter.meter.avgMinLevel)

			Behavior on yTop {
				NumberAnimation {
					duration: 2000
					easing.type: Easing.Linear
					easing.amplitude: 100
				}
			}

			Behavior on yBottom {
				NumberAnimation {
					duration: 2000
					easing.type: Easing.Linear
					easing.amplitude: 100
				}
			}

			x: pageMeter.barLeftMargin
			y: levelMeter.y + levelMeter.height - yTop * levelMeter.height / 100 - 1
			height: yTop - yBottom + 2
			width: levelMeter.width
		}

		Item {
			anchors.left: parent.left
			anchors.leftMargin: pageMeter.barLeftMargin + levelMeter.width + parent.width / 8
			anchors.right: parent.right
			anchors.rightMargin: pageMeter.width / 8
			anchors.top: parent.top
			anchors.topMargin: levelMeter.y + (pageMeter.largeHeight ? levelMeter.height / 8 : 0)

			SectionHeader {
				id: timeLabel
				text: qsTr("Time")
				font.pixelSize: pageMeter.fontSizeLabel
				anchors.horizontalCenter: parent.horizontalCenter
				anchors.top: parent.top
				anchors.topMargin: 0
				horizontalAlignment: Text.AlignHCenter
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
			SectionHeader {
				id: avgLabel
				text: qsTr("Average")
				font.pixelSize: pageMeter.fontSizeLabel
				anchors.horizontalCenter: parent.horizontalCenter
				anchors.top: timeText.bottom
				anchors.topMargin: pageMeter.topMarginElement
				horizontalAlignment: Text.AlignHCenter
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
		} }
	}
}
