package widgets {
	import flash.display.Sprite;
	import flash.events.Event;

	import utils.Colors;

	public class PageOverlay extends Sprite {
		private var _owidth:Number;
		private var _oheight:Number;
		private var _background:uint;
		private var _stagewidth:Number;
		private var _stageheight:Number;

		private var _overlay:Sprite;
		public var contentBox:Sprite;

		public function PageOverlay(background:* = 0xffffff, w:Number = 1080,h:Number = 824) {
			_owidth = w;
			_oheight = h;
			_background = Colors.getColor(background);;
			_stagewidth = Main.STAGE.stageWidth;
			_stageheight = Main.STAGE.stageHeight

			_overlay = new Sprite();
			Main.STAGE.addChild(_overlay);

			darkenPage();
			paintContentBox();
		}

		public function getContentContainer():Sprite {
			var container:Sprite = new Sprite();
			return container;
		}

		public function setContent(content:Sprite) {
			contentBox.addChild(content);
		}

		public function destroy(e:Event) {
			while (_overlay.numChildren) {
				_overlay.removeChildAt(0);
			}
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
			contentBox = new Sprite();
			contentBox.x = _stagewidth * 0.5 - _owidth * 0.5;
			contentBox.y = _stageheight * 0.5 - _oheight * 0.5;
			contentBox.graphics.beginFill(_background);
			contentBox.graphics.drawRect(0, 0, _owidth, _oheight);
			contentBox.graphics.endFill();

			_overlay.addChild(contentBox);
		}

		/*
		* Overide some setters and getters
		*/
		public override function set width(w:Number):void {
			_owidth = w;
		}

		public override function get width():Number {
			return _owidth;
		}

		public override function set height(h:Number):void {
			_oheight = h;
		}

		public override function get height():Number {
			return _oheight;
		}
	}
}