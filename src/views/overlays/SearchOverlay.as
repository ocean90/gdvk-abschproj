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

	public class SearchOverlay extends PageOverlay {
		
		// Function was called if the user clicked on search!
		public var searchCallback:Function = null;
		
		public function SearchOverlay(background:* = 0xffffff, w:Number = 870,h:Number = 500) {
			super(background, w, h);
			setText(Main.LANGUAGE == 'DE' ? 'Suchen' : 'Search');
			
			showCancelButton((Main.LANGUAGE == 'DE' ? 'Abbrechen' : 'Cancel'), function() {
				Main.CONTENT.hideOverlay();
			});
			showSubmitButton((Main.LANGUAGE == 'DE' ? 'Suchen' : 'Search'), function() {
				
				if (searchCallback != null) {
					searchCallback();
				}
				
				Main.CONTENT.hideOverlay();
			});
		}
	}
}