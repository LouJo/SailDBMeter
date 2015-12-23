import QtQuick 2.0
import harbour.saildbmeter.dbmeter 1.0
import Sailfish.Silica 1.0

Item {
	id: controller

	property double gainForPhone: 160000
	property double gainForTablet: 2000

	property double postGainForPhone: 1
	property double postGainForTablet: 1.4

	property alias running: meter.running
	property alias level: meter.level
	property alias computeFrameMs: meter.computeFrameMs

	DBMeter {
		id: meter

		gain: (Screen.sizeCategory > Screen.Medium) ? controller.gainForTablet : controller.gainForPhone
		postGain: (Screen.sizeCategory > Screen.Medium) ? controller.postGainForTablet : controller.postGainForPhone
	}
}
