package views {
	import com.greensock.TweenLite;
	import com.greensock.easing.Back;
	import com.greensock.easing.Quint;

	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.text.TextFieldAutoSize;

	import utils.Grid;

	import widgets.SmallButton;

	/**
	 * Verantwortlich für die ButtonBar am unterem Rand der Bildschirms. Verwaltet:
	 * - die Sprach-Auswahl-Button (nur sichtbar auf der Start-Seite)
	 * - den Home-Button   (nur sichtbar wenn min. 1 Seite  auf dem View-Stack liegt)
	 * - den Zurück-Button (nur sichtbar wenn min. 2 Seiten auf dem View-Stack liegen)
	 * - Die Cancel/Submit-Buttons (nur auf Anfrage Sichtbar! Andere Buttons werden ggf. ausgeblendet.)
	 * - Den Login-Button gibt es nicht mehr.
	 * - Den Logout-Button wenn der Benutzer eingeloggt ist.
	 */
	public class ButtonBar extends View {

		public var background:MovieClip;
		public var buttons:Sprite;

		private var de:SmallButton;
		private var en:SmallButton;

		public var home:SmallButton;
		public var back:SmallButton;
//		public var login:SmallButton;
		public var logout:SmallButton;

		public var cancel:SmallButton;
		// callback function, argument Event
		private var cancelCallback:Function;

		public var submit:SmallButton;
		// callback function, argument Event
		private var submitCallback:Function;

		private var englishFlag:MovieClip;
		private var germanFlag:MovieClip;

		public function ButtonBar() {
			background = new ButtonBarBackground();
			background.y = Main.STAGE.stageHeight - 100;
			background.x = 0;
			addChild(background);
			
			buttons = new Sprite();

			englishFlag = new EnglishFlag();
			germanFlag = new GermanFlag();

			de = new SmallButton('Deutsch', 'languageButtonActive');
			de.textField.x = 50;
			de.textFormat.align = TextFieldAutoSize.LEFT;
			de.textFormat.color = '0x000000';
			de.x = Grid.COLUMN_1;
			de.y = Grid.BUTTON_BAR_Y;
			de.shapeWidth = Grid.SPAN_1;
			de.shapeHeight = Grid.BUTTON_BAR_BUTTON_HEIGHT;
			de.addEventListener(MouseEvent.CLICK, changeLanguage);
			de.update();
			germanFlag.x = 10;
			germanFlag.y = (de.shapeHeight - de.defaultShadowSize) * 0.5 - germanFlag.height * 0.5;
			de.addChild(germanFlag);

			en = new SmallButton('English', 'languageButtonInactive');
			en.textField.x = 50;
			en.textFormat.align = TextFieldAutoSize.LEFT;
			en.textFormat.color = '0x000000';
			en.x = Grid.COLUMN_2;
			en.y = Grid.BUTTON_BAR_Y;
			en.shapeWidth = Grid.SPAN_1;
			en.shapeHeight = Grid.BUTTON_BAR_BUTTON_HEIGHT;
			en.addEventListener(MouseEvent.CLICK, changeLanguage);
			en.update();
			englishFlag.x = 10;
			englishFlag.y = (en.shapeHeight - en.defaultShadowSize) * 0.5 - englishFlag.height * 0.5;
			en.addChild(englishFlag);


			home = new SmallButton('', 'lightgray');
			home.textFormat.color = '0x000000';
			home.x = Grid.COLUMN_1;
			home.y = Grid.BUTTON_BAR_Y;
			home.shapeWidth = Grid.SPAN_1;
			home.shapeHeight = Grid.BUTTON_BAR_BUTTON_HEIGHT;
			home.visible = false;
			home.addEventListener(MouseEvent.CLICK, Main.CONTENT.onHome);

			back = new SmallButton('', 'lightgray');
			back.textFormat.color = '0x000000';
			back.x = Grid.COLUMN_2;
			back.y = Grid.BUTTON_BAR_Y;
			back.shapeWidth = Grid.SPAN_1;
			back.shapeHeight = Grid.BUTTON_BAR_BUTTON_HEIGHT;
			back.visible = false;
			back.addEventListener(MouseEvent.CLICK, Main.CONTENT.onBack);

			//login = new SmallButton('', 'green');
//			login.textFormat.color = '0x000000';
//			login.x = Grid.COLUMN_6;
//			login.y = Grid.BUTTON_BAR_Y;
//			login.shapeWidth = Grid.SPAN_1;
//			login.shapeHeight = Grid.BUTTON_BAR_BUTTON_HEIGHT;
//			login.visible = false;
//			login.addEventListener(MouseEvent.CLICK, function(e:Event) {
//				Views.CheckIn.cancelCallback = null;
//				Views.CheckIn.submitCallback = null;
//				Main.CONTENT.pushView(Views.CheckIn);
//			});

			logout = new SmallButton('', 'red');
			logout.x = Grid.COLUMN_6;
			logout.y = Grid.BUTTON_BAR_Y;
			logout.shapeWidth = Grid.SPAN_1;
			logout.shapeHeight = Grid.BUTTON_BAR_BUTTON_HEIGHT;
			logout.visible = false;
			logout.addEventListener(MouseEvent.CLICK, function(e:Event) {
				Main.USER.logout();
				Main.CONTENT.onHome(e);

				logout.visible = false;
//				login.alpha = 0;
//				login.visible = true;
//				TweenLite.to(login, 2.0, { autoAlpha: 1.0 });
			});

			cancel = new SmallButton('', 'red');
			cancel.x = Grid.COLUMN_1;
			cancel.y = Grid.BUTTON_BAR_Y;
			cancel.shapeWidth = Grid.SPAN_1;
			cancel.shapeHeight = Grid.BUTTON_BAR_BUTTON_HEIGHT;
			cancel.visible = false;
			cancel.addEventListener(MouseEvent.CLICK, onCancel);

			submit = new SmallButton('', 'green');
			submit.x = Grid.COLUMN_6;
			submit.y = Grid.BUTTON_BAR_Y;
			submit.shapeWidth = Grid.SPAN_1;
			submit.shapeHeight = Grid.BUTTON_BAR_BUTTON_HEIGHT;
			submit.visible = false;
			submit.addEventListener(MouseEvent.CLICK, onSubmit);
			
			// Add buttons
			buttons.addChild(de);
			buttons.addChild(en);
			buttons.addChild(home);
			buttons.addChild(back);
//			buttons.addChild(login);
			buttons.addChild(logout);
			buttons.addChild(cancel);
			buttons.addChild(submit);
			addChild(buttons);
		}

		public function changeLanguage(e:Event) {
			if (e.currentTarget == de && Main.LANGUAGE != 'DE') {
				trace('Switch UI to german');
				Main.LANGUAGE = 'DE';
				de.color = 'languageButtonActive';
				en.color = 'languageButtonInactive';
				update();
				Main.CONTENT.updateView();
			} else if (e.currentTarget == en && Main.LANGUAGE != 'EN') {
				trace('Switch UI to english');
				Main.LANGUAGE = 'EN';
				de.color = 'languageButtonInactive';
				en.color = 'languageButtonActive';
				update();
				Main.CONTENT.updateView();
			}
		}

		public function showCancelButton(text:String, callback:Function) {
			cancel.x = Grid.COLUMN_1;
			cancel.shapeWidth = Grid.SPAN_1;
			cancel.visible = true;
			cancel.setText(text);
			cancelCallback = callback;
		}

		function onCancel(e:Event) {
			if (cancelCallback != null) {
				cancelCallback(e);
			}
		}

		public function showSubmitButton(text:String, callback:Function) {
			submit.x = Grid.COLUMN_6;
			submit.shapeWidth = Grid.SPAN_1;
			submit.visible = true;
			submit.setText(text);
			submitCallback = callback;
		}

		function onSubmit(e:Event) {
			if (submitCallback != null) {
				submitCallback(e);
			}
		}

		public override function update() {
			de.update();
			en.update();

			home.setText(Main.LANGUAGE == 'DE' ? 'Hauptmenü' : 'Home');
			back.setText(Main.LANGUAGE == 'DE' ? 'Zurück' : 'Back');
//			login.setText(Main.LANGUAGE == 'DE' ? 'Anmelden' : 'Login');
			logout.setText(Main.LANGUAGE == 'DE' ? 'Abmelden' : 'Logout');
		}

		public function resetButtonBar() {
			TweenLite.to(background, 0.3, { x: 0, ease:Quint.easeOut });

			if (Main.CONTENT.length <= 1) {
				// inkl. home bedeutet wir sind auf der starteseite und zeigen die länder auswahl an
				de.visible = true;
				en.visible = true;
				home.visible = false;
				back.visible = false;
			} else if (Main.CONTENT.length == 2) {
				// inkl. home zwei bedeutet wir haben nur eine view und brauchen kein zurück
				de.visible = false;
				en.visible = false;
				home.visible = true;
				back.visible = false;
			} else {
				de.visible = false;
				en.visible = false;
				home.visible = true;
				back.visible = true;
			}

			if (Main.USER.isLoggedIn()) {
//				login.visible = false;
				logout.visible = true;
			} else {
//				login.visible = true;
				logout.visible = false;
			}
			cancel.visible = false;
			submit.visible = false;
		}
	}

}
