package utils {

	import be.viplib.util.ColorUtil;

	public class Colors {
		private static var _colors:Object = {
				'languageButtonActive':   0xdddddd,
				'languageButtonInactive': 0xbbbbbb,
			    'lightgray': 0xdddddd,
				'lightred':       ColorUtil.brightenColor(0xDB2D1F, 40), // inner color same as red, for now
				'lightgreen':     ColorUtil.brightenColor(0x69A733, 40), // inner color same as green, for now
				'blue':      0x2D8EAC,
				'red':       0xDB2D1F,
				'brown':     0x33190D,
				'purple':    0xD10053,
				'green':     0x69A733,
				'yellow':    0xF3A831
		};

		public static function getColor(color:*) {
			if ( 'string' == typeof color )
				return _colors[color];
			else
				return color;
		}

		public static function getDarkColor(color:*) {
			if ( 'string' == typeof color )
				return ColorUtil.darkenColor(_colors[color], 20);
			else
				return ColorUtil.darkenColor(color, 20);
		}

		public static function getLightColor(color:*) {
			if ( 'string' == typeof color )
				return ColorUtil.brightenColor(_colors[color], 20);
			else
				return ColorUtil.brightenColor(color, 20);
		}

	}
}
