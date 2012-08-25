package  {

	import flash.display.MovieClip;
	import flash.display.Stage;
	
	import views.ButtonBar;
	import views.UI;
	import views.Header;
	import views.Views;
	import widgets.VirtualKeyboard;

	public class Main extends MovieClip {
		
		public static var LANGUAGE:String = 'DE';
		
		public static var STAGE:Stage;
		
		public static var HEADER:Header;
		public static var CONTENT:UI;
		public static var FOOTER:ButtonBar;
		
		public static var KEYBOARD:VirtualKeyboard;
		
		public function Main() {
			trace('Main movie loaded with stage size', this.stage.stageWidth, this.stage.stageHeight);
			Main.STAGE = stage;
			
			Main.HEADER = new Header();
			Main.CONTENT = new UI();
			Main.FOOTER = new ButtonBar();
			
			Main.KEYBOARD = new VirtualKeyboard();
			Main.KEYBOARD.x = Main.STAGE.stageWidth * 0.5 - VirtualKeyboard.KEYBOARD_WIDTH * 0.5;
			Main.KEYBOARD.y = 620;
			Main.KEYBOARD.visible = false;
			
			addChild(Main.CONTENT);
			addChild(Main.HEADER);
			addChild(Main.FOOTER);
			
			Main.CONTENT.pushView(Views.Index);
		}
	}

}
