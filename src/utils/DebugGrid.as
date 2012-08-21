package utils {
	import flash.display.Sprite;
	import flash.display.MovieClip;
	
	public class DebugGrid extends Sprite {
		private static var columns:int = 6;
		private static var columnWidth:int = 180;
		private static var columnSpanLeft:int = 25;
		private static var columnSpanRight:int = 25;
		private static var columnPadding:int = 30;

		public function DebugGrid() {
			trace('Create debug grid!');
			trace('  complete width = ',
				  columnSpanLeft +
				  columns * columnWidth +
				  (columns - 1) * columnPadding +
				  columnSpanRight);
			
			this.x = 0;
			this.y = 0;
			
        	addChild(this.createColumns());
		}

		public function createColumns():Sprite {
			var columns:Sprite = new Sprite();
			for (var i:int = 0; i < 6; i++) {
				var left:int = columnSpanLeft;
				left += i * columnWidth;
				left += i * columnPadding;
				
				columns.graphics.beginFill(0xff0000, 0.1);
				columns.graphics.drawRect(left, 0, columnWidth, 1024);
				columns.graphics.endFill();
			}
			return columns;
		}
	}
	
}
