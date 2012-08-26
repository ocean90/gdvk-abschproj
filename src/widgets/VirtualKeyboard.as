package widgets {
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	import com.greensock.TweenLite;
	import views.View;
	import flash.text.TextFormatAlign;
	import utils.Grid;
	
	public class VirtualKeyboard extends View {
		
		public static var KEYBOARD_WIDTH:int = Grid.SPAN_4;

		private static var MODE_UPPERCASE:String = 'uppercase';
		private static var MODE_LOWERCASE:String = 'lowercase';
		private static var MODE_NUMBERS:String   = 'numbers';

		private static var KEY_LINES_LENGTH:Array = [ 10, 9, 9 ];
		private static var KEY_LINES:Object = {
			uppercase: ['QWERTZUIOP', 'ASDFGHJKL', 'YXCVBNM._'],
			lowercase: ['qwertzuiop', 'asdfghjkl', 'yxcvbnm,-'],
			numbers:   ['1234567890', '+-*/:;()@', 'äÄöÖüÜß!?']
		};
		
		private static var KEY_WIDTH = 61;
		private static var KEY_HEIGHT = 61;
		private static var KEY_GAP = 10;

		private var textFormat:TextFormat;
		
		private var keyboardMode = MODE_UPPERCASE;
		private var allNormalKeys:Object = [[], [], []];
		private var delKey:Sprite;
		private var enterKey:Sprite;
		private var spaceKey:Sprite;
		private var upperCaseKeyLeft:Sprite;
		private var upperCaseKeyRight:Sprite;
		private var numberModeKeyLeft:Sprite;
		private var numberModeKeyRight:Sprite;
		
		private var activeTextField:TextField;
		private var onEnterFunction:Function;

		public function VirtualKeyboard() {
			textFormat = new TextFormat();
			textFormat.color = '0x000000';
			textFormat.font = 'Myriad Pro';
			textFormat.size = 25;
			textFormat.align = TextFormatAlign.CENTER;
			
			createKeys();
		}
		
		public function activateFor(textField:TextField) {
			activeTextField = textField;
			if (activeTextField != null && activeTextField.visible) {
				show();
			} else {
				hide();
			}
		}
		
		public function currentTextField():TextField {
			return activeTextField;
		}
		
		/**
		 * set callback function with only one single TextField argument.
		 */
		public function setOnEnterFunction(callback:Function) {
			this.onEnterFunction = callback;
		}
		
		public function show() {
			keyboardMode = MODE_UPPERCASE;
			update();
			
			visible = true;
			Main.STAGE.focus = activeTextField;
		}
		
		public function hide() {
			Main.STAGE.focus = null;
			visible = false;
			
			activeTextField = null;
			onEnterFunction = null;
		}

		public function createKeys() {
			var textKey:Sprite;
			
			var posX = 0;
			var posY = 0;
			for (var i = 0; i < KEY_LINES_LENGTH[0]; i++) {
				textKey = createKey(posX, posY, KEY_WIDTH, KEY_HEIGHT);
				textKey.addEventListener(MouseEvent.CLICK, onTextKeyPressed);
				allNormalKeys[0][i] = textKey;
				posX += KEY_WIDTH + KEY_GAP;
			}
			
			// TODO icon
			delKey = createKey(posX, posY, KEYBOARD_WIDTH - posX, KEY_HEIGHT);
			delKey.addEventListener(MouseEvent.CLICK, onDelKeyPressed);
			
			posX = (KEY_WIDTH + KEY_GAP) * 0.5;
			posY = KEY_HEIGHT + KEY_GAP;
			for (i = 0; i < KEY_LINES_LENGTH[1]; i++) {
				textKey = createKey(posX, posY, KEY_WIDTH, KEY_HEIGHT);
				textKey.addEventListener(MouseEvent.CLICK, onTextKeyPressed);
				allNormalKeys[1][i] = textKey;
				posX += KEY_WIDTH + KEY_GAP;
			}
			
			enterKey = createKey(posX, posY, KEYBOARD_WIDTH - posX, KEY_HEIGHT);
			enterKey.addEventListener(MouseEvent.CLICK, onEnterKeyPressed);
			
			posX = 0;
			posY = KEY_HEIGHT * 2 + KEY_GAP * 2;
			
			// TODO icon
			upperCaseKeyLeft = createKey(posX, posY, KEY_WIDTH, KEY_HEIGHT);
			upperCaseKeyLeft.addEventListener(MouseEvent.CLICK, onUpKeyPressed);
			posX += KEY_WIDTH + KEY_GAP;
			
			for (i = 0; i < KEY_LINES_LENGTH[2]; i++) {
				textKey = createKey(posX, posY, KEY_WIDTH, KEY_HEIGHT);
				textKey.addEventListener(MouseEvent.CLICK, onTextKeyPressed);
				allNormalKeys[2][i] = textKey;
				posX += KEY_WIDTH + KEY_GAP;
			}
			
			// TODO icon
			upperCaseKeyRight = createKey(posX, posY, KEYBOARD_WIDTH - posX, KEY_HEIGHT);
			upperCaseKeyRight.addEventListener(MouseEvent.CLICK, onUpKeyPressed);
			
			posX = 0;
			posY = KEY_HEIGHT * 3 + KEY_GAP * 3;
			
			// Number Mode Key
			numberModeKeyLeft = createKey( posX, posY, KEY_WIDTH * 2.0 + KEY_GAP, KEY_HEIGHT);
			numberModeKeyLeft.addEventListener(MouseEvent.CLICK, onNumberKeyPressed);
			
			// Space key
			posX += KEY_WIDTH * 2.0 + KEY_GAP * 2;
			spaceKey = createKey(posX, posY, KEYBOARD_WIDTH - posX * 2, KEY_HEIGHT);
			spaceKey.addEventListener(MouseEvent.CLICK, onSpaceKeyPressed);
			posX += KEYBOARD_WIDTH - posX * 2 + KEY_GAP;
			
			// Number Mode Key
			numberModeKeyRight = createKey(posX, posY, KEY_WIDTH * 2.0 + KEY_GAP, KEY_HEIGHT);
			numberModeKeyRight.addEventListener(MouseEvent.CLICK, onNumberKeyPressed);
		}
		
		public override function update() {
			updateKeys();
		}
		
		private function updateKeys() {
			//trace('setKeyboardText', KEY_LINES[keyboardMode]);
			for (var line = 0; line < allNormalKeys.length; line++) {
				for (var keyInLine = 0; keyInLine < allNormalKeys[line].length; keyInLine++) {
					var keyBackground:Sprite = allNormalKeys[line][keyInLine];
					var keyText = ((String) (KEY_LINES[keyboardMode][line])).charAt(keyInLine);
					updateKeyText(keyBackground, keyText);
				}
			}
			
			updateKeyText(delKey, '←');
			updateKeyText(enterKey, '↵').x = 15;
			updateKeyText(enterKey, '↵').y = 20;
			updateKeyText(upperCaseKeyLeft, '⇧').textColor = keyboardMode == MODE_UPPERCASE ? 0x31ceff : 0x000000;
			updateKeyText(upperCaseKeyRight, '⇧').textColor = keyboardMode == MODE_UPPERCASE ? 0x31ceff : 0x000000;
			updateKeyText(numberModeKeyLeft, '123').textColor = keyboardMode == MODE_NUMBERS ? 0x31ceff : 0x000000;
			updateKeyText(numberModeKeyRight, '123').textColor = keyboardMode == MODE_NUMBERS ? 0x31ceff : 0x000000;
		}
		
		private function createKey(posX:int, posY:int, buttonWidth:int, buttonHeight:int):Sprite {
			var keyBackground:Sprite = new Sprite();
			keyBackground.buttonMode = true;
			keyBackground.graphics.lineStyle(2, 0x000000);
			keyBackground.graphics.beginFill(0xeeeeee);
			keyBackground.graphics.drawRoundRect(0, 0, buttonWidth, buttonHeight, 10);
			keyBackground.graphics.endFill();
			keyBackground.x = posX;
			keyBackground.y = posY;
			keyBackground.width = buttonWidth;
			keyBackground.height = buttonHeight;
			
			var keyLabel:TextField = new TextField();
			keyLabel.mouseEnabled = false;
			keyLabel.text = 'X';
			keyLabel.setTextFormat(textFormat);
			keyLabel.x = 0;
			keyLabel.y = (keyBackground.height / 2 - keyLabel.textHeight / 2) + 2;
			keyLabel.width = buttonWidth;
			keyLabel.height = buttonHeight;
			keyLabel.text = '';

			keyBackground.addChild(keyLabel);
			
			addChild(keyBackground);
			
			return keyBackground;
		}
	
		private function updateKeyText(keyBackground:Sprite, keyText:String):TextField {
			var keyLabel:TextField = ((TextField) (keyBackground.getChildAt(0)));
			keyLabel.text = keyText;
			keyLabel.setTextFormat(textFormat);
			return keyLabel;
		}
		
		public function onTextKeyPressed(e:Event) {
			var keyBackground:Sprite = ((Sprite) (e.currentTarget));
			var keyLabel:TextField = ((TextField) (keyBackground.getChildAt(0)));
			replaceSelectedText(keyLabel.text);
		}
		
		public function onSpaceKeyPressed(e:Event) {
			replaceSelectedText(' ');
		}
		
		public function fakeKey(text:String) {
			replaceSelectedText(text);
		}
		
		private function replaceSelectedText(text:String) {
			if (activeTextField) {
				if (activeTextField.selectionBeginIndex == activeTextField.selectionEndIndex) {
					// Hack: Only required that the textfield visibility jumps to the end of the textfield
					// otherwise also replaceSelectedText would be work.
					activeTextField.appendText(text);
					activeTextField.setSelection(activeTextField.length, activeTextField.length);
					activeTextField.dispatchEvent(new Event(Event.CHANGE));
				} else {
					// if the user double tab the input its marked and so we want to replace the text
					activeTextField.replaceSelectedText(text);
					activeTextField.dispatchEvent(new Event(Event.CHANGE));
				}
				
				if (keyboardMode == MODE_UPPERCASE) {
					keyboardMode = MODE_LOWERCASE;
					update();
				}
			}
			Main.STAGE.focus = activeTextField;
		}
		
		public function onDelKeyPressed(e:Event) {
			if (activeTextField && activeTextField.length > 0) {
				if (activeTextField.selectionBeginIndex == activeTextField.selectionEndIndex) {
					// remove the char before the caret
					activeTextField.setSelection(activeTextField.selectionBeginIndex - 1, activeTextField.selectionEndIndex);
					activeTextField.replaceSelectedText('');
					activeTextField.dispatchEvent(new Event(Event.CHANGE));
				} else {
					// remove the selection
					activeTextField.replaceSelectedText('');
					activeTextField.dispatchEvent(new Event(Event.CHANGE));
				}
			}
			Main.STAGE.focus = activeTextField;
		}
		
		public function onEnterKeyPressed(e:Event) {
			keyboardMode = MODE_UPPERCASE;
			update();
			if (this.onEnterFunction != null) {
				this.onEnterFunction(this.activeTextField);
			} else {
				hide();
			}
		}
		
		public function onUpKeyPressed(e:Event) {
			if (keyboardMode != MODE_UPPERCASE) {
				keyboardMode = MODE_UPPERCASE;
			} else {
				keyboardMode = MODE_LOWERCASE;
			}
			update();
			Main.STAGE.focus = activeTextField;
		}
		
		public function onNumberKeyPressed(e:Event) {
			if (keyboardMode != MODE_NUMBERS) {
				keyboardMode = MODE_NUMBERS;
			} else {
				keyboardMode = MODE_UPPERCASE;
			}
			update();
			Main.STAGE.focus = activeTextField;
		}
	}
}
