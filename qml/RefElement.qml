import QtQuick 2.0
import Sailfish.Silica 1.0

/**
 * Simple object that factorize value and text reference for DB values
 */

Item {
	/// reference value [0,100]
	property double ref
	/// label text
	property string text

	anchors.bottom: parent.bottom
	anchors.bottomMargin: ref * parent.height / 100 + Theme.fontSizeSmall / 2
	anchors.left: parent.left

	Text {
		text: "- " + ref + " dB: " + parent.text
		font.pixelSize: Theme.fontSizeSmall
		opacity: Math.max(0.2, 1 - Math.abs(parent.parent.level - parent.ref) / 20)
		color: parent.parent.textColor
	}
}
