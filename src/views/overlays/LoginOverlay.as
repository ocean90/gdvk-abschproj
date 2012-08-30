package views.overlays {
	
	import widgets.PageOverlay;
	import widgets.SmallButton;
	import flash.events.MouseEvent;
	import views.Views;
	import utils.Grid;
	
	public class LoginOverlay extends PageOverlay {
		public function LoginOverlay(background:* = 0xffffff, w:Number = 870,h:Number = 700) {
			super(background, w, h);

			var cancel:SmallButton = new SmallButton('','red');
			cancel.x = 0;
			cancel.y = this.height - cancel.height - Grid.COLUMN_PADDING;
			if (Main.LANGUAGE == 'DE') {
				cancel.setText('Abbrechen');
			} else if (Main.LANGUAGE == 'EN') {
				cancel.setText('Cancel');
			}

			Views.CheckIn.update();
			cancel.addEventListener(MouseEvent.CLICK, destroy);
			content.addChild(cancel)
			content.addChild(Views.CheckIn);
		}
	}
}