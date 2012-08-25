package views {
	import widgets.InverseText;
	import utils.Grid;
	
	public class Header extends View {

		private var inverseText1:InverseText;
		private var inverseText2:InverseText;
		
		public function Header() {
			inverseText1 = new InverseText();
			inverseText1.x = 0;
			inverseText1.y = 38;
			inverseText1.textField.x = 25;
			inverseText1.shapeWidth = 240;
			inverseText1.shapeHeight = 50;
			inverseText1.setText('Es wird laut!');
			addChild(inverseText1);
			
			inverseText2 = new InverseText();
			inverseText2.x = Grid.COLUMN_1 * 2;
			inverseText2.y = 88;
			inverseText2.textField.x = 25;
			inverseText2.shapeWidth = 300;
			inverseText2.shapeHeight = 50;
			inverseText2.setText('WELTREKORD');
			addChild(inverseText2);
			
		}

		public function setText1(text:String) {
			inverseText1.setText(text);
		}
	}
	
}
