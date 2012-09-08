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
	import widgets.InputField;
	import flash.text.TextField;
	
	/**
	 * Für die Teilnehmer-Liste ein Suchdialog.
	 */
	public class SearchOverlay extends PageOverlay {
		
		private var searchLabel:TextLabel;
		private var searchInput:InputField;

		// Function was called if the user clicked on search!
		public var searchCallback:Function = null;
		
		public function SearchOverlay(background:* = 0xffffff, w:Number = 870,h:Number = 500) {
			super(background, w, h);
			
			content.x = -Grid.COLUMN_2 + Grid.COLUMN_PADDING;
			content.y = -60;
			
			setText(Main.LANGUAGE == 'DE' ? 'Suchen' : 'Search');
			
			searchLabel = new TextLabel();
			searchLabel.x = Grid.COLUMN_2;
			searchLabel.y = 300;
			searchLabel.shapeWidth = Grid.SPAN_1;
			searchLabel.shapeHeight = 50;
//			searchLabel.textFormat.align = TextFieldAutoSize.RIGHT;
			searchLabel.setText((Main.LANGUAGE == 'DE' ? 'Name oder Ort:' : 'Name or city:'));
			searchLabel.addEventListener(MouseEvent.CLICK, focus);
			
			searchInput = new InputField();
			searchInput.x = Grid.COLUMN_3;
			searchInput.y = 300;
			searchInput.shapeWidth = Grid.SPAN_3;
			searchInput.shapeHeight = 50;
			searchInput.update();
			searchInput.addEventListener(MouseEvent.CLICK, focus);
			searchInput.textField.addEventListener(Event.CHANGE, changeData);
			
			content.addChild(searchLabel);
			content.addChild(searchInput);
		}
		
		public override function update() {
			Main.FOOTER.resetButtonBar();
			Main.KEYBOARD.hide();
			
			showCancelButton((Main.LANGUAGE == 'DE' ? 'Abbrechen' : 'Cancel'), cancelSearch);
			showSubmitButton((Main.LANGUAGE == 'DE' ? 'Suchen' : 'Search'), searchNow);
			
			changeData(null);
			focus(null);
		}

		public function cancelSearch(e:Event) {
			Main.CONTENT.hideOverlay();
		}

		public function searchNow(e:Event) {
			if (searchInput.textField.length == 0) {
				focus(null);
				return;
			}
			
			if (searchCallback != null) {
				searchCallback();
			}
			
			Main.CONTENT.hideOverlay();
		}

		public function changeData(e:Event) {
			if (searchInput.textField.length == 0) {
				submit.color = 'lightgray';
				submit.textFormat.color = '0x888888';
				submit.update();
			} else {
				submit.color = 'green';
				submit.textFormat.color = '0xffffff';
				submit.update();
			}
		}

		public function focus(e:Event) {
			Main.KEYBOARD.activateFor(searchInput.textField);
			Main.KEYBOARD.setOnEnterFunction(function(activeTextField:TextField) {
				searchNow(e);
			});
		}
	}
}