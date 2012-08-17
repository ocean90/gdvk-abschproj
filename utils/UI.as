package utils {
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	
	import views.IndexPage;
	import widgets.BigButton;
		
	public class UI extends MovieClip {

		var back:BigButton;

		var indexPage:DisplayObject;

		public function UI() {
			back = new BigButton(Grid.COLUMN_1, 0, 'lightgray');
			addChild(back);
			
			addChild(getIndexPage());
		}
		
		public function getIndexPage():DisplayObject {
			if (indexPage == null) {
				indexPage = new IndexPage();
			}
			return indexPage;
		}
	}
	
}
