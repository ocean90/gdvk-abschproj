﻿package  {

	import flash.display.MovieClip;
	
	import views.ButtonBar;
	import views.UI;
	import views.Header;
	import views.Views;
	import flash.display.Stage;

	public class Main extends MovieClip {
		
		public static var LANGUAGE:String = 'DE';
		
		public static var STAGE:Stage;
		public static var HEADER:Header;
		public static var CONTENT:UI;
		public static var FOOTER:ButtonBar;
		
		public function Main() {
			trace('Main movie loaded with stage size', this.stage.stageWidth, this.stage.stageHeight);
			Main.STAGE = stage;
			
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
