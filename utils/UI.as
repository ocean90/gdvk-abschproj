﻿package utils {
		
	import flash.display.MovieClip;
	
	import utils.Buttons;
	
	public class UI extends MovieClip {

		public function UI() {
			indexPage();
		}
		
		public function indexPage() {
			addChild(new Buttons(446, 231, 'red'));
			addChild(new Buttons(866, 231, 'blue'));
			addChild(new Buttons(446, 441, 'yellow'));
			addChild(new Buttons(866, 441, 'green'));
			addChild(new Buttons(24, 651, 'purple'));
			addChild(new Buttons(446, 651, 'brown'));
			addChild(new Buttons(866, 651));
		}

	}
	
}
