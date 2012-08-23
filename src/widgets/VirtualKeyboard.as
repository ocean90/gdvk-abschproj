package widgets {
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	import com.greensock.TweenLite;
	
	public class VirtualKeyboard extends Sprite {

		private static var LINE_1:String = 'QWERTZUIOPÜ';
		private static var LINE_2:String = 'ASDFGHJKLÖÄ';
		private static var LINE_3:String = 'YXCVBNM';
		private static var KEY_WIDTH = 60;
		private static var KEY_HEIGHT = 60;
		private static var KEY_GAP = 10;

		private var textFormat:TextFormat;
		
		private var activeTextField:TextField;

		public function VirtualKeyboard() {
			textFormat = new TextFormat();
			textFormat.color = '0x000000';
			textFormat.font = 'Myriad Pro';
			textFormat.size = 25;
			
			createKeys();
		}
		
		public function activateFor(textField:TextField) {
			activeTextField = textField;
			if (activeTextField != null) {
				show();
			} else {
				hide();
			}
		}
		
		public function show() {
			/*var originalY:int = y;
			var originalHeight:int = height;
			y += height;
			height = 0;
			TweenLite.to(this, 0.8, { delay: 0.8, height: originalHeight, y: originalY });
			*/
			visible = true;
			alpha = 0;
			TweenLite.to(this, 0.8, { delay: 0.8, alpha: 1 });
			
			Main.STAGE.focus = activeTextField;
		}
		
		public function hide() {
			Main.STAGE.focus = null;
			visible = false;
		}

		public function createKeys() {
			var posX = 0;
			var posY = 0;
			for (var i = 0; i < LINE_1.length; i++) {
				createTextKey(LINE_1.charAt(i), posX, posY);
				posX += KEY_WIDTH + KEY_GAP;
			}
			// TODO icon
			createTextKey('<-', posX, posY);
			
			posX = 30;
			posY = KEY_HEIGHT + KEY_GAP;
			for (i = 0; i < LINE_2.length; i++) {
				createTextKey(LINE_2.charAt(i), posX, posY);
				posX += KEY_WIDTH + KEY_GAP;
			}
			
			posX = 60;
			posY = KEY_HEIGHT * 2 + KEY_GAP * 2;
			for (i = 0; i < LINE_3.length; i++) {
				createTextKey(LINE_3.charAt(i), posX, posY);
				posX += KEY_WIDTH + KEY_GAP;
			}
		}
		
		private function createTextKey(key:String, posX:int, posY:int) {
			var keyBackground:Sprite = new Sprite();
			keyBackground.graphics.lineStyle(2, 0x000000);
			keyBackground.graphics.beginFill(0xeeeeee);
			keyBackground.graphics.drawRoundRect(0, 0, KEY_WIDTH, KEY_HEIGHT, 10);
			keyBackground.graphics.endFill();
			keyBackground.x = posX;
			keyBackground.y = posY;
			keyBackground.width = KEY_WIDTH;
			keyBackground.height = KEY_HEIGHT;
			keyBackground.addEventListener(MouseEvent.CLICK, textKeyPressed);
			addChild(keyBackground);

			var keyLabel:TextField = new TextField();
			keyLabel.mouseEnabled = false;
			keyLabel.text = key;
			keyLabel.setTextFormat(textFormat);
			keyLabel.x = /*posX +*/ (KEY_WIDTH / 2 - keyLabel.textWidth / 2) - 2;
			keyLabel.y = /*posY +*/ (KEY_HEIGHT / 2 - keyLabel.textHeight / 2) + 2;
			keyLabel.width = KEY_WIDTH;
			keyLabel.height = KEY_HEIGHT;
			keyBackground.addChild(keyLabel);
		}
	
		public function textKeyPressed(e:Event) {
			var keyBackground:Sprite = ((Sprite) (e.currentTarget));
			var keyLabel:TextField = ((TextField) (keyBackground.getChildAt(0)));
			var key:String = keyLabel.text;
			
			if (key == '<-') {
				delKeyPressed(e);
				return;
			}
			
			if (activeTextField) {
				if (activeTextField.selectionBeginIndex == activeTextField.selectionEndIndex) {
					// Hack: Only required that the textfield visibility jumps to the end of the textfield
					// otherwise also replaceSelectedText would be work.
					activeTextField.appendText(key.toLocaleLowerCase());
					activeTextField.setSelection(activeTextField.length, activeTextField.length);
				} else {
					// if the user double tab the input its marked and so we want to replace the text
					activeTextField.replaceSelectedText(key.toLocaleLowerCase());
				}
			}
			Main.STAGE.focus = activeTextField;
		}
		
		public function delKeyPressed(e:Event) {
			if (activeTextField && activeTextField.length > 0) {
				activeTextField.setSelection(activeTextField.length - 1, activeTextField.length);
				activeTextField.replaceSelectedText('');
			}
			Main.STAGE.focus = activeTextField;
		}
	}
}
