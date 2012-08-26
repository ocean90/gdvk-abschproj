package views {
	import widgets.SmallButton;
	import utils.Grid;
	import flash.events.MouseEvent;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.text.TextFieldAutoSize;
	import com.greensock.TweenLite;
	
	public class ButtonBar extends View {

		private var de:SmallButton;
		private var en:SmallButton;
		
		public var home:SmallButton;
		public var back:SmallButton;
		public var login:SmallButton;
		public var logout:SmallButton;

		public var cancel:SmallButton;
		// callback function, argument Event
		private var cancelCallback:Function;
		
		public var submit:SmallButton;
		// callback function, argument Event
		private var submitCallback:Function;

		public function ButtonBar() {
			
			de = new SmallButton('Deutsch', 'languageButtonActive');
			de.textField.x = 50;
			de.textFormat.align = TextFieldAutoSize.LEFT;
			de.textFormat.color = '0x000000';
			de.x = Grid.COLUMN_1;
			de.y = Grid.BUTTON_BAR_Y;
			de.shapeWidth = Grid.SPAN_1;
			de.shapeHeight = Grid.BUTTON_BAR_HEIGHT;
			de.addEventListener(MouseEvent.CLICK, changeLanguage);
			de.update();
			addChild(de);
			
			// Achtung: "SecurityError: Error #2000: Kein aktiver Sicherheitskontext."
			// bedeutet einfach nur das die URL falsch ist!
			var loader:Loader = new Loader();
			loader.load(new URLRequest('../resources/german_32.png'));
			loader.x = 10;
			loader.y = 12;
			de.addChild(loader);
			
			en = new SmallButton('English', 'languageButtonInactive');
			en.textField.x = 50;
			en.textFormat.align = TextFieldAutoSize.LEFT;
			en.textFormat.color = '0x000000';
			en.x = Grid.COLUMN_2;
			en.y = Grid.BUTTON_BAR_Y;
			en.shapeWidth = Grid.SPAN_1;
			en.shapeHeight = Grid.BUTTON_BAR_HEIGHT;
			en.addEventListener(MouseEvent.CLICK, changeLanguage);
			en.update();
			addChild(en);
			
			// Achtung: "SecurityError: Error #2000: Kein aktiver Sicherheitskontext."
			// bedeutet einfach nur das die URL falsch ist!
			loader = new Loader();
			loader.load(new URLRequest('../resources/english_32.png'));
			loader.x = 10;
			loader.y = 12;
			en.addChild(loader);
			
			home = new SmallButton('', 'lightgray');
			home.textFormat.color = '0x000000';
			home.x = Grid.COLUMN_1;
			home.y = Grid.BUTTON_BAR_Y;
			home.shapeWidth = Grid.SPAN_1;
			home.shapeHeight = Grid.BUTTON_BAR_HEIGHT;
			home.visible = false;
			home.addEventListener(MouseEvent.CLICK, Main.CONTENT.onHome);
			addChild(home);
			
			back = new SmallButton('', 'lightgray');
			back.textFormat.color = '0x000000';
			back.x = Grid.COLUMN_2;
			back.y = Grid.BUTTON_BAR_Y;
			back.shapeWidth = Grid.SPAN_1;
			back.shapeHeight = Grid.BUTTON_BAR_HEIGHT;
			back.visible = false;
			back.addEventListener(MouseEvent.CLICK, Main.CONTENT.onBack);
			addChild(back);
			
			login = new SmallButton('', 'lightgreen');
			login.textFormat.color = '0x000000';
			login.x = Grid.COLUMN_6;
			login.y = Grid.BUTTON_BAR_Y;
			login.shapeWidth = Grid.SPAN_1;
			login.shapeHeight = Grid.BUTTON_BAR_HEIGHT;
			login.visible = false;
			login.addEventListener(MouseEvent.CLICK, function(e:Event) {
				Views.CheckIn.cancelCallback = null;
				Views.CheckIn.submitCallback = null;
				Main.CONTENT.pushView(Views.CheckIn);
			});
			addChild(login);
			
			logout = new SmallButton('', 'lightred');
			logout.textFormat.color = '0x000000';
			logout.x = Grid.COLUMN_6;
			logout.y = Grid.BUTTON_BAR_Y;
			logout.shapeWidth = Grid.SPAN_1;
			logout.shapeHeight = Grid.BUTTON_BAR_HEIGHT;
			logout.visible = false;
			logout.addEventListener(MouseEvent.CLICK, function(e:Event) {
				Main.USER.logout();
				Main.CONTENT.updateView();
				
				logout.visible = 0;
				login.alpha = 0;
				login.visible = true;
				TweenLite.to(login, 2.0, { autoAlpha: 1.0 });
			});
			addChild(logout);
			
			cancel = new SmallButton('', 'lightred');
			cancel.textFormat.color = '0x000000';
			cancel.x = Grid.COLUMN_1;
			cancel.y = Grid.BUTTON_BAR_Y;
			cancel.shapeWidth = Grid.SPAN_1;
			cancel.shapeHeight = Grid.BUTTON_BAR_HEIGHT;
			cancel.visible = false;
			cancel.addEventListener(MouseEvent.CLICK, onCancel);
			addChild(cancel);
			
			submit = new SmallButton('', 'lightgreen');
			submit.textFormat.color = '0x000000';
			submit.x = Grid.COLUMN_6;
			submit.y = Grid.BUTTON_BAR_Y;
			submit.shapeWidth = Grid.SPAN_1;
			submit.shapeHeight = Grid.BUTTON_BAR_HEIGHT;
			submit.visible = false;
			submit.addEventListener(MouseEvent.CLICK, onSubmit);
			addChild(submit);
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
		
		public function onCancel(e:Event) {
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
		
		public function onSubmit(e:Event) {
			if (submitCallback != null) {
				submitCallback(e);
			}
		}
		
		public override function update() {
			de.update();
			en.update();
			
			home.setText(Main.LANGUAGE == 'DE' ? 'Hauptmenü' : 'Home');
			back.setText(Main.LANGUAGE == 'DE' ? 'Zurück' : 'Back');
			login.setText(Main.LANGUAGE == 'DE' ? 'Anmelden' : 'Login');
			logout.setText(Main.LANGUAGE == 'DE' ? 'Abmelden' : 'Logout');
		}

		public function resetButtonBar() {
			if (Main.CONTENT.viewStack.length <= 1) {
				// inkl. home bedeutet wir sind auf der starteseite und zeigen die länder auswahl an
				de.visible = true;
				en.visible = true;
				home.visible = false;
				back.visible = false;
			} else if (Main.CONTENT.viewStack.length == 2) {
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
				login.visible = false;
				logout.visible = true;
			} else {
				login.visible = true;
				logout.visible = false;
			}
			cancel.visible = false;
			submit.visible = false;
		}
	}
	
}
