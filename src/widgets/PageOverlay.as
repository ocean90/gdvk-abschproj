package widgets {
	import com.greensock.TweenLite;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;

	import utils.Colors;
	import utils.Grid;
	import views.View;

	public class PageOverlay extends View {
		private var _owidth:Number;
		private var _oheight:Number;
		private var _background:uint;
		private var _stagewidth:Number;
		private var _stageheight:Number;

		private var _overlay:Sprite;
		private var contentBox:Sprite;
		public var content:Sprite

		public function PageOverlay(background:* = 0xffffff, w:Number = 870,h:Number = 700) {
			_owidth = w;
			_oheight = h;
			_background = Colors.getColor(background);;
			_stagewidth = Main.STAGE.stageWidth;
			_stageheight = Main.STAGE.stageHeight

			_overlay = new Sprite();
			_overlay.visible = false;
			_overlay.alpha = 0;
			// Wird dem Content angehangen damit es zwar Header und Footer überlagert, aber nicht das Keyboard.
			Main.CONTENT.addChild(_overlay);

			darkenPage();
			paintContentBox();
			content = new Sprite();
			content.x = Grid.COLUMN_PADDING;
			content.y = Grid.COLUMN_PADDING;
			contentBox.addChild(content);

			// Don't overflow.
			contentBox.scrollRect = new Rectangle(0, 0, _owidth, _owidth);

			_overlay.visible = true;
			TweenLite.to(_overlay, 0.5, { alpha: 1});
		}

		public function destroy(e:Event) {
			Main.KEYBOARD.activateFor(null);
			Main.HEADER.reset();
			Main.FOOTER.resetButtonBar();
			
			var self:PageOverlay = this;
			TweenLite.to(_overlay, 0.3, { alpha: 0, onComplete: function() {
				_overlay.visible = false;
				while (_overlay.numChildren) {
					_overlay.removeChildAt(0);
				}
				self.parent.removeChild(self);
			}});
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