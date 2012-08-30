package views.overlays {
	
	import widgets.PageOverlay;
	import widgets.SmallButton;
	import flash.events.MouseEvent;
	import views.Views;
	import utils.Grid;
	
	public class CheckInOverlay extends PageOverlay {
		public function CheckInOverlay(background:* = 0xffffff, w:Number = 870,h:Number = 650) {
			super(background, w, h);

			Views.CheckIn.update();
			content.x = -Grid.COLUMN_2 + Grid.COLUMN_PADDING;
			content.y = -60;
			content.addChild(Views.CheckIn);
			
			if (Main.LANGUAGE == 'DE') {
				setText('Check-In');
			} else if (Main.LANGUAGE == 'EN') {
				setText('Check-in');
			}
		}
	}
}