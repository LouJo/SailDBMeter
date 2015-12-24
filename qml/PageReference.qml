import QtQuick 2.0
import Sailfish.Silica 1.0

/**
 * Silica page with level meter and text references
 *
 * Need reference to meter object that provide level
 *
 */

Page {
	id: pageMeter
	allowedOrientations: Orientation.All

	property int fontSize: 100
	property double level: meter.level
	property color textColor: meter.running ? Theme.primaryColor : Theme.secondaryColor

	property QtObject meter

	signal togglePause()

	Behavior on level {
		NumberAnimation {
			duration: 1000
			easing.type: Easing.Linear
			easing.amplitude: 100
		}
	}

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


		Item {
			/// references
			anchors.left: levelMeter.right
			anchors.leftMargin: 10
			anchors.right: parent.right
			anchors.rightMargin: parent.width / 8
			anchors.top: levelMeter.top
			anchors.bottom: levelMeter.bottom

			property alias textColor: pageMeter.textColor
			property alias level: pageMeter.level

			RefElement {
				text: qsTr("Quiet field")
				ref: 30
			}
			RefElement {
				text: qsTr("Library")
				ref: 40
			}
			RefElement {
				text: qsTr("Conversation at home")
				ref: 50
			}
			RefElement {
				text: qsTr("Conversation in restaurant")
				ref: 60
			}
			RefElement {
				text: qsTr("Living room music")
				ref: 70
			}
			RefElement {
				text: qsTr("Freight train (15m)")
				ref: 80
			}
			RefElement {
				text: qsTr("Boeing 747 (1ml)")
				ref: 90
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
