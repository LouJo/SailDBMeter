import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
	allowedOrientations: Orientation.All

	Column {
		width: parent.width
		spacing: 10

		PageHeader {
			title: qsTr("About")
		}

		Image {
			anchors.horizontalCenter: parent.horizontalCenter
			source: "../icons/DBmeter256.png" 
		}

		SectionHeader {
			anchors.horizontalCenter: parent.horizontalCenter
			text: "SailDBMeter"
		}

		Text {
			anchors.horizontalCenter: parent.horizontalCenter
			font.pixelSize: Theme.fontSizeSmall
			width: parent.width
			wrapMode: Text.WordWrap
			horizontalAlignment: Text.AlignHCenter
			color: Theme.primaryColor
			text: qsTr("Microphone DB meter level")
		}

		Label {
			anchors.horizontalCenter: parent.horizontalCenter
			font.pixelSize: Theme.fontSizeSmall
			text: "version 0.1.1"
		}

		SectionHeader {
			anchors.horizontalCenter: parent.horizontalCenter
			text: qsTr("Copyright")
		}

		Label {
			anchors.horizontalCenter: parent.horizontalCenter
			font.pixelSize: Theme.fontSizeSmall
			text: "Louis-Joseph Fournier"
		}
		Label {
			anchors.horizontalCenter: parent.horizontalCenter
			font.pixelSize: Theme.fontSizeSmall
			text: "11-2015"
		}
		Label {
			anchors.horizontalCenter: parent.horizontalCenter
			font.pixelSize: Theme.fontSizeSmall
			text: qsTr("licence") + ": BSD"
		}

		SectionHeader {
			anchors.horizontalCenter: parent.horizontalCenter
			text: qsTr("Links")
		}
		Label {
			anchors.horizontalCenter: parent.horizontalCenter
			font.pixelSize: Theme.fontSizeSmall
			property string urlstring: "http://nothing"
			text: "<a href=\"" + urlstring + "\">" +  urlstring + "<\a>"
			onLinkActivated: Qt.openUrlExternally(link)
		}
		Label {
			anchors.horizontalCenter: parent.horizontalCenter
			font.pixelSize: Theme.fontSizeSmall
			property string urlstring: "http://legolas.vefblog.net"
			text: "<a href=\"" + urlstring + "\">" +  urlstring + "<\a>"
			onLinkActivated: Qt.openUrlExternally(link)
		}
	}
}
