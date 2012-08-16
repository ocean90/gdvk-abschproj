package  {

	import flash.display.MovieClip;
	
	import utils.Buttons;
	import utils.UI;
	import utils.DebugGrid;

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
