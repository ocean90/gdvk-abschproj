﻿package views {
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
			if (viewStack.length == 0) {
				// first view from bottom -- demo/test case only...
				
				viewStack.push(view);
				view.x = 0;
				view.y = 1024;
				view.visible = true;
				addChild(view);
				
				TweenLite.to(view, 0.8, { delay: 1, x: 0, y: 0 });
				
			} else {
				// all other views
				
				var prevPage:View = viewStack[viewStack.length - 1];
				
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
			if (viewStack.length == 1) {
				return;
			}
			
			// remove last and push previous to the front
			var lastPage:View = viewStack.pop();
			var prevPage:View = viewStack[viewStack.length - 1];
			
			prevPage.x = -1280;
			prevPage.visible = true;
			
			TweenLite.to(lastPage, 0.8, { x: 1280 });
			TweenLite.to(prevPage, 0.8, { x: 0 });
			
			Main.FOOTER.updateButtonBar();
		}
	}
	
}