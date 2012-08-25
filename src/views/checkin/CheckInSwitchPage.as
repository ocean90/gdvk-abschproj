package views.checkin {
	import flash.events.Event;
	import flash.display.Loader;
	import flash.events.MouseEvent;
	import flash.text.TextFieldAutoSize;
	
	import views.View;
	import widgets.InputField;
	import widgets.TextLabel;
	import utils.Grid;
	import widgets.SmallButton;

	/**
	 * STEP 1 - Check in switch with question "have you already an id?"
	 */
	public class CheckInSwitchPage extends View {

		var question:TextLabel;
		var yesButton:SmallButton;
		var noButton:SmallButton;
		
		var usernameLabel:TextLabel;
		var usernameInput:InputField;

		public function CheckInSwitchPage() {
			
			question = new TextLabel();
			question.x = Grid.COLUMN_2;
			question.y = 250;
			question.shapeWidth = Grid.SPAN_4;
			question.shapeHeight = 50;
			
			yesButton = new SmallButton('Yes', 'languageButtonActive');
			yesButton.x = Grid.COLUMN_2;
			yesButton.y = 300;
			yesButton.textFormat.color = '0x000000';
			yesButton.shapeWidth = Grid.SPAN_1;
			yesButton.shapeHeight = 50;
			yesButton.addEventListener(MouseEvent.CLICK, onYes);
			yesButton.update();
			
			noButton = new SmallButton('Yes', 'languageButtonActive');
			noButton.x = Grid.COLUMN_2;
			noButton.y = 400;
			noButton.textFormat.color = '0x000000';
			noButton.shapeWidth = Grid.SPAN_1;
			noButton.shapeHeight = 50;
			noButton.addEventListener(MouseEvent.CLICK, onNo);
			noButton.update();
			
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
			
			usernameInput.addEventListener(MouseEvent.CLICK, function(e:Event) {
				Main.KEYBOARD.activateFor(usernameInput.textField);
			});
			usernameLabel.addEventListener(MouseEvent.CLICK, function(e:Event) {
				Main.KEYBOARD.activateFor(usernameInput.textField);
			});
			
			addChild(yesButton);
			addChild(noButton);
			addChild(question);
			addChild(usernameLabel);
			addChild(usernameInput);
		}

		public override function update() {
			question.setText('Haben Sie sich bereits auf unserer Webseite registriert und '+
							 'eine persönliche ID von uns erhalten?');
			
			Main.KEYBOARD.activateFor(usernameInput.textField);
		}
		
		public function onYes(e:Event) {
			
		}
		
		public function onNo(e:Event) {
			
		}
	}
	
}
