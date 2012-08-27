package widgets {
	import flash.display.Sprite;

	import widgets.Cover;
	import utils.Grid;
	import flash.geom.*;
	import com.greensock.TweenLite;

	public class CoverFlow extends Sprite {
		private var _width:int;
		private var _height:int;

		private	var _covers:Vector.<Cover>;

		private var _coversContainer:Sprite;

		private var _selectedIndex:int;


		public function CoverFlow(w:int, h:int) {
			trace("CoverFlow");
			_width = w;
			_height = h;
			_covers = new Vector.<Cover>();
			_selectedIndex = 0;

			_coversContainer = new Sprite();
			addChild(_coversContainer);

		}

		public function push(cover:Cover) {
			cover.cacheAsBitmap = true;
			// center the perspective center!
			cover.transform.perspectiveProjection = new PerspectiveProjection()
			cover.transform.perspectiveProjection.projectionCenter = new Point(_width / 2, 250 + cover.height / 2);
			_covers.push(cover);
			_coversContainer.addChild(cover);
		}

		public function next() {
			_selectedIndex++;
			if (_selectedIndex >  _covers.length - 1) {
				_selectedIndex = _covers.length - 1;
			}
			layout();
		}

		public function prev() {
			_selectedIndex--;
			if (_selectedIndex < 0) {
				_selectedIndex = 0;
			}
			layout();
		}
		
		public function layout() {
			var len:uint = _covers.length;
			var cover:Cover;
			var distanceFromCenter:int;
			for (var i:int = 0; i < len; i++) {
				cover = _covers[i];
				
				if (i == _selectedIndex) {
					_coversContainer.setChildIndex(cover, _coversContainer.numChildren-1);
					TweenLite.to(
						cover,
						0.5,
						{
							x: _width / 2 - cover.width / 2,
							y: 250,
							z: 0,
							rotationY: 0
						}
					);
				} else if (i < _selectedIndex) {
					distanceFromCenter = _selectedIndex - i;
					TweenLite.to(
						cover,
						0.5,
						{
							x: _width / 2 - cover.width / 2 - distanceFromCenter * 30,
							y: 250,
							z: 0,
							rotationY: -45
						}
					);
					_coversContainer.setChildIndex(cover, _coversContainer.numChildren - (distanceFromCenter + 1));
				} else if (i > _selectedIndex) {
					//trace(Math.sin(45 * Math.PI/180), cover.width * Math.sin(45 * Math.PI/180));
					//trace(Math.cos(45 * Math.PI/180), cover.width * Math.cos(45 * Math.PI/180));
					//trace(Math.tan(45 * Math.PI/180), cover.width * Math.tan(45 * Math.PI/180));
					distanceFromCenter = i - _selectedIndex;
					TweenLite.to(
						cover,
						0.5,
						{
							x: cover.width * 0.53 + distanceFromCenter * 30,
							y: 250,
							z: cover.width * 0.70,
							rotationY: 45
						}
					);
					_coversContainer.setChildIndex(cover, _coversContainer.numChildren - (distanceFromCenter + 1));
				}
			}
		}

	}
}