package  {

	import flash.display.MovieClip;
	
	import utils.DebugGrid;
	import utils.UI;

	public class Main extends MovieClip {
		private var ui:UI;
		
		public function Main() {
			trace('Main movie loaded with stage size: ', this.stage.stageWidth, this.stage.stageHeight);
			addChild(new DebugGrid());
			
			ui = new UI();
			addChild(ui);
		}
	}
	
}
