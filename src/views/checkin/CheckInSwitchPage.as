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
	import widgets.BigButton;
	import com.greensock.TweenLite;

	/**
	 * STEP 1 - Check in switch with question "have you already an id?"
	 */
	public class CheckInSwitchPage extends View {

		var question:TextLabel;
		var yesButton:BigButton;
		var noButton:BigButton;
		
		var idLabel:TextLabel;
		var idInput:InputField;

		var firstnameLabel:TextLabel;
		var firstnameInput:InputField;

		var lastnameLabel:TextLabel;
		var lastnameInput:InputField;

		var cityLabel:TextLabel;
		var cityInput:InputField;

		var dateOfBirthLabel:TextLabel;
		var dateOfBirthInput:InputField;

		public function CheckInSwitchPage() {
			
			question = new TextLabel();
			question.shapeWidth = Grid.SPAN_4;
			question.shapeHeight = 100;
			question.textFormat.size = 30;
			
			yesButton = new BigButton(Grid.COLUMN_2, 441, 'yellow');
			//yesButton.textFormat.color = '0x000000';
			yesButton.shapeWidth = Grid.SPAN_2;
			yesButton.shapeHeight = Grid.SPAN_1;
			yesButton.addEventListener(MouseEvent.CLICK, onYes);
			yesButton.update();
			
			noButton = new BigButton(Grid.COLUMN_4, 441, 'yellow');
			//noButton.textFormat.color = '0x000000';
			noButton.shapeWidth = Grid.SPAN_2;
			noButton.shapeHeight = Grid.SPAN_1;
			noButton.addEventListener(MouseEvent.CLICK, onNo);
			noButton.update();
			
			idLabel = new TextLabel();
			idLabel.x = Grid.COLUMN_2;
			idLabel.y = 441;
			idLabel.shapeWidth = Grid.SPAN_1;
			idLabel.shapeHeight = 50;
//			idLabel.textFormat.align = TextFieldAutoSize.RIGHT;
			idLabel.visible = false;
			idLabel.addEventListener(MouseEvent.CLICK, focusId);
			
			idInput = new InputField();
			idInput.x = Grid.COLUMN_3;
			idInput.y = 441;
			idInput.shapeWidth = Grid.SPAN_3;
			idInput.shapeHeight = 50;
			idInput.update();
			idInput.visible = false;
			idInput.addEventListener(MouseEvent.CLICK, focusId);
			
			firstnameLabel = new TextLabel();
			firstnameLabel.shapeWidth = Grid.SPAN_1;
			firstnameLabel.shapeHeight = 50;
//			firstnameLabel.textFormat.align = TextFieldAutoSize.RIGHT;
			firstnameLabel.visible = false;
			firstnameLabel.addEventListener(MouseEvent.CLICK, focusFirstname);
			
			firstnameInput = new InputField();
			firstnameInput.shapeWidth = Grid.SPAN_3;
			firstnameInput.shapeHeight = 50;
			firstnameInput.update();
			firstnameInput.visible = false;
			firstnameInput.addEventListener(MouseEvent.CLICK, focusFirstname);
			
			lastnameLabel = new TextLabel();
			lastnameLabel.shapeWidth = Grid.SPAN_1;
			lastnameLabel.shapeHeight = 50;
//			lastnameLabel.textFormat.align = TextFieldAutoSize.RIGHT;
			lastnameLabel.visible = false;
			lastnameLabel.addEventListener(MouseEvent.CLICK, focusLastname);
			
			lastnameInput = new InputField();
			lastnameInput.shapeWidth = Grid.SPAN_3;
			lastnameInput.shapeHeight = 50;
			lastnameInput.update();
			lastnameInput.visible = false;
			lastnameInput.addEventListener(MouseEvent.CLICK, focusLastname);
			
			cityLabel = new TextLabel();
			cityLabel.shapeWidth = Grid.SPAN_1;
			cityLabel.shapeHeight = 50;
//			cityLabel.textFormat.align = TextFieldAutoSize.RIGHT;
			cityLabel.visible = false;
			cityLabel.addEventListener(MouseEvent.CLICK, focusCity);
			
			cityInput = new InputField();
			cityInput.shapeWidth = Grid.SPAN_3;
			cityInput.shapeHeight = 50;
			cityInput.update();
			cityInput.visible = false;
			cityInput.addEventListener(MouseEvent.CLICK, focusCity);
			
			dateOfBirthLabel = new TextLabel();
			dateOfBirthLabel.shapeWidth = Grid.SPAN_1;
			dateOfBirthLabel.shapeHeight = 50;
//			dateOfBirthLabel.textFormat.align = TextFieldAutoSize.RIGHT;
			dateOfBirthLabel.visible = false;
			dateOfBirthLabel.addEventListener(MouseEvent.CLICK, focusDateOfBirth);
			
			dateOfBirthInput = new InputField();
			dateOfBirthInput.shapeWidth = Grid.SPAN_3;
			dateOfBirthInput.shapeHeight = 50;
			dateOfBirthInput.update();
			dateOfBirthInput.visible = false;
			dateOfBirthInput.addEventListener(MouseEvent.CLICK, focusDateOfBirth);
			
			addChild(yesButton);
			addChild(noButton);
			addChild(question);
			
			addChild(idLabel);
			addChild(idInput);
			
			addChild(firstnameLabel);
			addChild(firstnameInput);
			addChild(lastnameLabel);
			addChild(lastnameInput);
			addChild(cityLabel);
			addChild(cityInput);
			addChild(dateOfBirthLabel);
			addChild(dateOfBirthInput);
		}

		public override function update() {
			// reset all positions that are changed in onYes or onNo!
			
			if (Main.LANGUAGE == 'DE') {
				question.setText('Haben Sie sich bereits auf unserer Webseite registriert\n' +
								 'und ihre persönliche Einladung erhalten?');
			} else if (Main.LANGUAGE == 'EN') {
				question.setText('Have you already registered on our website\n' +
								 'and receive your personal invitation?');
			}
			question.x = Grid.COLUMN_2;
			question.y = 250;
			question.alpha = 1;
			question.visible = true;
			
			if (Main.LANGUAGE == 'DE') {
				yesButton.setText('Check-In mit\npersönlicher ID');
			} else if (Main.LANGUAGE == 'EN') {
				yesButton.setText('Check-in with\na personal id');
			}
			yesButton.x = Grid.COLUMN_2;
			yesButton.y = 441;
			yesButton.alpha = 1;
			yesButton.visible = true;
			
			if (Main.LANGUAGE == 'DE') {
				noButton.setText('Jetzt mit Name und\nAnschrift registrieren');
			} else if (Main.LANGUAGE == 'EN') {
				noButton.setText('Register now with\nname and address');
			}
			noButton.x = Grid.COLUMN_4;
			noButton.y = 441;
			noButton.alpha = 1;
			noButton.visible = true;
			
			idLabel.visible = false;
			if (Main.LANGUAGE == 'DE') {
				idLabel.setText('Persönliche ID:');
			} else if (Main.LANGUAGE == 'EN') {
				idLabel.setText('Your personal id:');
			}
			
			idInput.textField.text = '';
			idInput.visible = false;
			idInput.update();
			
			firstnameLabel.visible = false;
			if (Main.LANGUAGE == 'DE') {
				firstnameLabel.setText('Vorname:');
			} else if (Main.LANGUAGE == 'EN') {
				firstnameLabel.setText('Firstname:');
			}
			
			firstnameInput.textField.text = '';
			firstnameInput.visible = false;
			firstnameInput.update();
			
			lastnameLabel.visible = false;
			if (Main.LANGUAGE == 'DE') {
				lastnameLabel.setText('Nachname:');
			} else if (Main.LANGUAGE == 'EN') {
				lastnameLabel.setText('Surname:');
			}
			
			lastnameInput.textField.text = '';
			lastnameInput.visible = false;
			lastnameInput.update();
			
			cityLabel.visible = false;
			if (Main.LANGUAGE == 'DE') {
				cityLabel.setText('Stadt:');
			} else if (Main.LANGUAGE == 'EN') {
				cityLabel.setText('City:');
			}
			
			cityInput.textField.text = '';
			cityInput.visible = false;
			cityInput.update();
			
			dateOfBirthLabel.visible = false;
			if (Main.LANGUAGE == 'DE') {
				dateOfBirthLabel.setText('Geburtsdatum:');
			} else if (Main.LANGUAGE == 'EN') {
				dateOfBirthLabel.setText('Date of birth:');
			}
			
			dateOfBirthInput.textField.text = '';
			dateOfBirthInput.visible = false;
			dateOfBirthInput.update();
		}
		
		public function onYes(e:Event) {
			TweenLite.to(yesButton, 0.8, { y: yesButton.y - 80, alpha: 0 });
			TweenLite.to(noButton, 0.8, { y: yesButton.y - 80, alpha: 0 });
			
			idLabel.visible = true;
			idInput.visible = true;
			
			focusId(e);
		}
		
		public function focusId(e:Event) {
			Main.KEYBOARD.activateFor(idInput.textField);
			Main.KEYBOARD.onNumberKeyPressed(e);
		}
		
		public function focusFirstname(e:Event) {
			Main.KEYBOARD.activateFor(firstnameInput.textField);
			Main.KEYBOARD.onNumberKeyPressed(e);
		}
		
		public function focusLastname(e:Event) {
			Main.KEYBOARD.activateFor(lastnameInput.textField);
			Main.KEYBOARD.onNumberKeyPressed(e);
		}
		
		public function focusCity(e:Event) {
			Main.KEYBOARD.activateFor(cityInput.textField);
			Main.KEYBOARD.onNumberKeyPressed(e);
		}
		
		public function focusDateOfBirth(e:Event) {
			Main.KEYBOARD.activateFor(dateOfBirthInput.textField);
			Main.KEYBOARD.onNumberKeyPressed(e);
		}
		
		public function onNo(e:Event) {
			firstnameLabel.x = Grid.COLUMN_2;
			firstnameLabel.y = 300;
			firstnameLabel.visible = true;
			firstnameLabel.alpha = 0;
			
			firstnameInput.x = Grid.COLUMN_3;
			firstnameInput.y = 300;
			firstnameInput.visible = true;
			firstnameInput.alpha = 0;
			
			lastnameLabel.x = Grid.COLUMN_2;
			lastnameLabel.y = 370;
			lastnameLabel.visible = true;
			lastnameLabel.alpha = 0;
			
			lastnameInput.x = Grid.COLUMN_3;
			lastnameInput.y = 370;
			lastnameInput.visible = true;
			lastnameInput.alpha = 0;
			
			cityLabel.x = Grid.COLUMN_2;
			cityLabel.y = 430;
			cityLabel.visible = true;
			cityLabel.alpha = 0;
			
			cityInput.x = Grid.COLUMN_3;
			cityInput.y = 430;
			cityInput.visible = true;
			cityInput.alpha = 0;
			
			dateOfBirthLabel.x = Grid.COLUMN_2;
			dateOfBirthLabel.y = 500;
			dateOfBirthLabel.visible = true;
			dateOfBirthLabel.alpha = 0;

			dateOfBirthInput.x = Grid.COLUMN_3;
			dateOfBirthInput.y = 500;
			dateOfBirthInput.visible = true;
			dateOfBirthInput.alpha = 0;
			
			// move up
			TweenLite.to(question, 0.8, { y: question.y - 80 });
			
			// face out
			TweenLite.to(yesButton, 0.8, { y: yesButton.y - 80, alpha: 0 });
			TweenLite.to(noButton, 0.8, { y: noButton.y - 80, alpha: 0 });
			
			// fade in
			var fadeInTime:Number = 2.6;
			var fadeInDelay:Number = 0.4;
			TweenLite.to(firstnameLabel, fadeInTime,   { alpha: 1, delay: fadeInDelay });
			TweenLite.to(firstnameInput, fadeInTime,   { alpha: 1, delay: fadeInDelay });
			TweenLite.to(lastnameLabel, fadeInTime,    { alpha: 1, delay: fadeInDelay });
			TweenLite.to(lastnameInput, fadeInTime,    { alpha: 1, delay: fadeInDelay });
			TweenLite.to(cityLabel, fadeInTime,        { alpha: 1, delay: fadeInDelay });
			TweenLite.to(cityInput, fadeInTime,        { alpha: 1, delay: fadeInDelay });
			TweenLite.to(dateOfBirthLabel, fadeInTime, { alpha: 1, delay: fadeInDelay });
			TweenLite.to(dateOfBirthInput, fadeInTime, { alpha: 1, delay: fadeInDelay });
			
			focusFirstname(e);
		}
	}
	
}
