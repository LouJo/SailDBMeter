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
	property QtObject meter

	/*
	DBMeterController {
		id: meter
		running: Qt.application.active && app.userRunning
	}*/

	initialPage: Component {
		PageMeter {
			id: page_one
			nextPage: page_two

			DBMeterController {
				id: meterObject
				running: Qt.application.active && app.userRunning
			}

			meter: meterObject

			Component.onCompleted: {
				app.meter = meterObject
				togglePause.connect(app.togglePause)
			}
		}
	}

	cover: Component {
		CoverPage {
			level: meter.level
			maxLevel: meter.maxLevel
			avgLevel: meter.avgLevel

			CoverActionList {
				enabled: meter.countTempRun == 0
				CoverAction {
					iconSource: "image://theme/icon-cover-sync"
					onTriggered: {
						meter.runTempMs(1000)
					}
				}
			}
		}
	}

	Component {
		id: page_two
		PageReference {
			nextPage: page_three
			meter: app.meter

			Component.onCompleted: {
				togglePause.connect(app.togglePause)
			}
		}
	}

	Component {
		id: page_three
		PageAverage {
			meter: app.meter

			Component.onCompleted: {
				togglePause.connect(app.togglePause)
				resetAverage.connect(meter.avgReset)
			}
		}
	}

	function togglePause() {
		app.userRunning = app.userRunning ? false : true
	}
}
