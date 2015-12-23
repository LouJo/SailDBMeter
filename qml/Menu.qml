import QtQuick 2.0
import Sailfish.Silica 1.0

PullDownMenu {
	id: menu
	MenuItem {
		text: qsTr("Exit")
		onClicked: Qt.quit()
	}
	MenuItem {
		text: qsTr("About")
		onClicked: pageStack.push(Qt.resolvedUrl("Apropos.qml"))
	}
}

