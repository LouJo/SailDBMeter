import QtQuick 2.0
import Sailfish.Silica 1.0

ApplicationWindow {
	id: app
	allowedOrientations: Orientation.All

	property bool userRunning: true

	DBMeterController {
		id: meter
		running: Qt.application.active && app.userRunning
	}

	initialPage: Component { Page {
		id: page
		allowedOrientations: Orientation.All

		SilicaFlickable {
			anchors.fill: parent

			Menu {
			}

			PageMeter {
				id: pageMeter
				running: meter.running
				computeFrameMs: meter.computeFrameMs
				level: meter.level

				fontSize:100
				textMaxFontSize: Theme.fontSizeLarge
				textColor: Theme.primaryColor
				textColorPaused: Theme.secondaryColor
			}

			MouseArea {
				anchors.fill: parent
				onClicked: {
					console.log("click")
					app.userRunning = app.userRunning ? false : true
				}
			}
		}
	}}

	cover: Component {
		CoverPage {
			level: meter.level
		}
	}
}
