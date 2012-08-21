package views {
	import widgets.SmallButton;
	import utils.Grid;
	import flash.events.MouseEvent;
	import flash.display.Loader;
	import flash.net.URLRequest;
	
	public class ButtonBar extends View {

		var home:SmallButton;
		var back:SmallButton;
		var logout:SmallButton;

		public function ButtonBar() {
			
			home = new SmallButton('Hauptmenü', 'lightgray');
			home.textFormat.color = '0x000000';
			home.x = Grid.COLUMN_1;
			home.y = Grid.BUTTON_BAR_Y;
			home.shapeWidth = Grid.SPAN_1;
			home.shapeHeight = Grid.BUTTON_BAR_HEIGHT;
			home.addEventListener(MouseEvent.CLICK, Main.CONTENT.onHome);
			home.update();
			addChild(home);
			
			back = new SmallButton('Zurück', 'lightgray');
			back.textFormat.color = '0x000000';
			back.x = Grid.COLUMN_2;
			back.y = Grid.BUTTON_BAR_Y;
			back.shapeWidth = Grid.SPAN_1;
			back.shapeHeight = Grid.BUTTON_BAR_HEIGHT;
			back.addEventListener(MouseEvent.CLICK, Main.CONTENT.onBack);
			back.update();
			addChild(back);
			
			// Achtung: "SecurityError: Error #2000: Kein aktiver Sicherheitskontext."
			// bedeutet einfach nur das die URL falsch ist!
			var loader:Loader = new Loader();
			loader.load(new URLRequest('../resources/german_32.png'));
			home.addChild(loader);
			
			// Achtung: "SecurityError: Error #2000: Kein aktiver Sicherheitskontext."
			// bedeutet einfach nur das die URL falsch ist!
			loader = new Loader();
			loader.load(new URLRequest('../resources/english_32.png'));
			back.addChild(loader);
			
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

		public function updateButtonBar() {
			if (Main.CONTENT.viewStack.length > 1) {
				home.textFormat.color = '0x000000';
				home.update();
				back.visible = true;
			} else {
				home.textFormat.color = '0x888888';
				home.update();
				back.visible = false;
			}
		}
		
	}
	
}
