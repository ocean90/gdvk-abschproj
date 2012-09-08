package views {
	import widgets.InverseText;
	import utils.Grid;
	import com.greensock.TweenLite;
	import com.greensock.easing.Back;

	/**
	 * Verwaltungsklasse für den Header. Sorgt für die nötigen Bounceanimationen.
	 * Verwendung über setText (für die eine Zentrale große) und addHeadline für kleinere
	 * im Content-Bereich.
	 */
	public class Header extends View {

		private var leftOverlapping:int = 200;

		private var headline:InverseText;

		private var otherHeadlines:Array = new Array();

		public function Header() {
			headline = new InverseText();
			headline.x = -leftOverlapping;
			headline.y = 38;
			headline.textFormat.size = 50;
			headline.textField.x = Grid.COLUMN_1 + leftOverlapping;
			headline.shapeWidth = 200;
			headline.shapeHeight = 100;
			headline.setText('');
			headline.visible = false;
			addChild(headline);
		}

		public function reset():void {
			while (otherHeadlines.length > 0) {
				var headline:InverseText = otherHeadlines.pop();

				TweenLite.to(headline, 0.4, { x: -leftOverlapping - headline.shapeWidth, onComplete: function() {
					if (headline.parent != null) {
						headline.parent.removeChild(headline);
					}
				}});
			}
		}

		public function setText(text:String):void {
			if (text == headline.textField.text) {
				return;
			}

			// ausblenden
			TweenLite.to(headline, 0.4, { x: -leftOverlapping - headline.shapeWidth, onComplete: function() {
				// updaten
				headline.setText(text);
				if (text == null) {
					return;
				}

				headline.shapeWidth = headline.textField.textWidth + 50 + leftOverlapping;
				headline.update();

				// einblenden
				headline.x = -headline.shapeWidth;
				headline.visible = true;
				TweenLite.to(headline, 0.8, { x: -leftOverlapping, ease:Back.easeOut });
			}});
		}

		public function addHeadline(text:String, posY:int, delay:Number = -1):void {
			var headline:InverseText = new InverseText();
			headline.x = -leftOverlapping;
			headline.y = posY;
			headline.textFormat.size = 30;
			headline.textField.x = Grid.COLUMN_1 + leftOverlapping;
			headline.setText(text);

			headline.shapeWidth = headline.textField.textWidth + 50 + leftOverlapping;
			headline.shapeHeight = 50;
			headline.update();

			otherHeadlines.push(headline);
			addChild(headline);

			// einblenden
			if (delay != -1) {
				headline.x = -headline.shapeWidth;
				TweenLite.to(headline, 0.8, { x: -leftOverlapping, delay: delay, ease:Back.easeOut });
			}
		}
	}
}
