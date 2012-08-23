package views.main {
	import flash.events.Event;
	import flash.display.Loader;
	import flash.events.MouseEvent;
	import views.View;
	import widgets.InputField;
	import widgets.VirtualKeyboard;
	import widgets.TextLabel;
	import flash.text.TextFieldAutoSize;
	import utils.Grid;
	
	public class CheckInPage extends View {

		var usernameLabel:TextLabel;
		var usernameInput:InputField;
		var keyboard:VirtualKeyboard;

		public function CheckInPage() {
			
			usernameLabel = new TextLabel();
			usernameLabel.x = Grid.COLUMN_2;
			usernameLabel.y = 400;
			usernameLabel.shapeWidth = Grid.SPAN_1;
			usernameLabel.shapeHeight = 50;
			usernameLabel.textFormat.align = TextFieldAutoSize.RIGHT;
			usernameLabel.setText('Username: ');
			
			usernameInput = new InputField();
			usernameInput.x = Grid.COLUMN_3;
			usernameInput.y = 400;
			usernameInput.shapeWidth = Grid.SPAN_2;
			usernameInput.shapeHeight = 50;
			usernameInput.update();
			
			keyboard = new VirtualKeyboard();
			keyboard.x = Main.STAGE.stageWidth * 0.5 - VirtualKeyboard.KEYBOARD_WIDTH * 0.5;
			keyboard.y = 620;
			keyboard.visible = false;
			
			usernameInput.addEventListener(MouseEvent.CLICK, function(e:Event) {
				keyboard.activateFor(usernameInput.textField);
			});
			usernameLabel.addEventListener(MouseEvent.CLICK, function(e:Event) {
				keyboard.activateFor(usernameInput.textField);
			});
			
			addChild(usernameLabel);
			addChild(usernameInput);
			addChild(keyboard);
		}
		
		public override function update() {
			keyboard.activateFor(usernameInput.textField);
		}
	}
	
}
