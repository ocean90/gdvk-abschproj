package views.overlays {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	import utils.Grid;
	import utils.Colors;

	import widgets.SmallButton;

	import views.PageOverlay;

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