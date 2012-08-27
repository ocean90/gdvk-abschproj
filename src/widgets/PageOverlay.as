package widgets {
	import flash.display.Sprite;

	public class PageOverlay extends Sprite {
		private var _owidth:int;
		private var _oheight:int;
		private var _background:uint;
		private var _stagewidth:int;
		private var _stageheight:int;

		private var _overlay:Sprite;

		public function PageOverlay(w:int = 1080,h:int = 824) {
			_owidth = w;
			_oheight = h;
			_background = 0x000000;
			_stagewidth = Main.STAGE.stageWidth;
			_stageheight = Main.STAGE.stageHeight

			_overlay = new Sprite();
			Main.STAGE.addChild(_overlay);

			darkenPage();
			paintContentBox();
		}

		public function getContent():Sprite {
			var content:Sprite = new Sprite();
			content.x = 0;
			content.y = 0;
			content.width = _owidth;
			content.height = _oheight;

			return content;
		}

		public function setContent(content:Sprite) {
			_overlay.addChild(content);
		}

		public function darkenPage() {
			var dark:Sprite = new Sprite();
			dark.graphics.beginFill(0x000000);
			dark.graphics.drawRect(0, 0, _stagewidth, _stageheight);
			dark.graphics.endFill();
			dark.alpha = 0.8;

			_overlay.addChild(dark);
		}

		public function paintContentBox() {
			var x:int, y:int;
			var contentBox:Sprite = new Sprite();
			x = _stagewidth * 0.5 - _owidth * 0.5;
			y = _stageheight * 0.5 - _oheight * 0.5;
			contentBox.graphics.beginFill(0x000000);
			contentBox.graphics.drawRect(x, y, _owidth, _oheight);
			contentBox.graphics.endFill();

			_overlay.addChild(contentBox);
		}
	}
}