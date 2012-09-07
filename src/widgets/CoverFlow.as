package widgets {
	import com.greensock.TweenLite;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.PerspectiveProjection;
	import flash.geom.Point;
	import flash.display.CapsStyle;

	import be.viplib.util.ColorUtil;

	import utils.Grid;
	import utils.Colors;

	import widgets.Cover;

	public class CoverFlow extends Sprite {
		private var _width:int;
		private var _height:int;
		private var _autoColor:int;

		private	var _covers:Vector.<Cover>;

		private var _coversContainer:Sprite;

		private var _selectedIndex:int;

		public var nextButton:Sprite;
		public var prevButton:Sprite;


		public function CoverFlow(w:int, h:int, autoColor:int = -1) {
			_width = w;
			_height = h;
			_autoColor = autoColor;
			_covers = new Vector.<Cover>();
			_selectedIndex = 0;


			_coversContainer = new Sprite();
			addChild(_coversContainer);

			nextButton = new Sprite();
			prevButton = new Sprite();
			_coversContainer.addChild(nextButton);
			_coversContainer.addChild(prevButton);
			createButtons();

		}

		public function createButtons() {
			var transparent:BitmapData = new BitmapData(100,600,true,0xffffff);

			// Linker Button
			prevButton.graphics.beginBitmapFill(transparent);
			prevButton.graphics.drawRect(0,0,100,600);
			prevButton.graphics.endFill();
			prevButton.buttonMode = true;
			prevButton.x = 15;
			prevButton.y = 250;
			var prevButtonTriangle:Shape = new Shape();
			prevButtonTriangle.graphics.lineStyle(20, Colors.getDarkColor('lightgray'), 1.0, false, "normal", CapsStyle.SQUARE);
			prevButtonTriangle.graphics.moveTo(15, prevButton.height/2 + 6);
			prevButtonTriangle.graphics.lineTo(prevButton.width - 5, prevButton.height/2 - 80 + 6);
			prevButtonTriangle.graphics.moveTo(15, prevButton.height/2 + 6);
			prevButtonTriangle.graphics.lineTo(prevButton.width - 5, prevButton.height/2 + 80 + 6);
			prevButtonTriangle.graphics.lineStyle(20, Colors.getColor('lightgray'), 1.0, false, "normal", CapsStyle.SQUARE);
			prevButtonTriangle.graphics.moveTo(15, prevButton.height/2);
			prevButtonTriangle.graphics.lineTo(prevButton.width - 5, prevButton.height/2 - 80);
			prevButtonTriangle.graphics.moveTo(15, prevButton.height/2);
			prevButtonTriangle.graphics.lineTo(prevButton.width - 5, prevButton.height/2 + 80);
			prevButton.addChild(prevButtonTriangle)
			prevButton.addEventListener(MouseEvent.CLICK, prev);


			// Rechter Button
			nextButton.graphics.beginBitmapFill(transparent);
			nextButton.graphics.drawRect(0,0,100,600);
			nextButton.graphics.endFill();
			nextButton.buttonMode = true;
			nextButton.x = 1280-100-15;
			nextButton.y = 250;
			var nextButtonTriangle:Shape = new Shape();
			nextButtonTriangle.graphics.lineStyle(20, Colors.getDarkColor('lightgray'), 1.0, false, "normal", CapsStyle.SQUARE);
			nextButtonTriangle.graphics.moveTo(5, nextButton.height/2 - 80 + 6);
			nextButtonTriangle.graphics.lineTo(nextButton.width - 15, nextButton.height/2 + 6);
			nextButtonTriangle.graphics.moveTo(5, nextButton.height/2 + 80 + 6);
			nextButtonTriangle.graphics.lineTo(nextButton.width - 15, nextButton.height/2 + 6);
			nextButtonTriangle.graphics.lineStyle(20, Colors.getColor('lightgray'), 1.0, false, "normal", CapsStyle.SQUARE);
			nextButtonTriangle.graphics.moveTo(5, nextButton.height/2 - 80);
			nextButtonTriangle.graphics.lineTo(nextButton.width - 15, nextButton.height/2);
			nextButtonTriangle.graphics.moveTo(5, nextButton.height/2 + 80);
			nextButtonTriangle.graphics.lineTo(nextButton.width - 15, nextButton.height/2);
			nextButton.addChild(nextButtonTriangle);
			nextButton.addEventListener(MouseEvent.CLICK, next);
		}

		public function push(cover:Cover) {
			// center the perspective center!
			cover.transform.perspectiveProjection = new PerspectiveProjection()
			cover.transform.perspectiveProjection.projectionCenter = new Point(_width / 2, 250 + cover.height / 2);
			_covers.push(cover);
			_coversContainer.addChild(cover);
		}

		public function next(e:Event) {
			_selectedIndex++;
			if (_selectedIndex > _covers.length - 1) {
				_selectedIndex = _covers.length - 1;
				return false;
			}
			layout();
		}

		public function prev(e:Event) {
			_selectedIndex--;
			if (_selectedIndex < 0) {
				_selectedIndex = 0;
				return false;
			}
			layout();
		}

		public function updateNavigation() {
			_coversContainer.setChildIndex(nextButton, _coversContainer.numChildren -1);
			_coversContainer.setChildIndex(prevButton, _coversContainer.numChildren -1);

			prevButton.visible = nextButton.visible = true;
			if (_selectedIndex == 0) {
				prevButton.visible = false;
			}

			if (_selectedIndex == _covers.length - 1) {
				nextButton.visible = false;
			}
		}

		public function layout() {
			var len:uint = _covers.length;
			var cover:Cover;
			var distanceFromCenter:int;
			for (var i:int = 0; i < len; i++) {
				cover = _covers[i];

				if (i == _selectedIndex) {
					_coversContainer.setChildIndex(cover, _coversContainer.numChildren-1);
					if (_autoColor != -1) {
						cover.setColor(_autoColor);
					}
					TweenLite.to(
						cover,
						0.5,
						{
							x: _width / 2 - cover.width / 2,
							y: 250,
							z: 0,
							rotationY: 0,
							onComplete: _fixBlurry,
							onCompleteParams: [cover]
						}
					);
				} else if (i < _selectedIndex) {
					distanceFromCenter = _selectedIndex - i;
					if (_autoColor != -1) {
						cover.setColor(ColorUtil.darkenColor(_autoColor, Math.min(distanceFromCenter, 3) * 10));
					}
					to(cover, _width / 2 - cover.width / 2 - distanceFromCenter * 50, 250, 0, -45);
					_coversContainer.setChildIndex(cover, _coversContainer.numChildren - (distanceFromCenter + 1));
				} else if (i > _selectedIndex) {
					//trace(Math.sin(45 * Math.PI/180), cover.width * Math.sin(45 * Math.PI/180));
					//trace(Math.cos(45 * Math.PI/180), cover.width * Math.cos(45 * Math.PI/180));
					//trace(Math.tan(45 * Math.PI/180), cover.width * Math.tan(45 * Math.PI/180));
					distanceFromCenter = i - _selectedIndex;
					if (_autoColor != -1) {
						cover.setColor(ColorUtil.darkenColor(_autoColor, Math.min(distanceFromCenter, 4) * 10));
					}
					to(cover, cover.width * 0.53 + distanceFromCenter * 50, 250, cover.width * 0.70, 45);
					_coversContainer.setChildIndex(cover, _coversContainer.numChildren - (distanceFromCenter + 1));
				}
			}
			updateNavigation();
		}

		private function to(cover:Cover, x:int, y:int, z:int, rotationY:int) {
			// animation wenn wenige covers (z.b. workshops) oder sich y, zo der rotationX ändert
			if (_covers.length <= 5 || cover.y != y || cover.z != z || cover.rotationY != rotationY) {
				TweenLite.to(cover, 0.5, { x: x, y: y, z: z, rotationY: rotationY });
			} else {
				// in den anderen fällen (z.b. teilnehmer liste) wird das cover
				// aus performancegründen nur auf der x achse verschoben
				cover.x = x;
			}
		}

		// Workaround fo blurry texts if z-axes is set.
		// http://forums.greensock.com/topic/2239-blurry-movieclip-with-3d-axis/
		private function _fixBlurry(cover:Cover) {
			var currentX = cover.x;
			var currentY = cover.y;
			cover.transform.matrix3D = null;
			cover.x = currentX;
			cover.y = currentY;
		}
	}
}