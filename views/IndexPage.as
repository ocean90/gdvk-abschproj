package views {
	import flash.display.Sprite;
	
	import widgets.BigButton;
	import utils.Grid;
	
	public class IndexPage extends Sprite {

		public function IndexPage() {
			addChild(new BigButton(Grid.COLUMN_3, 231, 'red'));
			addChild(new BigButton(Grid.COLUMN_5, 231, 'blue'));
			addChild(new BigButton(Grid.COLUMN_3, 441, 'yellow'));
			addChild(new BigButton(Grid.COLUMN_5, 441, 'green'));
			addChild(new BigButton(Grid.COLUMN_1, 651, 'purple'));
			addChild(new BigButton(Grid.COLUMN_3, 651, 'brown'));
			addChild(new BigButton(Grid.COLUMN_5, 651));
		}

	}
	
}
