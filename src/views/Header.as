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
		
		public function Header() {
			bigHeader = new InverseText();
			bigHeader.x = -leftOverlapping;
			bigHeader.y = 38;
			bigHeader.textFormat.size = 50;
			bigHeader.textField.x = 25 + leftOverlapping;
			bigHeader.shapeWidth = 200;
			bigHeader.shapeHeight = 100;
			bigHeader.setText('BigHeader');
			bigHeader.visible = false;
			addChild(bigHeader);
			
			smallHeader1 = new InverseText();
			smallHeader1.x = -leftOverlapping;
			smallHeader1.y = 38;
			smallHeader1.textField.x = 25 + leftOverlapping;
			smallHeader1.shapeWidth = 200;
			smallHeader1.shapeHeight = 50;
			smallHeader1.setText('SmallHeader1');
			smallHeader1.visible = false;
			addChild(smallHeader1);
			
			smallHeader2 = new InverseText();
			smallHeader2.x = -leftOverlapping + Grid.COLUMN_1 * 2;
			smallHeader2.y = 88;
			smallHeader2.textField.x = 25 + leftOverlapping;
			smallHeader2.shapeWidth = 200;
			smallHeader2.shapeHeight = 50;
			smallHeader2.setText('SmallHeader2');
			smallHeader2.visible = false;
			addChild(smallHeader2);
			
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
				
				// einblenden
				// das ist absichtlich ungenau an dieser Stelle!
				bigHeader.shapeWidth = bigHeader.textField.textWidth + 50 + leftOverlapping;
				bigHeader.update();
				
				bigHeader.x = -bigHeader.shapeWidth;
				bigHeader.visible = true;
				TweenLite.to(bigHeader, 0.8, { x: -leftOverlapping, ease:Back.easeOut });
			}});
		}
	}
	
}
