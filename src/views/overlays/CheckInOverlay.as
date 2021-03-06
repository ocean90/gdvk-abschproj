﻿package views.overlays {
	import flash.events.Event;
	import flash.display.Loader;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;

	import com.greensock.TweenLite;

	import utils.Grid;
	import views.View;
	import views.PageOverlay;
	import widgets.InputField;
	import widgets.TextLabel;
	import widgets.SmallButton;
	import widgets.BigButton;

	/**
	 * Der Check-In Dialog bietet optionen zum Anmelden mit und ohne persönliche ID.
	 * Im ersten Fall müssen die Daten noch geprüft werden.
	 * Im zweiten müssen die Daten vollständig eingegeben werden.
	 * Unterstützt wird fehlerhafte eingabe (aktuell entspricht dies leeren Feldern)
	 * sowie eine visuelle Unterstützung dadurch das der Weiter-Button erst bei
	 * validaten Daten grün wird.
	 * Geburtsdatum autovervollständigt den Punkt und die Tastatur wird beim
	 * persönliche ID automatisch auf Zahlenmodus umgestellt.
	 */
	public class CheckInOverlay extends PageOverlay {

		private static var MODE_QUESTION:String = 'id?';
		private static var MODE_PERSONAL_ID:String = 'yes';
		private static var MODE_PERSONAL_DATA:String = 'no';

		private var mode:String = MODE_QUESTION;

		private var question:TextLabel;
		private var yesButton:BigButton;
		private var noButton:BigButton;

		private var idLabel:TextLabel;
		private var idInput:InputField;

		private var firstnameLabel:TextLabel;
		private var firstnameInput:InputField;

		private var lastnameLabel:TextLabel;
		private var lastnameInput:InputField;

		private var cityLabel:TextLabel;
		private var cityInput:InputField;

		private var dateOfBirthLabel:TextLabel;
		private var dateOfBirthInput:InputField;

		// Function which was called if the user are successfully logged in!
		public var afterFinishCallback:Function = null;

		public function CheckInOverlay(background:* = 0xffffff, w:Number = 870,h:Number = 650) {
			super(background, w, h);

			content.x = -Grid.COLUMN_2 + Grid.COLUMN_PADDING;
			content.y = -60;
			createUI();
		}

		public function createUI():void {

			question = new TextLabel();
			question.shapeWidth = Grid.SPAN_4;
			question.shapeHeight = 100;
			question.textFormat.size = 30;
			question.textFormat.leading = 15;

			yesButton = new BigButton(Grid.COLUMN_2, 441, 'orange');
			yesButton.shapeWidth = Grid.SPAN_2;
			yesButton.shapeHeight = Grid.SPAN_1;
			yesButton.addEventListener(MouseEvent.CLICK, function(e:Event) {
				idInput.textField.text = '';
				firstnameInput.textField.text = '';
				lastnameInput.textField.text = '';
				cityInput.textField.text = '';
				dateOfBirthInput.textField.text = '';
				onYes(e);
			});
			yesButton.update();

			noButton = new BigButton(Grid.COLUMN_4, 441, 'orange');
			noButton.shapeWidth = Grid.SPAN_2;
			noButton.shapeHeight = Grid.SPAN_1;
			noButton.addEventListener(MouseEvent.CLICK, function(e:Event) {
				idInput.textField.text = '';
				firstnameInput.textField.text = '';
				lastnameInput.textField.text = '';
				cityInput.textField.text = '';
				dateOfBirthInput.textField.text = '';
				onNo(e);
			});
			noButton.update();

			idLabel = new TextLabel();
			idLabel.x = Grid.COLUMN_2;
			idLabel.y = 400;
			idLabel.shapeWidth = Grid.SPAN_1;
			idLabel.shapeHeight = 50;
//			idLabel.textFormat.align = TextFieldAutoSize.RIGHT;
			idLabel.visible = false;
			idLabel.addEventListener(MouseEvent.CLICK, focusId);

			idInput = new InputField();
			idInput.x = Grid.COLUMN_3;
			idInput.y = 400;
			idInput.shapeWidth = Grid.SPAN_3;
			idInput.shapeHeight = 50;
			idInput.update();
			idInput.visible = false;
			idInput.addEventListener(MouseEvent.CLICK, focusId);
			idInput.textField.addEventListener(Event.CHANGE, changeData);

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
			firstnameInput.textField.addEventListener(Event.CHANGE, changeData);

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
			lastnameInput.textField.addEventListener(Event.CHANGE, changeData);

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
			cityInput.textField.addEventListener(Event.CHANGE, changeData);

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
				var text:String = dateOfBirthInput.textField.text.replace(/[^0-9.-]/g, '');
				if (text.length > 10) {
					text = text.substr(0, 10);
				}
				if (text.length == 2 || text.length == 5) {
					text += (Main.LANGUAGE == 'DE' ? '.' : '-');
				}
				if (text != dateOfBirthInput.textField.text) {
					dateOfBirthInput.textField.text = text;
				}
				dateOfBirthInput.textField.setSelection(text.length, text.length);
			});
			dateOfBirthInput.textField.addEventListener(Event.CHANGE, changeData);

			content.addChild(yesButton);
			content.addChild(noButton);
			content.addChild(question);

			content.addChild(idLabel);
			content.addChild(idInput);

			content.addChild(firstnameLabel);
			content.addChild(firstnameInput);
			content.addChild(lastnameLabel);
			content.addChild(lastnameInput);
			content.addChild(cityLabel);
			content.addChild(cityInput);
			content.addChild(dateOfBirthLabel);
			content.addChild(dateOfBirthInput);
		}

		private function reset():void {
			Main.KEYBOARD.hide();

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

			// reset visiblity

			idLabel.visible = false;
			idInput.visible = false;
			idInput.update();

			firstnameLabel.visible = false;
			firstnameInput.visible = false;
			firstnameInput.update();

			lastnameLabel.visible = false;
			lastnameInput.visible = false;
			lastnameInput.update();

			cityLabel.visible = false;
			cityInput.visible = false;
			cityInput.update();

			dateOfBirthLabel.visible = false;
			dateOfBirthInput.visible = false;
			dateOfBirthInput.update();

			updateQuestion();
		}

		public function updateQuestion():void {
			if (mode == MODE_QUESTION) {
				if (Main.LANGUAGE == 'DE') {
					question.setText('Hast Du dich bereits auf unserer Webseite registriert\n' +
									 'und deine persönliche Einladung erhalten?');
				} else if (Main.LANGUAGE == 'EN') {
					question.setText('Have you already registered on our website\n' +
									 'and receive your personal invitation?');
				}
			} else if (mode == MODE_PERSONAL_ID) {
				if (Main.LANGUAGE == 'DE') {
					question.setText('Bitte gebe Deine persönliche ID ein:');
				} else if (Main.LANGUAGE == 'EN') {
					question.setText('Please enter your personal ID:');
				}
			} else if (mode == MODE_PERSONAL_DATA) {
				if (idInput.textField.text.length == 0) {
					if (Main.LANGUAGE == 'DE') {
						question.setText('Wir benötigen für den Weltrekordversuch folgende Daten\nvon allen Teilnehmern:');
					} else if (Main.LANGUAGE == 'EN') {
						question.setText('Please fill these required data for the world record:');
					}
				} else {
					if (Main.LANGUAGE == 'DE') {
						question.setText('Bitte überprüfe die Korrektheit Deiner Daten:');
					} else if (Main.LANGUAGE == 'EN') {
						question.setText('Please check if your data are correct:');
					}
				}
			}

			showCancelButton(Main.LANGUAGE == 'DE' ? 'Abbrechen' : 'Cancel', function(e:Event) {
				Main.CONTENT.hideOverlay();
			});
		}

		public override function update():void {
			reset();

			// reset all positions that are changed in onYes or onNo!
			question.x = Grid.COLUMN_2;
			question.y = 200;

			yesButton.x = Grid.COLUMN_2;
			yesButton.y = 350;
			yesButton.alpha = 1.0;
			yesButton.visible = true;

			noButton.x = Grid.COLUMN_4;
			noButton.y = 350;
			noButton.alpha = 1.0;
			noButton.visible = true;

			if (Main.LANGUAGE == 'DE') {
				setText('Check-In');
			} else if (Main.LANGUAGE == 'EN') {
				setText('Check-in');
			}

			if (Main.LANGUAGE == 'DE') {
				yesButton.setText('Check-In mit\npersönlicher ID');
			} else if (Main.LANGUAGE == 'EN') {
				yesButton.setText('Check-in with\na personal id');
			}

			if (Main.LANGUAGE == 'DE') {
				noButton.setText('Jetzt mit Name und\nAnschrift registrieren');
			} else if (Main.LANGUAGE == 'EN') {
				noButton.setText('Register now with\nname and address');
			}

			if (Main.LANGUAGE == 'DE') {
				idLabel.setText('Persönliche ID:');
			} else if (Main.LANGUAGE == 'EN') {
				idLabel.setText('Your personal id:');
			}

			if (Main.LANGUAGE == 'DE') {
				firstnameLabel.setText('Vorname:');
			} else if (Main.LANGUAGE == 'EN') {
				firstnameLabel.setText('Firstname:');
			}

			if (Main.LANGUAGE == 'DE') {
				lastnameLabel.setText('Nachname:');
			} else if (Main.LANGUAGE == 'EN') {
				lastnameLabel.setText('Surname:');
			}

			if (Main.LANGUAGE == 'DE') {
				cityLabel.setText('Stadt:');
			} else if (Main.LANGUAGE == 'EN') {
				cityLabel.setText('City:');
			}

			if (Main.LANGUAGE == 'DE') {
				dateOfBirthLabel.setText('Geburtsdatum:');
			} else if (Main.LANGUAGE == 'EN') {
				dateOfBirthLabel.setText('Date of birth:');
			}

			updateQuestion();
		}

		public function focusId(e:Event):void {
			Main.KEYBOARD.activateFor(idInput.textField);
			Main.KEYBOARD.setOnEnterFunction(onEnter);
			Main.KEYBOARD.onNumberKeyPressed(e);
		}

		public function focusFirstname(e:Event):void {
			Main.KEYBOARD.activateFor(firstnameInput.textField);
			Main.KEYBOARD.setOnEnterFunction(onEnter);
		}

		public function focusLastname(e:Event):void {
			Main.KEYBOARD.activateFor(lastnameInput.textField);
			Main.KEYBOARD.setOnEnterFunction(onEnter);
		}

		public function focusCity(e:Event):void {
			Main.KEYBOARD.activateFor(cityInput.textField);
			Main.KEYBOARD.setOnEnterFunction(onEnter);
		}

		public function focusDateOfBirth(e:Event):void {
			Main.KEYBOARD.activateFor(dateOfBirthInput.textField);
			Main.KEYBOARD.setOnEnterFunction(onEnter);
			Main.KEYBOARD.onNumberKeyPressed(e);
		}

		/**
		 * Diese Change-Methode wird bei allen CHANGE events aufgerufen.
		 */
		public function changeData(e:Event):void {
			// Wird unten auf false gesetzt wenn die Daten nicht vollständig wären.
			var validData:Boolean = true;

			if (mode == MODE_PERSONAL_ID) {
				if (idInput.textField.length == 0) {
					validData = false;
				}
			} else if (mode == MODE_PERSONAL_DATA) {
				if (firstnameInput.textField.length == 0) {
					validData = false;
				} else if (lastnameInput.textField.length == 0) {
					validData = false;
				} else if (cityInput.textField.length == 0) {
					validData = false;
				} else if (dateOfBirthInput.textField.length == 0) {
					validData = false;
				}
			}

			submit.color = validData ? 'green' : 'lightgray';
			submit.textFormat.color = validData ? '0xffffff' : '0x888888';
			submit.update();
		}

		/**
		 * Diese Check-Methode wird bei onEnter oder wenn der Benutzer auf Weiter drückt aufgerufen.
		 *
		 * Es wird geprüft ob alle Eingaben korrekt sein *können*.
		 * Im Prototyp ist diese Bedingung erfüllt wenn alle Felder nicht mehr leer sind.
		 */
		public function checkData(e:Event):Boolean {
			if (mode == MODE_PERSONAL_ID) {

				if (idInput.textField.length == 0) {
					idInput.highlight(0xff0000);
					focusId(null);
					return false;
				}

			} else if (mode == MODE_PERSONAL_DATA) {

				if (firstnameInput.textField.length == 0) {
					firstnameInput.highlight(0xff0000);
					focusFirstname(e);
					return false;
				} else if (lastnameInput.textField.length == 0) {
					lastnameInput.highlight(0xff0000);
					focusLastname(e);
					return false;
				} else if (cityInput.textField.length == 0) {
					cityInput.highlight(0xff0000);
					focusCity(e);
					return false;
				} else if (dateOfBirthInput.textField.length == 0) {
					dateOfBirthInput.highlight(0xff0000);
					focusDateOfBirth(e);
					return false;
				}

			}

			// Wenn keine prüfung fehlgeschlagen ist hat es wohl geklappt.
			Main.KEYBOARD.hide();
			return true;
		}

		/**
		 * Behandelt onEnter, bei manchen Feldern wird einfach weiter gesprungen
		 * und nur bei manchen (dem jeweils letzten) die Daten mit checkData geprüft.
		 */
		public function onEnter(textField:TextField):Boolean {
			if (textField == idInput.textField) {
				checkData(null);
			} else if (textField == firstnameInput.textField) {
				focusLastname(null);
			} else if (textField == lastnameInput.textField) {
				focusCity(null);
			} else if (textField == cityInput.textField) {
				focusDateOfBirth(null);
			} else if (textField == dateOfBirthInput.textField) {
				return checkData(null);
			}

			// Wenn kein checkData aufgerufen wurde (also vermutlich ein focusXy):
			return false;
		}

		public function onYes(e:Event):void {
			mode = MODE_PERSONAL_ID;
			// hack if someone clicks fast on yes and no
			reset();

			showCancelButton(Main.LANGUAGE == 'DE' ? 'Zurück' : 'Back', function(e:Event) {
				mode = MODE_QUESTION;
				reset();

				// fade out - REVERSE
				TweenLite.to(yesButton, 0.6, { autoAlpha: 1 });
				TweenLite.to(noButton, 0.6, { autoAlpha: 1 });

				// fade in - REVERSE
				var fadeInTime:Number = 0.4;
				var fadeInDelay:Number = 0.0;
				TweenLite.to(idLabel, fadeInTime,   { autoAlpha: 0, delay: fadeInDelay });
				TweenLite.to(idInput, fadeInTime,   { autoAlpha: 0, delay: fadeInDelay });
			});

			showSubmitButton(Main.LANGUAGE == 'DE' ? 'Weiter' : 'Next', function(e:Event) {
				if (checkData(e)) {
					mode = MODE_PERSONAL_DATA;

					firstnameInput.textField.text = 'Martin';
					lastnameInput.textField.text = 'Mustermann';
					cityInput.textField.text = 'Gummersbach';
					dateOfBirthInput.textField.text = (Main.LANGUAGE == 'DE' ? '13.05.1976' : '05-13-1976');

					onNo(e);
				}
			});

			// fade out
			TweenLite.to(yesButton, 0.6, { autoAlpha: 0 });
			TweenLite.to(noButton, 0.6, { autoAlpha: 0 });

			// fade in
			var fadeInTime:Number = 2.6;
			var fadeInDelay:Number = 0.2;
			TweenLite.to(idLabel, fadeInTime,   { autoAlpha: 1, delay: fadeInDelay });
			TweenLite.to(idInput, fadeInTime,   { autoAlpha: 1, delay: fadeInDelay });

			changeData(e); // updates the submit button color
			focusId(e);
		}

		public function onNo(e:Event):void {
			mode = MODE_PERSONAL_DATA;
			// hack if someone clicks fast on yes and no
			reset();

			showCancelButton(Main.LANGUAGE == 'DE' ? 'Zurück' : 'Back', function(e:Event) {
				mode = MODE_QUESTION;
				reset();

				// face out - REVERSE
				TweenLite.to(yesButton, 0.6, { autoAlpha: 1 });
				TweenLite.to(noButton, 0.6, { autoAlpha: 1 });

				// fade in - REVERSE
				var fadeInTime:Number = 0.4;
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

			showSubmitButton(Main.LANGUAGE == 'DE' ? 'Weiter' : 'Next', function(e:Event) {
				if (!checkData(e)) {
					return;
				}

				// Login the user
				Main.USER.login({
					'id': idInput.textField.text,
					'firstname': firstnameInput.textField.text,
					'lastname': lastnameInput.textField.text,
					'city': cityInput.textField.text,
					'dateOfBirth': dateOfBirthInput.textField.text
				});

				if (afterFinishCallback != null) {
					afterFinishCallback(e);
				}

				Main.CONTENT.hideOverlay();
			});

			firstnameLabel.x = Grid.COLUMN_2;
			firstnameLabel.y = 320;
			firstnameLabel.visible = true;
			firstnameLabel.alpha = 0;

			firstnameInput.x = Grid.COLUMN_3;
			firstnameInput.y = 320;
			firstnameInput.visible = true;
			firstnameInput.alpha = 0;

			lastnameLabel.x = Grid.COLUMN_2;
			lastnameLabel.y = 390;
			lastnameLabel.visible = true;
			lastnameLabel.alpha = 0;

			lastnameInput.x = Grid.COLUMN_3;
			lastnameInput.y = 390;
			lastnameInput.visible = true;
			lastnameInput.alpha = 0;

			cityLabel.x = Grid.COLUMN_2;
			cityLabel.y = 460;
			cityLabel.visible = true;
			cityLabel.alpha = 0;

			cityInput.x = Grid.COLUMN_3;
			cityInput.y = 460;
			cityInput.visible = true;
			cityInput.alpha = 0;

			dateOfBirthLabel.x = Grid.COLUMN_2;
			dateOfBirthLabel.y = 530;
			dateOfBirthLabel.visible = true;
			dateOfBirthLabel.alpha = 0;

			dateOfBirthInput.x = Grid.COLUMN_3;
			dateOfBirthInput.y = 530;
			dateOfBirthInput.visible = true;
			dateOfBirthInput.alpha = 0;

			// face out
			TweenLite.to(yesButton, 0.6, { autoAlpha: 0 });
			TweenLite.to(noButton, 0.6, { autoAlpha: 0 });

			// fade in
			var fadeInTime:Number = 2.6;
			var fadeInDelay:Number = 0.2;
			TweenLite.to(firstnameLabel, fadeInTime,   { autoAlpha: 1, delay: fadeInDelay });
			TweenLite.to(firstnameInput, fadeInTime,   { autoAlpha: 1, delay: fadeInDelay });
			TweenLite.to(lastnameLabel, fadeInTime,    { autoAlpha: 1, delay: fadeInDelay });
			TweenLite.to(lastnameInput, fadeInTime,    { autoAlpha: 1, delay: fadeInDelay });
			TweenLite.to(cityLabel, fadeInTime,        { autoAlpha: 1, delay: fadeInDelay });
			TweenLite.to(cityInput, fadeInTime,        { autoAlpha: 1, delay: fadeInDelay });
			TweenLite.to(dateOfBirthLabel, fadeInTime, { autoAlpha: 1, delay: fadeInDelay });
			TweenLite.to(dateOfBirthInput, fadeInTime, { autoAlpha: 1, delay: fadeInDelay });

			changeData(e); // updates the submit button color
			focusFirstname(e);
		}
	}

}
