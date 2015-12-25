import QtQuick 2.0
import Sailfish.Silica 1.0

/**
 * Silica page with level meter and max indicator
 *
 * Inherit from PageMeterGeneric
 */

PageMeterGeneric {
	id: pageMeter

	itemToAdd:  Component {
		MaxBar {
			id: maxBar
			x: levelMeter.x
			y: levelMeter.y
			height: levelMeter.height
			barWidth: levelMeter.width
			color: pageMeter.textColor
			textMaxFontSize: Theme.fontSizeLarge
			maxLevel: pageMeter.meter.maxLevel
		}
	}
}
