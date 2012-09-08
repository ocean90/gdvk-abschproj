package  {

	import com.greensock.plugins.AutoAlphaPlugin;
	import com.greensock.plugins.ColorTransformPlugin;
	import com.greensock.plugins.HexColorsPlugin;
	import com.greensock.plugins.TweenPlugin;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.geom.Rectangle;

	import utils.Debug;
	import utils.Grid;

	import views.ButtonBar;
	import views.Header;
	import views.PageOverlay;
	import views.UI;
	import views.Screensaver;
	import views.Views;
	import views.main.IndexPage;

	import widgets.VirtualKeyboard;

	public class Main extends MovieClip {

		public static var LANGUAGE:String = 'DE';

		public static var STAGE:Stage;

		public static var HEADER:Header;
		public static var CONTENT:UI;
//		public static var OVERLAY:PageOverlay;
		public static var FOOTER:ButtonBar;

		public static var KEYBOARD:VirtualKeyboard;

		public static var DEBUG:Debug;

		public static var SCREENSAVER:Screensaver;

		public static var USER:User = new User();

		public function Main() {
			TweenPlugin.activate([AutoAlphaPlugin, HexColorsPlugin, ColorTransformPlugin]);

			// Don't overflow.
			this.scrollRect = new Rectangle(0, 0, Grid.STAGE_WIDTH, Grid.STAGE_HEIGHT);

			Main.STAGE = stage;

			Main.HEADER = new Header();
			Main.CONTENT = new UI();
//			Main.OVERLAY = new PageOverlay();
			Main.FOOTER = new ButtonBar();
			Main.FOOTER.update();

			Main.KEYBOARD = new VirtualKeyboard();
			Main.KEYBOARD.x = Main.STAGE.stageWidth * 0.5 - VirtualKeyboard.KEYBOARD_WIDTH * 0.5;
			Main.KEYBOARD.y = Main.STAGE.stageHeight - Grid.BUTTON_BAR_HEIGHT;
			Main.KEYBOARD.visible = false;

			addChild(Main.HEADER);
			addChild(Main.FOOTER);
			// Content und Overlay überdecken Header und Footer, aber nicht das Keyboard.
			addChild(Main.CONTENT);
//			addChild(Main.OVERLAY);
			addChild(Main.KEYBOARD);

			Main.DEBUG = new Debug();
			addChild(Main.DEBUG);

			Main.SCREENSAVER = new Screensaver( 0xffffff, Grid.STAGE_WIDTH - 50, Grid.STAGE_HEIGHT - 50);
		}
	}

}
