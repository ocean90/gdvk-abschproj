﻿package views.checkin {
	import flash.events.Event;
	import flash.display.Loader;
	import flash.events.MouseEvent;
	import flash.text.TextField;
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
			dateOfBirthInput.shapeWidth = 180;
			dateOfBirthInput.shapeHeight = 50;
			dateOfBirthInput.update();
			dateOfBirthInput.visible = false;
			dateOfBirthInput.addEventListener(MouseEvent.CLICK, focusDateOfBirth);
			dateOfBirthInput.textField.addEventListener(Event.CHANGE, function(e:Event) {
				if (dateOfBirthInput.textField.length == 2 || dateOfBirthInput.textField.length == 5) {
					Main.KEYBOARD.fakeKey(Main.LANGUAGE == 'DE' ? '.' : '-');
				}
			});
			
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

		private function reset() {
			Main.KEYBOARD.hide();
			
			Main.FOOTER.resetButtonBar();
			Main.FOOTER.login.visible = false;
			Main.FOOTER.logout.visible = false;
			
			// Before position could be changed ensure that no tween is running.
			
			TweenLite.killTweensOf(question);
			TweenLite.killTweensOf(yesButton);
			TweenLite.killTweensOf(noButton);
			TweenLite.killTweensOf(idLabel);
			TweenLite.killTweensOf(idInput);
			TweenLite.killTweensOf(firstnameLabel);
			TweenLite.killTweensOf(firstnameInput);
			TweenLite.killTweensOf(lastnameLabel);
			TweenLite.killTweensOf(lastnameInput);
			TweenLite.killTweensOf(cityLabel);
			TweenLite.killTweensOf(cityInput);
			TweenLite.killTweensOf(dateOfBirthLabel);
			TweenLite.killTweensOf(dateOfBirthInput);
		}

		public override function update() {
			reset();
			
			// reset all positions that are changed in onYes or onNo!
			
			if (Main.LANGUAGE == 'DE') {
				Main.HEADER.setText('Check-In');
			} else if (Main.LANGUAGE == 'EN') {
				Main.HEADER.setText('Check-in');
			}
			
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
		
		public function focusId(e:Event) {
			Main.KEYBOARD.activateFor(idInput.textField);
			Main.KEYBOARD.setOnEnterFunction(onEnter);
			Main.KEYBOARD.onNumberKeyPressed(e);
		}
		
		public function focusFirstname(e:Event) {
			Main.KEYBOARD.activateFor(firstnameInput.textField);
			Main.KEYBOARD.setOnEnterFunction(onEnter);
		}
		
		public function focusLastname(e:Event) {
			Main.KEYBOARD.activateFor(lastnameInput.textField);
			Main.KEYBOARD.setOnEnterFunction(onEnter);
		}
		
		public function focusCity(e:Event) {
			Main.KEYBOARD.activateFor(cityInput.textField);
			Main.KEYBOARD.setOnEnterFunction(onEnter);
		}
		
		public function focusDateOfBirth(e:Event) {
			Main.KEYBOARD.activateFor(dateOfBirthInput.textField);
			Main.KEYBOARD.setOnEnterFunction(onEnter);
			Main.KEYBOARD.onNumberKeyPressed(e);
		}
		
		public function checkPersonalData(e:Event) {
			if (firstnameInput.textField.length == 0) {
				firstnameInput.highlight(0xff0000);
				focusFirstname(e);
			} else if (lastnameInput.textField.length == 0) {
				lastnameInput.highlight(0xff0000);
				focusLastname(e);
			} else if (cityInput.textField.length == 0) {
				cityInput.highlight(0xff0000);
				focusCity(e);
			} else if (dateOfBirthInput.textField.length == 0) {
				dateOfBirthInput.highlight(0xff0000);
				focusDateOfBirth(e);
			} else {
				Main.KEYBOARD.hide();
			}
		}
		
		public function onEnter(textField:TextField) {
			if (textField == idInput.textField) {
				if (idInput.textField.length == 0) {
					idInput.highlight(0xff0000);
					focusId(null);
				} else {
					Main.KEYBOARD.hide();
				}
			} else if (textField == firstnameInput.textField) {
				focusLastname(null);
			} else if (textField == lastnameInput.textField) {
				focusCity(null);
			} else if (textField == cityInput.textField) {
				focusDateOfBirth(null);
			} else if (textField == dateOfBirthInput.textField) {
				checkPersonalData(null);
			}
		}
		
		public function onYes(e:Event) {
			// hack if someone clicks fast on yes and no
			update();
			
			Main.FOOTER.showCancelButton(Main.LANGUAGE == 'DE' ? 'Zurück' : 'Back', function(e:Event) {
				reset();
				
				// fade out - REVERSE
				TweenLite.to(yesButton, 0.8, { y: yesButton.y + 80, autoAlpha: 1 });
				TweenLite.to(noButton, 0.8, { y: yesButton.y + 80, autoAlpha: 1 });
				
				// fade in - REVERSE
				var fadeInTime:Number = 0.8;
				var fadeInDelay:Number = 0.0;
				TweenLite.to(idLabel, fadeInTime,   { autoAlpha: 0, delay: fadeInDelay });
				TweenLite.to(idInput, fadeInTime,   { autoAlpha: 0, delay: fadeInDelay });
			});
			Main.FOOTER.cancel.x = Grid.COLUMN_2;
			
			Main.FOOTER.showSubmitButton(Main.LANGUAGE == 'DE' ? 'Weiter' : 'Next', checkPersonalData);
			
			Main.FOOTER.submit.color = 'lightgray';
			Main.FOOTER.submit.textFormat.color = 0x888888;
			Main.FOOTER.submit.update();
			Main.FOOTER.submit.x = Grid.COLUMN_5;
			
			// fade out
			TweenLite.to(yesButton, 0.8, { y: yesButton.y - 80, autoAlpha: 0 });
			TweenLite.to(noButton, 0.8, { y: yesButton.y - 80, autoAlpha: 0 });
			
			// fade in
			var fadeInTime:Number = 2.6;
			var fadeInDelay:Number = 0.4;
			TweenLite.to(idLabel, fadeInTime,   { autoAlpha: 1, delay: fadeInDelay });
			TweenLite.to(idInput, fadeInTime,   { autoAlpha: 1, delay: fadeInDelay });
			
			focusId(e);
		}
		
		public function onNo(e:Event) {
			// hack if someone clicks fast on yes and no
			update();
			
			Main.FOOTER.showCancelButton(Main.LANGUAGE == 'DE' ? 'Zurück' : 'Back', function(e:Event) {
				reset();
				
				// move up - REVERSE
				TweenLite.to(question, 0.8, { y: question.y + 80 });
			
				// face out - REVERSE
				TweenLite.to(yesButton, 0.8, { y: yesButton.y + 80, autoAlpha: 1 });
				TweenLite.to(noButton, 0.8, { y: noButton.y + 80, autoAlpha: 1 });
			
				// fade in - REVERSE
				var fadeInTime:Number = 0.8;
				var fadeInDelay:Number = 0.0;
				TweenLite.to(firstnameLabel, fadeInTime,   { autoAlpha: 0, delay: fadeInDelay });
				TweenLite.to(firstnameInput, fadeInTime,   { autoAlpha: 0, delay: fadeInDelay });
				TweenLite.to(lastnameLabel, fadeInTime,    { autoAlpha: 0, delay: fadeInDelay });
				TweenLite.to(lastnameInput, fadeInTime,    { autoAlpha: 0, delay: fadeInDelay });
				TweenLite.to(cityLabel, fadeInTime,        { autoAlpha: 0, delay: fadeInDelay });
				TweenLite.to(cityInput, fadeInTime,        { autoAlpha: 0, delay: fadeInDelay });
				TweenLite.to(dateOfBirthLabel, fadeInTime, { autoAlpha: 0, delay: fadeInDelay });
				TweenLite.to(dateOfBirthInput, fadeInTime, { autoAlpha: 0, delay: fadeInDelay });
			});
			Main.FOOTER.cancel.x = Grid.COLUMN_2;
			
			Main.FOOTER.showSubmitButton(Main.LANGUAGE == 'DE' ? 'Weiter' : 'Next', checkPersonalData);
			
			Main.FOOTER.submit.color = 'lightgray';
			Main.FOOTER.submit.textFormat.color = 0x888888;
			Main.FOOTER.submit.update();
			Main.FOOTER.submit.x = Grid.COLUMN_5;
			
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
			cityLabel.y = 440;
			cityLabel.visible = true;
			cityLabel.alpha = 0;
			
			cityInput.x = Grid.COLUMN_3;
			cityInput.y = 440;
			cityInput.visible = true;
			cityInput.alpha = 0;
			
			dateOfBirthLabel.x = Grid.COLUMN_2;
			dateOfBirthLabel.y = 510;
			dateOfBirthLabel.visible = true;
			dateOfBirthLabel.alpha = 0;

			dateOfBirthInput.x = Grid.COLUMN_3;
			dateOfBirthInput.y = 510;
			dateOfBirthInput.visible = true;
			dateOfBirthInput.alpha = 0;
			
			// move up
			TweenLite.to(question, 0.8, { y: question.y - 80 });
			
			// face out
			TweenLite.to(yesButton, 0.8, { y: yesButton.y - 80, autoAlpha: 0 });
			TweenLite.to(noButton, 0.8, { y: noButton.y - 80, autoAlpha: 0 });
			
			// fade in
			var fadeInTime:Number = 2.6;
			var fadeInDelay:Number = 0.4;
			TweenLite.to(firstnameLabel, fadeInTime,   { autoAlpha: 1, delay: fadeInDelay });
			TweenLite.to(firstnameInput, fadeInTime,   { autoAlpha: 1, delay: fadeInDelay });
			TweenLite.to(lastnameLabel, fadeInTime,    { autoAlpha: 1, delay: fadeInDelay });
			TweenLite.to(lastnameInput, fadeInTime,    { autoAlpha: 1, delay: fadeInDelay });
			TweenLite.to(cityLabel, fadeInTime,        { autoAlpha: 1, delay: fadeInDelay });
			TweenLite.to(cityInput, fadeInTime,        { autoAlpha: 1, delay: fadeInDelay });
			TweenLite.to(dateOfBirthLabel, fadeInTime, { autoAlpha: 1, delay: fadeInDelay });
			TweenLite.to(dateOfBirthInput, fadeInTime, { autoAlpha: 1, delay: fadeInDelay });
			
			focusFirstname(e);
		}
	}
	
}
