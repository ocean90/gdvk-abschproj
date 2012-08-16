package utils {
	
	import be.viplib.util.ColorUtil;

	public class Colors {
		private static var _colors:Object = {
				'blue':    0x2D8EAC,
				'red':     0xDB2D1F,
				'brown':   0x33190D,
				'purple':  0xD10053,
				'green':   0x69A733,
				'yellow':  0xF3A831
		};
			
		public static function getColor(color:String) {
			return _colors[color];
		}
			
		public static function getDarkColor(color:String) {
			return ColorUtil.darkenColor(_colors[color], 20);
		}
	}
}
