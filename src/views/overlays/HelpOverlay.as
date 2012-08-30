package views.overlays {
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

			showCancelButton((Main.LANGUAGE == 'DE' ? 'Abbrechen' : 'Cancel'), function() {
				Main.CONTENT.hideOverlay();
			});

			content.addChild(cancel)
		}
	}
}