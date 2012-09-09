package views {
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.events.Event;

	import com.greensock.TweenLite;

	import views.PageOverlay;
	import widgets.SmallButton;

	/**
	 * Diese Klasse spiegelt die Content Bereich der Oberfläche wieder und kümmert sich
	 * um die View animationen wenn eine Seite ausgetauscht wird. So erscheinen neue
	 * Seiten die per pushView hinzugefügt werden automatisch von Rechts und alte von
	 * Links wenn Views über popView aufgeräumt werden.
	 */
	public class UI extends MovieClip {

		private var home:View;
		private var viewStack:Vector.<View> = new Vector.<View>();
		public var overlay:PageOverlay = null;

		public function UI(home:View) {
			this.home = home;
		}

		/**
		 * Kann von überall aufgerufen werden wenn die Startseite aufgerufen werden soll.
		 * Z.b. aus der ButtonBar "Hauptseite" oder nach dem Login.
		 */
		public function showHome():void {
			Main.KEYBOARD.activateFor(null);
			if (viewStack.length == 0) {
				// Push a new home instance to the viewstack!
				viewStack.push(home);
				Main.HEADER.reset();
				Main.FOOTER.resetButtonBar();
				home.update();

				home.x = 0;
				home.alpha = 0;
				home.visible = true;
				addChild(home);
	
				TweenLite.to(home, 2.0, { delay: 0.5, autoAlpha: 1 });
			} else if (viewStack.length == 1) {
				// Nothing todo.
			} else {
				// get current view and remove all others
				var prevView:View = viewStack.pop();
				while (viewStack.length > 1) {
					viewStack.pop();
				}
				var homeView:View = viewStack[viewStack.length - 1];
	
				Main.HEADER.reset();
				Main.FOOTER.resetButtonBar();
				if (!homeView.onResume()) {
					homeView.update();
				}
				homeView.x = -1280;
				homeView.visible = true;
	
				TweenLite.to(prevView, 0.8, { x: 1280, onComplete: function() {
					prevView.visible = false;
				}});
				TweenLite.to(homeView, 0.8, { x: 0 });
			}
		}

		public function clear():void {
			if (viewStack.length == 0) {
				return;
			}
			
			// get current view and remove all others
			var prevView:View = viewStack.pop();
			while (viewStack.length > 1) {
				viewStack.pop();
			}
			
			Main.HEADER.reset();
			Main.HEADER.setText(null);
			Main.FOOTER.resetButtonBar();
			
			TweenLite.to(prevView, 0.8, { autoAlpha: 0 });
		}

		/**
		 * Fügt eine neue View auf den Stack hinzu. Animation: Von rechts kommt die neue
		 * View und die alte verlässt den Screen gleichzeitig nach links.
		 */
		public function pushView(nextView:View):void {
			if (overlay) {
				hideOverlay();
			}
			Main.KEYBOARD.activateFor(null);

			viewStack.push(nextView);
			Main.HEADER.reset();
			Main.FOOTER.resetButtonBar();
			nextView.update();

			var prevView:View = viewStack[viewStack.length - 2];
			// This is only to finish the animation from pushHome! This animation was canceled
			// if the user clicked to fast on one of the buttons.. :-)
			prevView.alpha = 1;

			nextView.x = 1280;
			nextView.visible = true;
			addChild(nextView);

			TweenLite.to(prevView, 0.8, { x: -1280, onComplete: function() {
				prevView.visible = false;
			}});
			TweenLite.to(nextView, 0.8, { x: 0 });
		}

		/**
		 * Ersetzt die aktuelle View durch eine neue. Dies wurde z.b. verwendet als der Login
		 * noch eine normale Seite war und die neue "User Daten" Seite nicht auf den Stack
		 * kommen sollte. (Sonst wäre man ja über Zurück zum Login gekommen.)
		 * Aktuell ist diese Funktion aber nicht mehr in Verwendung seit der Login ein Overlay
		 * ist.
		 */
		public function replaceView(newView:View):void {
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

		/**
		 * Entfernt die oberste View vom Stack. Es muss jedoch immer min. eine View
		 * auf dem Stack bleiben. Animation entgegen der von pushView.
		 */
		public function popView():void {
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
			if (!prevPage.onResume()) {
				prevPage.update();
			}
			prevPage.x = -1280;
			prevPage.visible = true;

			TweenLite.to(lastPage, 0.8, { x: 1280, onComplete: function() {
				lastPage.visible = false;
			}});
			TweenLite.to(prevPage, 0.8, { x: 0 });
		}

		/**
		 * Ruft die View#update Methode auf der aktullen View auf und Animiert
		 * die Aktualisierung durch ein schneller Fade-out Fade-in!
		 * Aktuelle Verwendung wenn die Sprach geändert wird.
		 */
		public function updateView():void {
			var view:View = viewStack[viewStack.length - 1];
			view.alpha = 0;
			view.update();
			TweenLite.to(view, 2.0, { autoAlpha: 1 });
		}

		/**
		 * Wird über UI.length von der ButtonBar verwendet um die passenden Buttons anzuzeigen.
		 */
		public function get length():uint {
			return viewStack.length;
		}

		// === OVERLAY FUNCTIONS ===

		/**
		 * Öffnet den übergebenen Overlay.
		 */
		public function showOverlay(overlay:PageOverlay):void {
			this.overlay = overlay;
			this.overlay.update();
			addChild(overlay);
		}

		/**
		 * Schließt einen Overlay wenn aktuell einer geöffnet ist.
		 */
		public function hideOverlay():void {
			if (this.overlay) {
				var old:PageOverlay = this.overlay;
				this.overlay = null;

				old.destroy();
				removeChild(old);

				Main.KEYBOARD.activateFor(null);
				Main.HEADER.reset();
				Main.FOOTER.resetButtonBar();

				var view:View = viewStack[viewStack.length - 1];
				if (!view.onResume()) {
					view.update();
				}
			}
		}
	}
}
