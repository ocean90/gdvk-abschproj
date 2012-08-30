﻿package views.overlays {
	import flash.display.Sprite;

	import utils.Colors;

	import widgets.SmallButton;

	import widgets.PageOverlay;

	import flash.events.Event;
	import flash.events.MouseEvent;
	import utils.Grid;

	public class HelpOverlay extends PageOverlay {
		public function HelpOverlay(background:* = 0xffffff, w:Number = 870,h:Number = 700) {
			super(background, w, h);

			var cancel:SmallButton = new SmallButton('','red');
			cancel.x = 0;
			cancel.y = this.height - cancel.height - Grid.COLUMN_PADDING;
			if (Main.LANGUAGE == 'DE') {
				cancel.setText('Abbrechen');
			} else if (Main.LANGUAGE == 'EN') {
				cancel.setText('Cancel');
			}

			cancel.addEventListener(MouseEvent.CLICK, destroy);
			content.addChild(cancel)

		}
	}
}