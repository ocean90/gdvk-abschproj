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

			Main.HEADER.reset();
			Main.FOOTER.resetButtonBar();
			homeView.update();
			homeView.x = -1280;
			homeView.visible = true;

			TweenLite.to(prevView, 0.8, { x: 1280, onComplete: function() {
				prevView.visible = false;
			}});
			TweenLite.to(homeView, 0.8, { x: 0 });
		}

		public function onBack(e:Event) {
			popView();
		}

		/**
		 * Prüft aktuell NICHT ob dies wirklich die erste View ist!
		 */
		public function pushHome(home:View) {
			viewStack.push(home);
			Main.HEADER.reset();
			Main.FOOTER.resetButtonBar();
			home.update();

			home.alpha = 0;
			home.visible = true;
			addChild(home);

			TweenLite.to(home, 2.0, { delay: 0.5, autoAlpha: 1 });
		}

		public function pushView(nextView:View) {
			Main.KEYBOARD.activateFor(null);

			viewStack.push(nextView);
			Main.HEADER.reset();
			Main.FOOTER.resetButtonBar();
			nextView.update();

			var prevView:View = viewStack[viewStack.length - 2];

			nextView.x = 1280;
			nextView.visible = true;
			addChild(nextView);

			TweenLite.to(prevView, 0.8, { x: -1280, onComplete: function() {
				prevView.visible = false;
			}});
			TweenLite.to(nextView, 0.8, { x: 0 });
		}

		public function replaceView(newView:View) {
			Main.KEYBOARD.activateFor(null);

			var oldView:View = viewStack.pop();
			viewStack.push(newView);
			Main.HEADER.reset();
			Main.FOOTER.resetButtonBar();
			newView.update();

			newView.x = 1280;
			newView.visible = true;
			addChild(newView);

			TweenLite.to(oldView, 0.8, { x: -1280, onComplete: function() {
				oldView.visible = false;
			}});
			TweenLite.to(newView, 0.8, { x: 0 });
		}

		public function popView() {
			Main.KEYBOARD.activateFor(null);
			if (viewStack.length == 1) {
				return;
			}

			// remove last and push previous to the front
			var lastPage:View = viewStack.pop();
			var prevPage:View = viewStack[viewStack.length - 1];

			Main.HEADER.reset();
			Main.FOOTER.resetButtonBar();
			prevPage.update();
			prevPage.x = -1280;
			prevPage.visible = true;

			TweenLite.to(lastPage, 0.8, { x: 1280, onComplete: function() {
				lastPage.visible = false;
			}});
			TweenLite.to(prevPage, 0.8, { x: 0 });
		}

		public function updateView() {
			var view:View = viewStack[viewStack.length - 1];
			view.alpha = 0;
			view.update();
			TweenLite.to(view, 2.0, { autoAlpha: 1 });
		}
	}

}
