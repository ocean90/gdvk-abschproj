package utils {
	import flash.display.MovieClip;
	import flash.display.Sprite;

	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;

	public class Debug extends Sprite {
		private var gridOverlay:MovieClip;

		public function Debug() {
			gridOverlay = new GridOverlay();
			gridOverlay.visible = false;
			Main.STAGE.addChild(gridOverlay);
			Main.STAGE.addEventListener(KeyboardEvent.KEY_DOWN, toggleDebug);
		}

		private function toggleDebug(e:KeyboardEvent):void {
			var key:uint = e.keyCode;

			switch (key) {
				case Keyboard.D :
					Main.STAGE.setChildIndex(gridOverlay, Main.STAGE.numChildren - 1);
					gridOverlay.visible = ! gridOverlay.visible;
					break;
			}
		}
	}
}