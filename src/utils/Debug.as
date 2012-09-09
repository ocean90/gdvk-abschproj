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
			Main.STAGE.addEventListener(KeyboardEvent.KEY_UP, toggleDebug);
		}

		private function toggleDebug(e:KeyboardEvent):void {
			if (!e.ctrlKey && !e.altKey) {
				return;
			}

			switch (e.keyCode) {
				case Keyboard.D:
					Main.STAGE.setChildIndex(gridOverlay, Main.STAGE.numChildren - 1);
					gridOverlay.visible = ! gridOverlay.visible;
					break;
				case Keyboard.S:
					Main.SCREENSAVER.show(e);
					break;
				case Keyboard.L:
					if (Main.LANGUAGE != 'DE') {
						trace('Switch UI to german');
						Main.LANGUAGE = 'DE';
						Main.HEADER.reset();
						Main.FOOTER.update();
						Main.CONTENT.updateView();
					} else if (Main.LANGUAGE != 'EN') {
						trace('Switch UI to english');
						Main.LANGUAGE = 'EN';
						Main.HEADER.reset();
						Main.FOOTER.update();
						Main.CONTENT.updateView();
					}
					break;
			}
		}
	}
}