package utils {
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	
	import widgets.BigButton;
	
	import views.IndexPage;
	import views.TestPage;
	import flash.events.MouseEvent;
	import flash.events.Event;
		
	public class UI extends MovieClip {

		var viewStack:Vector.<DisplayObject> = new Vector.<DisplayObject>();

		var back:BigButton;

		var indexPage:DisplayObject;
		var testPage:DisplayObject;

		public function UI() {
			back = new BigButton(Grid.COLUMN_1, 0, 'lightgray');
			back.setText('Back');
			back.addEventListener(MouseEvent.CLICK, openTestPage);
			addChild(back);
			
			var firstPage:DisplayObject = getIndexPage();
			
			viewStack.push(firstPage);
			addChild(firstPage);
		}
		
		public function openTestPage(e:Event) {
			var lastPage:DisplayObject = viewStack.pop();
			removeChild(lastPage);
			
			var newPage:DisplayObject;
			if (lastPage != getIndexPage()) {
				newPage = getIndexPage();
			} else {
				newPage = getTestPage();
			}
			
			viewStack.push(newPage);
			addChild(newPage);
		}
		
		public function getIndexPage():DisplayObject {
			if (indexPage == null) {
				indexPage = new IndexPage();
			}
			return indexPage;
		}
		
		public function getTestPage():DisplayObject {
			if (testPage == null) {
				testPage = new TestPage();
			}
			return testPage;
		}
	}
	
}
