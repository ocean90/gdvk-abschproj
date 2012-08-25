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
			
			TweenLite.to(prevView, 0.8, { x: 1280, autoAlpha: 0.5, onComplete: function() {
				TweenLite.to(prevView, 0.8, { autoAlpha: 0 });
			}});
			TweenLite.to(homeView, 0.8, { x: 0, autoAlpha: 1 });
			
			Main.FOOTER.updateButtonBar();
		}
		
		public function onBack(e:Event) {
			popView();
		}
		
		public function pushView(nextView:View) {
			Main.KEYBOARD.activateFor(null);
			if (viewStack.length == 0) {
				// first view from bottom -- demo/test case only...
				
				nextView.update();
				nextView.alpha = 0;
				nextView.visible = true;
				
				viewStack.push(nextView);
				addChild(nextView);
				
				TweenLite.to(nextView, 2.0, { delay: 0.5, autoAlpha: 1 });
				
			} else {
				// all other views
				
				var prevView:View = viewStack[viewStack.length - 1];
				
				nextView.update();
				nextView.x = 1280;
				nextView.alpha = 0.5;
				nextView.visible = true;
				
				viewStack.push(nextView);
				addChild(nextView);
				
				TweenLite.to(prevView, 0.8, { x: -1280, autoAlpha: 0.5, onComplete: function() {
					TweenLite.to(prevView, 0.8, { autoAlpha: 0 });
				}});
				TweenLite.to(nextView, 0.8, { x: 0, autoAlpha: 1.0 });
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
			
			TweenLite.to(lastPage, 0.8, { x: 1280, autoAlpha: 0.5, onComplete: function() {
				TweenLite.to(lastPage, 0.8, { autoAlpha: 0 });
			}});
			TweenLite.to(prevPage, 0.8, { x: 0, autoAlpha: 1 });
			
			Main.FOOTER.updateButtonBar();
		}
		
		public function updateView() {
			var view:View = viewStack[viewStack.length - 1];
			view.alpha = 0;
			view.update();
			TweenLite.to(view, 2.0, { autoAlpha: 1 });
		}
	}
	
}
