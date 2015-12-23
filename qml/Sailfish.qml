import QtQuick 2.0
import Sailfish.Silica 1.0

ApplicationWindow {
	id: app
	allowedOrientations: Orientation.All

	property bool userRunning: true
	property int dbFontSize: 100

	DBMeterController {
		id: meter
		running: Qt.application.active && app.userRunning
	}

	initialPage: Component {
		PageMeter {
			id: page
			running: meter.running
			computeFrameMs: meter.computeFrameMs
			level: meter.level
			fontSize: dbFontSize

			onTogglePause : {
				app.userRunning = app.userRunning ? false : true
			}
		}
	}

	cover: Component {
		CoverPage {
			level: meter.level
		}
	}
}
