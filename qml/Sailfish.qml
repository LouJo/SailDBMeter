import QtQuick 2.0
import Sailfish.Silica 1.0
import LJDBMeter 1.0

ApplicationWindow {
   allowedOrientations: Orientation.Portrait

	initialPage: Component { Page {
		allowedOrientations: Orientation.All
		SilicaFlickable {
			anchors.fill: parent
			PageMeter {
				fontSize:100
			}
		}
	}}
}
