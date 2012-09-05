package views {
	import widgets.InverseText;
	import utils.Grid;
	import com.greensock.TweenLite;
	import com.greensock.easing.Back;
	
	public class Header extends View {

		private var leftOverlapping:int = 200;

		private var bigHeader:InverseText;
		private var smallHeader1:InverseText;
		private var smallHeader2:InverseText;
		
		private var otherHeadlines:Array = new Array();
		
		public function Header() {
			bigHeader = new InverseText();
			bigHeader.x = -leftOverlapping;
			bigHeader.y = 38;
			bigHeader.textFormat.size = 50;
			bigHeader.textField.x = Grid.COLUMN_1 + leftOverlapping;
			bigHeader.shapeWidth = 200;
			bigHeader.shapeHeight = 100;
			bigHeader.setText('BigHeader');
			bigHeader.visible = false;
			addChild(bigHeader);
			
			smallHeader1 = new InverseText();
			smallHeader1.x = -leftOverlapping;
			smallHeader1.y = 38;
			smallHeader1.textField.x = Grid.COLUMN_1 + leftOverlapping;
			smallHeader1.shapeWidth = 200;
			smallHeader1.shapeHeight = 50;
			smallHeader1.setText('SmallHeader1');
			smallHeader1.visible = false;
			addChild(smallHeader1);
			
			smallHeader2 = new InverseText();
			smallHeader2.x = -leftOverlapping + Grid.COLUMN_1 * 2;
			smallHeader2.y = 88;
			smallHeader2.textField.x = Grid.COLUMN_1 + leftOverlapping;
			smallHeader2.shapeWidth = 200;
			smallHeader2.shapeHeight = 50;
			smallHeader2.setText('SmallHeader2');
			smallHeader2.visible = false;
			addChild(smallHeader2);
		}

		public function reset() {
			while (otherHeadlines.length > 0) {
				var headline:InverseText = otherHeadlines.pop();
				
				TweenLite.to(headline, 0.4, { x: -leftOverlapping - headline.shapeWidth, onComplete: function() {
					removeChild(headline);
				}});
			}
		}

		public function setText(text:String) {
			if (text == bigHeader.textField.text) {
				return;
			}
			
			// ausblenden
			TweenLite.to(bigHeader, 0.4, { x: -leftOverlapping - bigHeader.shapeWidth, onComplete: function() {
				// updaten
				bigHeader.setText(text);
				if (text == null) {
					return;
				}
				
				bigHeader.shapeWidth = bigHeader.textField.textWidth + 50 + leftOverlapping;
				bigHeader.update();
				
				// einblenden
				bigHeader.x = -bigHeader.shapeWidth;
				bigHeader.visible = true;
				TweenLite.to(bigHeader, 0.8, { x: -leftOverlapping, ease:Back.easeOut });
			}});
		}
		
		public function addHeadline(text:String, posY:int, delay:Number = -1) {
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
