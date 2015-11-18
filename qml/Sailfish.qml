import QtQuick 2.0
import Sailfish.Silica 1.0

ApplicationWindow {
	id: app
	allowedOrientations: Orientation.All

   property QtObject meterObject
	property bool running: true

	initialPage: Component { Page {
		id: page
		allowedOrientations: Orientation.All

		SilicaFlickable {
			anchors.fill: parent

			PullDownMenu {
				id: menu
				MenuItem {
					text: qsTr("Exit")
					onClicked: Qt.quit()
				}
				MenuItem {
					text: qsTr("About")
					onClicked: pageStack.push(Qt.resolvedUrl("Apropos.qml"))
				}
			}

			PageMeter {
				id: meter
				fontSize:100
				textMaxFontSize: Theme.fontSizeLarge
				textColor: Theme.primaryColor
				textColorPaused: Theme.secondaryColor
				running: app.running

				Component.onCompleted: {
					app.meterObject = meter
				}
			}
		}
	}}

	cover: Component {
		CoverBackground {
			id: cover
			Label {
				id: coverLabel
				text: "dB Meter"
				anchors.horizontalCenter: parent.horizontalCenter
				anchors.top: parent.top
				anchors.topMargin: Theme.paddingLarge
				anchors.bottomMargin: Theme.paddingLarge
			}
			Text {
				id: coverLevel
				text: app.meterObject.level.toFixed(2) + " dB"
				anchors.horizontalCenter: parent.horizontalCenter
				anchors.top: coverLabel.bottom
				anchors.topMargin: Theme.paddingLarge
				color: Theme.primaryColor
				font.pixelSize: 40
			}
			Text {
				id: coverMaxLevel
				text: "max: " + app.meterObject.levelMax.toFixed(2) + " dB"
				anchors.horizontalCenter: parent.horizontalCenter
				anchors.top: coverLevel.bottom
				anchors.topMargin: Theme.paddingLarge
				color: Theme.primaryColor
				font.pixelSize: 30
			}



			onStatusChanged: {
				app.running = status != Cover.Active
			}
		}
	}
}
