import QtQuick 2.0
import Sailfish.Silica 1.0

/**
 * Sailfish main page
 *
 * Instanciate a DBMeter controller to be used in all pages
 * Manage user running status
 */

ApplicationWindow {
	id: app
	allowedOrientations: Orientation.All

	property bool userRunning: true
	property int dbFontSize: 100

	DBMeterController {
		id: meter
		running: Qt.application.active && app.userRunning
	}

	/*
	initialPage: Component {
		PageMeter {
			id: page
			fontSize: dbFontSize
			meter: meter
		}
	}*/

	cover: Component {
		CoverPage {
			level: meter.level
		}
	}

	Component.onCompleted: {
		var page_one = pageStack.push(
			Qt.resolvedUrl("PageMeter.qml"),
			{ meter: meter }
		);
		page_one.togglePause.connect(app.togglePause)

		var page_two = pageStack.pushAttached(
			Qt.resolvedUrl("PageMeterAverage.qml"),
			{ meter: meter }
		);
		page_two.togglePause.connect(app.togglePause)
	}

	function togglePause() {
		app.userRunning = app.userRunning ? false : true
	}
}
