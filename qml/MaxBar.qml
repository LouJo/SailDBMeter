import QtQuick 2.0

Item {
	signal reset()
	property double level: 0
	property double ref: 0
	property int counter: 0
	property int delayMs: 2000
	property int counterMax: delayMs / computeFrameMs

	property color color
	property int computeFrameMs
	property int barWidth
	property int textMaxFontSize

	Rectangle {
		id: maxBar

		width: parent.barWidth
		height: 2
		color: parent.color
		anchors.bottomMargin: Math.min(100, parent.level) / 100 * parent.height
		anchors.bottom: parent.bottom
	}

	Text {
		id: maxText
		color: parent.color
		text: parent.level.toFixed(2) + " dB"
		anchors.left: maxBar.right
		anchors.verticalCenter: maxBar.verticalCenter
		anchors.leftMargin: 10
		font.pixelSize: parent.textMaxFontSize
	}

	onRefChanged: {
		if (ref >= level) {
			level = ref
			counter = 0
		}
		else if (counter++ >= counterMax) {
			level = ref
		counter = 0
		}
	}

	onReset: { level = ref; counter = 0 }
}
