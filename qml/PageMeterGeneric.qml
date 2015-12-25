import QtQuick 2.0
import Sailfish.Silica 1.0

/**
 * Silica generic page with level meter and value title
 * with menu
 *
 * Need reference to meter object that provide level,
 *
 */

Page {
	id: pageMeter

	/// title db value font size
	property int fontSize: 100
	/// text color depending of running
	property color textColor: meter.running ? Theme.primaryColor : Theme.secondaryColor
	/// bar width, default to w/4
	property int barWidth: width / 4
	/// level bar margins
	property int barLeftMargin: width / 8
	property int barBottomMargin: 60
	/// meter object
	property QtObject meter
	/// next page to push attached
	property Component nextPage: null
	/// component to complete page
	property Component itemToAdd: null
	/// if large height
	property bool largeHeight: height > 600

	property bool nextPagePushed: false
	property QtObject levelMeter: levelMeterItem

	signal togglePause()

	allowedOrientations: Orientation.All

	SilicaFlickable {
		id: flickable
		anchors.fill: parent

		Menu {
		}

		Text {
			id: levelText
			width: parent.top * 0.8
			text: pageMeter.meter.level.toFixed(2) + " dB"

			anchors.horizontalCenter : parent.horizontalCenter
			anchors.top: parent.top
			anchors.topMargin:20
			font.pixelSize: pageMeter.fontSize
			color: pageMeter.textColor
		}
		LevelMeter {
			id: levelMeterItem
			level: pageMeter.meter.level

			anchors.left: parent.left
			anchors.leftMargin: pageMeter.barLeftMargin
			anchors.top: levelText.bottom
			anchors.topMargin: 40
			anchors.bottom: parent.bottom
			anchors.bottomMargin: pageMeter.barBottomMargin
			width: pageMeter.barWidth
		}
		MouseArea {
			anchors.fill: parent
			onClicked: {
				pageMeter.togglePause()
			}
		}
	}

	onStatusChanged: {
		if (status == PageStatus.Active && nextPage !== null && !nextPagePushed) {
			console.log("activating next page")
			nextPagePushed = true
			pageStack.pushAttached(nextPage);
		}
	}

	Component.onCompleted: {
		if (itemToAdd !== null) itemToAdd.createObject(levelText.parent);
	}
}
