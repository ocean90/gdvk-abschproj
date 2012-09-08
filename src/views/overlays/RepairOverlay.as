package views.overlays {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	import com.greensock.TweenLite;

	import utils.Grid;
	import utils.Colors;

	import views.PageOverlay;
	import widgets.SmallButton;
	import widgets.TextLabel;

	/**
	 * Reparatur Dialog.
	 */
	public class RepairOverlay extends PageOverlay {

		var infoText:TextLabel;

		public function RepairOverlay(background:* = 0xffffff, w:Number = 870,h:Number = 700) {
			super(background, w, h);
			setText(Main.LANGUAGE == 'DE' ? 'Reparatur' : 'Repair');

			infoText = new TextLabel();
			infoText.x = Grid.COLUMN_2;
			infoText.y = 300;
			infoText.shapeWidth = Grid.SPAN_4;
			infoText.shapeHeight = 100;
			infoText.textFormat.leading = 20;

			if (Main.LANGUAGE == 'DE') {
				infoText.setText('Lorem Ipsum');
			} else {
				infoText.setText('Lorem Ipsum');
			}
			addChild(infoText);

			showCancelButton((Main.LANGUAGE == 'DE' ? 'Abbrechen' : 'Cancel'), function() {
				Main.CONTENT.hideOverlay();
			});
		}
	}
}