import QtQuick 2.0
import LJDBMeter 1.0

Item {
	Text {
		text: Math.floor(meter.level) + " db"
	}
	DBMeter {
		id: meter
	}
	Component.onCompleted: {
		meter.running = 1
	}
}
