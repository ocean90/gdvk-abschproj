package  {

	import flash.display.MovieClip;
	import flash.display.Stage;
	
	import com.greensock.plugins.TweenPlugin;
	import com.greensock.plugins.AutoAlphaPlugin;
	import com.greensock.plugins.HexColorsPlugin;
	import com.greensock.plugins.ColorTransformPlugin;
	
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
		
		public static var USER:User = new User();
		
		public function Main() {
			trace('Main movie loaded with stage size', this.stage.stageWidth, this.stage.stageHeight);
			
			TweenPlugin.activate([AutoAlphaPlugin, HexColorsPlugin, ColorTransformPlugin]);
			
			Main.STAGE = stage;
			
			Main.HEADER = new Header();
			Main.CONTENT = new UI();
			Main.FOOTER = new ButtonBar();
			Main.FOOTER.update();
			
			Main.KEYBOARD = new VirtualKeyboard();
			Main.KEYBOARD.x = Main.STAGE.stageWidth * 0.5 - VirtualKeyboard.KEYBOARD_WIDTH * 0.5;
			Main.KEYBOARD.y = 620;
			Main.KEYBOARD.visible = false;
			
			addChild(Main.CONTENT);
			addChild(Main.HEADER);
			addChild(Main.FOOTER);
			
			addChild(Main.KEYBOARD);
			
			Main.CONTENT.pushHome(Views.Index);
		}
	}

}
