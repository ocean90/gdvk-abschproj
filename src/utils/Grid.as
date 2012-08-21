package utils {
	public class Grid {
		private static var columns:int = 6;
		private static var columnWidth:int = 180;
		private static var columnSpanLeft:int = 25;
		private static var columnSpanRight:int = 25;
		private static var columnPadding:int = 30;

		public static var COLUMN_1:int = columnSpanLeft;
		public static var COLUMN_2:int = columnSpanLeft + 1 * columnWidth + 1 * columnPadding;
		public static var COLUMN_3:int = columnSpanLeft + 2 * columnWidth + 2 * columnPadding;
		public static var COLUMN_4:int = columnSpanLeft + 3 * columnWidth + 3 * columnPadding;
		public static var COLUMN_5:int = columnSpanLeft + 4 * columnWidth + 4 * columnPadding;
		public static var COLUMN_6:int = columnSpanLeft + 5 * columnWidth + 5 * columnPadding;
		
		public static var SPAN_1:int = columnWidth;
		public static var SPAN_2:int = columnWidth * 2 + columnPadding * 1;
		public static var SPAN_3:int = columnWidth * 3 + columnPadding * 2;
		public static var SPAN_4:int = columnWidth * 4 + columnPadding * 3;
		public static var SPAN_5:int = columnWidth * 5 + columnPadding * 4;
		public static var SPAN_6:int = columnWidth * 6 + columnPadding * 5;

		public static var BUTTON_BAR_Y:int = 939;
		public static var BUTTON_BAR_X:int = COLUMN_1;
		public static var BUTTON_BAR_WIDTH:int = 1280 - columnSpanLeft - columnSpanRight;
		public static var BUTTON_BAR_HEIGHT:int = 60;
		
		public function Grid() {
		}
	}
}
