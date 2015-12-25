import QtQuick 2.0
import harbour.saildbmeter.dbmeter 1.0
import Sailfish.Silica 1.0

/**
 * DBMeter controller
 *
 * DBMeter C++ object instanciation
 * Set calibration depending of device
 * compute max and average values
 */

Item {
	id: controller

	// calibration default values
	property double gainForPhone: 160000
	property double gainForTablet: 2000
	property double postGainForPhone: 1
	property double postGainForTablet: 1.4

	property bool running: false
	property alias level: meter.level
	property alias computeFrameMs: meter.computeFrameMs
	property int countTempRun: 0

	// max value
	property int delayMaxMs: 2000
	property int maxCounterLimit: delayMaxMs / meter.computeFrameMs
	property double maxLevel: 0
	property int maxCounter: 0

	// avg value
	property int avgCounter: 0
	property double avgLevel: 0
	signal avgReset()

	// min and max avg
	property int delayAvgMs: 5000
	property int avgCounterLimit: delayAvgMs / meter.computeFrameMs
	property double avgMaxLevel: 0
	property double avgMinLevel: 100
	property int avgMinCounter: 0
	property int avgMaxCounter: 0

	DBMeter {
		id: meter

		running: controller.running || controller.countTempRun
		gain: (Screen.sizeCategory > Screen.Medium) ? controller.gainForTablet : controller.gainForPhone
		postGain: (Screen.sizeCategory > Screen.Medium) ? controller.postGainForTablet : controller.postGainForPhone
	}

	onLevelChanged: {
		// max value
		if (level >= maxLevel || maxCounter++ >= maxCounterLimit) {
			maxLevel = level
			maxCounter = 0
		}
		// average
		avgLevel = (avgLevel * avgCounter + level) / (avgCounter + 1)
		avgCounter++
		// min/max average
		if (avgLevel >= avgMaxLevel || avgMaxCounter++ >= avgCounterLimit) {
			avgMaxLevel = avgLevel
			avgMaxCounter = 0
		}
		if (avgLevel <= avgMinLevel || avgMinCounter++ >= avgCounterLimit) {
			avgMinLevel = avgLevel
			avgMinCounter = 0
		}
		// run temporaly
		if (countTempRun) countTempRun--
	}

	onRunningChanged: { 
		if (running) {
			maxLevel = level;
			maxCounter = 0;
		}
		console.log("running: " + running)
	}

	onAvgReset: {
		avgLevel = level;
		avgCounter = 1;
		avgMinCounter = avgMaxCounter = 0
		avgMinLevel = avgMaxLevel = level
		console.log("avg reset")
	}

	function runTempMs(timeMs) {
		countTempRun = Math.ceil(timeMs / computeFrameMs)
	}
}
