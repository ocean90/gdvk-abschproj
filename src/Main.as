package  {

	import flash.display.MovieClip;
	
	import views.ButtonBar;
	import views.UI;
	import views.Header;
	import views.Views;

	public class Main extends MovieClip {
		
		public static var HEADER:Header;
		public static var CONTENT:UI;
		public static var FOOTER:ButtonBar;
		
		public function Main() {
			trace('Main movie loaded with stage size', this.stage.stageWidth, this.stage.stageHeight);
			
			Main.HEADER = new Header();
			Main.CONTENT = new UI();
			Main.FOOTER = new ButtonBar();
			
			addChild(Main.CONTENT);
			addChild(Main.HEADER);
			addChild(Main.FOOTER);
			
			Main.CONTENT.pushView(Views.Index);
		}
	}

}
