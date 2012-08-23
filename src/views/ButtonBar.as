package views {
	import widgets.SmallButton;
	import utils.Grid;
	import flash.events.MouseEvent;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.text.TextFieldAutoSize;
	
	public class ButtonBar extends View {

		var de:SmallButton;
		var en:SmallButton;
		
		var home:SmallButton;
		var back:SmallButton;
		var logout:SmallButton;

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
			
			home = new SmallButton('Hauptmenü', 'lightgray');
			home.textFormat.color = '0x000000';
			home.x = Grid.COLUMN_1;
			home.y = Grid.BUTTON_BAR_Y;
			home.shapeWidth = Grid.SPAN_1;
			home.shapeHeight = Grid.BUTTON_BAR_HEIGHT;
			home.addEventListener(MouseEvent.CLICK, Main.CONTENT.onHome);
			home.update();
			home.visible = false;
			addChild(home);
			
			back = new SmallButton('Zurück', 'lightgray');
			back.textFormat.color = '0x000000';
			back.x = Grid.COLUMN_2;
			back.y = Grid.BUTTON_BAR_Y;
			back.shapeWidth = Grid.SPAN_1;
			back.shapeHeight = Grid.BUTTON_BAR_HEIGHT;
			back.addEventListener(MouseEvent.CLICK, Main.CONTENT.onBack);
			back.update();
			back.visible = false;
			addChild(back);
			
			logout = new SmallButton('Abmelden', 'lightgray');
			logout.textFormat.color = '0x000000';
			logout.x = Grid.COLUMN_6;
			logout.y = Grid.BUTTON_BAR_Y;
			logout.shapeWidth = Grid.SPAN_1;
			logout.shapeHeight = Grid.BUTTON_BAR_HEIGHT;
			logout.addEventListener(MouseEvent.CLICK, Main.CONTENT.onBack);
			logout.update();
			addChild(logout);
			
		}

		public function changeLanguage(e:Event) {
			if (e.currentTarget == de && Main.LANGUAGE != 'DE') {
				trace('Switch UI to german');
				Main.LANGUAGE = 'DE';
				de.color = 'languageButtonActive';
				en.color = 'languageButtonInactive';
				de.update();
				en.update();
				Main.CONTENT.updateView();
			} else if (e.currentTarget == en && Main.LANGUAGE != 'EN') {
				trace('Switch UI to english');
				Main.LANGUAGE = 'EN';
				de.color = 'languageButtonInactive';
				en.color = 'languageButtonActive';
				de.update();
				en.update();
				Main.CONTENT.updateView();
			}
		}

		public function updateButtonBar() {
			if (Main.CONTENT.viewStack.length > 1) {
				de.visible = false;
				en.visible = false;
				home.visible = true;
				back.visible = true;
			} else {
				de.visible = true;
				en.visible = true;
				home.visible = false;
				back.visible = false;
			}
		}
		
	}
	
}
