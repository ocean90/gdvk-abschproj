package utils {
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	
	import views.IndexPage;
		
	public class UI extends MovieClip {

		var indexPage:DisplayObject;

		public function UI() {
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
