package utils {

	import be.viplib.util.ColorUtil;

	public class Colors {
		private static var _colors:Object = {
				// Logo colors
				'black':     0x000000,
				'blue':      0x4668ab,
				'cyan':      0x36a1bc,
				'red':       0xe64428,
				'purple':    0xab438f,
				'green':     0x2c9a2d,
				'moos':      0x9bc126,
				'orange':    0xf8b739,

				// MI Styleguid
				'lightblue': 0x77aabb,
				'brown':     0x442211,
				'pink' :     0xdd1166,
				'neongreen': 0x77cc00,

				'languageButtonActive':   0xdddddd,
				'languageButtonInactive': 0xbbbbbb,

				'white':     0xffffff,
				'lightgray': 0xdddddd
		};

		public static function getColor(color:*):uint {
			if ( 'string' == typeof color )
				return _colors[color];
			else
				return color;
		}

		public static function getDarkColor(color:*):uint {
			if ( 'string' == typeof color )
				return ColorUtil.darkenColor(_colors[color], 20);
			else
				return ColorUtil.darkenColor(color, 20);
		}

		public static function getLightColor(color:*):uint {
			if ( 'string' == typeof color )
				return ColorUtil.brightenColor(_colors[color], 20);
			else
				return ColorUtil.brightenColor(color, 20);
		}

	}
}
