import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
	allowedOrientations: Orientation.All

	SilicaFlickable {
		anchors.fill: parent
		contentHeight: column.height

		Column {
			id: column
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
				horizontalAlignment: Text.AlignHCenter
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
				text: "version 0.2.2"
			}

			SectionHeader {
				anchors.horizontalCenter: parent.horizontalCenter
				text: qsTr("Copyright")
				horizontalAlignment: Text.AlignHCenter
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
				text: qsTr("licence") + ": MIT"
			}

			SectionHeader {
				anchors.horizontalCenter: parent.horizontalCenter
				text: qsTr("Links")
				horizontalAlignment: Text.AlignHCenter
			}
			Label {
				anchors.horizontalCenter: parent.horizontalCenter
				font.pixelSize: Theme.fontSizeSmall
				property string urlstring: "https://github.com/LouJo/SailDBMeter"
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
}
