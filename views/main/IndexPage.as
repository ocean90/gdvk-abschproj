package views.main {
	
	import widgets.BigButton;
	import utils.Grid;
	import views.View;
	import flash.events.MouseEvent;
	import views.Views;
	import flash.events.Event;
	
	public class IndexPage extends View {

		public function IndexPage() {
			addChild(new BigButton(Grid.COLUMN_3, 231, 'red'));
			addChild(new BigButton(Grid.COLUMN_5, 231, 'blue'));
			addChild(new BigButton(Grid.COLUMN_3, 441, 'yellow'));
			addChild(new BigButton(Grid.COLUMN_5, 441, 'green'));
			addChild(new BigButton(Grid.COLUMN_1, 651, 'purple'));
			addChild(new BigButton(Grid.COLUMN_3, 651, 'brown'));
			addChild(new BigButton(Grid.COLUMN_5, 651));
			
			var button1:BigButton = (BigButton) (getChildAt(0));
			button1.setText('Event 1');
			button1.addEventListener(MouseEvent.CLICK, openEvent1);
			
			var button2:BigButton = (BigButton) (getChildAt(1));
			button2.setText('Event 2');
			button2.addEventListener(MouseEvent.CLICK, openEvent2);
		}

		public function openEvent1(e:Event) {
			Main.UI.pushView(Views.Event1);
		}
		
		public function openEvent2(e:Event) {
			Main.UI.pushView(Views.Event2);
		}
	}
	
}
