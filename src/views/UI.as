﻿package views {
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.events.Event;

	import com.greensock.TweenLite;
	import widgets.PageOverlay;
	import widgets.SmallButton;

	public class UI extends MovieClip {

		private var viewStack:Vector.<View> = new Vector.<View>();
		public var overlay:PageOverlay = null;

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
			if (overlay) {
				hideOverlay();
			}
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
			if (overlay) {
				hideOverlay();
			}
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
			if (overlay) {
				hideOverlay();
			}
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
		
		public function get length() {
			return viewStack.length;
		}
		
		// === OVERLAY FUNCTIONS ===
		
		public function showOverlay(overlay:PageOverlay) {
			this.overlay = overlay;
			this.overlay.update();
			addChild(overlay);
		}
		
		public function hideOverlay() {
			if (this.overlay) {
				this.overlay.destroy();
				removeChild(this.overlay);
				this.overlay = null;
				
				Main.KEYBOARD.activateFor(null);
				Main.HEADER.reset();
				Main.FOOTER.resetButtonBar();
				
				var view:View = viewStack[viewStack.length - 1];
				view.update();
			}
		}
		
		public function resetButtonBar() {
			if (overlay) {
				overlay.cancel.visible = false;
				overlay.submit.visible = false;
			}
			Main.FOOTER.resetButtonBar();
		}
		
		/**
		 * Redirects the cancel callback registration to the overlay or the button bar.
		 */
		public function showCancelButton(text:String, callback:Function) {
			if (overlay) {
				overlay.showCancelButton(text, callback);
			} else {
				Main.FOOTER.showCancelButton(text, callback);
			}
		}
		
		/**
		 * Returns the cancel button of the overlay or the buttonbar.
		 */
		public function get cancelButton():SmallButton {
			if (overlay) {
				return overlay.cancel;
			} else {
				return Main.FOOTER.cancel;
			}
		}

		/**
		 * Redirects the submit callback registration to the overlay or the button bar.
		 */
		public function showSubmitButton(text:String, callback:Function) {
			if (overlay) {
				overlay.showSubmitButton(text, callback);
			} else {
				Main.FOOTER.showSubmitButton(text, callback);
			}
		}
		
		/**
		 * Returns the cancel button of the overlay or the buttonbar.
		 */
		public function get submitButton():SmallButton {
			if (overlay) {
				return overlay.submit;
			} else {
				return Main.FOOTER.submit;
			}
		}

	}

}
