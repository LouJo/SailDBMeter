import QtQuick 2.0

Item {
	signal reset()
	property double maxLevel: 0

	property color color
	property int barWidth
	property int textMaxFontSize

	Rectangle {
		id: maxBar

		width: parent.barWidth
		height: 2
		color: parent.color
		anchors.bottomMargin: Math.min(100, parent.maxLevel) / 100 * parent.height
		anchors.bottom: parent.bottom
	}

	Text {
		id: maxText
		color: parent.color
		text: parent.maxLevel.toFixed(2) + " dB"
		anchors.left: maxBar.right
		anchors.verticalCenter: maxBar.verticalCenter
		anchors.leftMargin: 10
		font.pixelSize: parent.textMaxFontSize
	}
}
