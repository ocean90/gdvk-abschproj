package  {

	import flash.display.MovieClip;
	
	import utils.UI;

	public class Main extends MovieClip {
		
		public static var UI:utils.UI;
		
		public function Main() {
			trace('Main movie loaded with stage size: ', this.stage.stageWidth, this.stage.stageHeight);
			
			Main.UI = new utils.UI();
			addChild(Main.UI);
		}
	}
	
}
