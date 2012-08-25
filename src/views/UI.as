package views {
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.events.Event;
		
	import com.greensock.TweenLite;
		
	public class UI extends MovieClip {

		var viewStack:Vector.<View> = new Vector.<View>();
		
		public function UI() {
		}
		
		public function onHome(e:Event) {
			Main.KEYBOARD.activateFor(null);
			if (viewStack.length == 1) {
				return;
			}
			
			// get current view and remove all others
			var prevView:View = viewStack.pop();
			while (viewStack.length > 1) {
				viewStack.pop();
			}
			var homeView:View = viewStack[viewStack.length - 1];
			
			homeView.x = -1280;
			homeView.visible = true;
			
			TweenLite.to(prevView, 0.8, { x: 1280 });
			TweenLite.to(homeView, 0.8, { x: 0 });
			
			Main.FOOTER.updateButtonBar();
		}
		
		public function onBack(e:Event) {
			popView();
		}
		
		public function pushView(view:View) {
			Main.KEYBOARD.activateFor(null);
			if (viewStack.length == 0) {
				// first view from bottom -- demo/test case only...
				
				view.update();
				viewStack.push(view);
				view.alpha = 0;
				view.visible = true;
				addChild(view);
				
				TweenLite.to(view, 2.0, { delay: 0.5, alpha: 1 });
				
			} else {
				// all other views
				
				var prevPage:View = viewStack[viewStack.length - 1];
				
				view.update();
				viewStack.push(view);
				view.x = 1280;
				view.visible = true;
				addChild(view);
				
				TweenLite.to(prevPage, 0.8, { x: -1280, visible: false });
				TweenLite.to(view, 0.8, { x: 0 });
			}
			
			Main.FOOTER.updateButtonBar();
		}
		
		public function popView() {
			Main.KEYBOARD.activateFor(null);
			if (viewStack.length == 1) {
				return;
			}
			
			// remove last and push previous to the front
			var lastPage:View = viewStack.pop();
			var prevPage:View = viewStack[viewStack.length - 1];
			
			prevPage.x = -1280;
			prevPage.update();
			prevPage.visible = true;
			
			TweenLite.to(lastPage, 0.8, { x: 1280 });
			TweenLite.to(prevPage, 0.8, { x: 0 });
			
			Main.FOOTER.updateButtonBar();
		}
		
		public function updateView() {
			var view:View = viewStack[viewStack.length - 1];
			view.alpha = 0;
			view.update();
			TweenLite.to(view, 2.0, { alpha: 1 });
		}
	}
	
}
