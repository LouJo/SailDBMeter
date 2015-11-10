import QtQuick 2.0
import Sailfish.Silica 1.0
import LJDBMeter 1.0

ApplicationWindow {
   allowedOrientations: Orientation.Portrait

	initialPage: Component { Page {
		SilicaFlickable {
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
	}}
}
