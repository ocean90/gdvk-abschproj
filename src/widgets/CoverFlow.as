package widgets {
	import flash.display.Sprite;

	import widgets.Cover;
	import utils.Grid;
	import flash.geom.*;

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
			_covers.push(cover);
			_coversContainer.addChild(cover);
		}

		public function next() {
			_selectedIndex++;

			if ( _selectedIndex >  _covers.length - 1)
				_selectedIndex = _covers.length - 1
		}

		public function prev() {
			_selectedIndex--;
			if ( _selectedIndex < 0 )
				_selectedIndex = 0
		}

		public function layout() {
			var len:uint = _covers.length;
			var cover:Cover;
			var distanceFromCenter:int;
			for (var i:int = 0; i < len; i++) {
				cover = _covers[i];
				if (i == _selectedIndex) {
					cover.rotationY = 0;
					cover.x = Grid.COLUMN_2 - 30;
					cover.z = 0;
					cover.alpha = 0.5 // Debug
					_coversContainer.setChildIndex(cover, _coversContainer.numChildren-1);
				} else if (i < _selectedIndex) {
					distanceFromCenter = _selectedIndex - i;
					cover.rotationY = -45;
					cover.x = (Grid.COLUMN_2 - 30 - 60) - (distanceFromCenter * 30);
					cover.z = 150;
					cover.alpha = 1; // Debug
					_coversContainer.setChildIndex(cover, _coversContainer.numChildren - (distanceFromCenter + 1));
				} else if (i > _selectedIndex) {
					distanceFromCenter = i - _selectedIndex;
					cover.rotationY = 45;
					cover.x = (Grid.COLUMN_2 - 30 + 60) + (distanceFromCenter * 30);
					cover.z = 150;
					cover.alpha = 1; // Debug
					_coversContainer.setChildIndex(cover, _coversContainer.numChildren - (distanceFromCenter + 1));
				}
				cover.y = 250;
			}
		}

	}
}