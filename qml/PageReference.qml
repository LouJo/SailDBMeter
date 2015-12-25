import QtQuick 2.0
import Sailfish.Silica 1.0

/**
 * Silica page with level meter and text references
 *
 * Inherit from PageMeterGeneric
 *
 */

PageMeterGeneric {
	id: pageMeter

	barWidth: width / 8

	property double level: meter.level

	Behavior on level {
		NumberAnimation {
			duration: 1000
			easing.type: Easing.Linear
			easing.amplitude: 100
		}
	}

	itemToAdd: Component {
		Item {
			anchors.left: parent.left
			anchors.leftMargin: pageMeter.barLeftMargin + pageMeter.barWidth + 10
			anchors.right: parent.right
			anchors.rightMargin: pageMeter.width / 8
			anchors.bottom: parent.bottom
			anchors.bottomMargin: pageMeter.barBottomMargin
			height: pageMeter.levelMeter.height

			property color textColor: pageMeter.textColor
			property double level: pageMeter.level

			/// references

			RefElement {
				text: qsTr("Whisper")
				ref: 20
			}
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
				text: qsTr("Police whistle")
				ref: 80
			}
			RefElement {
				text: qsTr("Noisy factory")
				ref: 90
			}
			RefElement {
				text: qsTr("Car horn at 5m")
				ref: 100
			}
		}
	}
}
