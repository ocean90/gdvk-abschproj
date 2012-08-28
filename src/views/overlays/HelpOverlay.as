package views.overlays {
	import flash.display.Sprite;

	import utils.Colors;

	import widgets.SmallButton;

	import widgets.PageOverlay;

	import flash.events.Event;
	import flash.events.MouseEvent;

	public class HelpOverlay extends Sprite {
		public function HelpOverlay(parent:PageOverlay) {
			var cancel:SmallButton = new SmallButton('','red');
			if (Main.LANGUAGE == 'DE') {
				cancel.setText('Abbrechen');
			} else if (Main.LANGUAGE == 'EN') {
				cancel.setText('Cancel');
			}
			cancel.addEventListener(MouseEvent.CLICK, parent.destroy);
			addChild(cancel);

		}

		public function destroy() {
			trace('destroy');
		}
	}
}