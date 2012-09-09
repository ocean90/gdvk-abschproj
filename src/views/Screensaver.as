﻿package views {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	import utils.Colors;
	import utils.Grid;

	import views.PageOverlay;

	import widgets.SmallButton;
	import widgets.TextLabel;

	/**
	 * Implementierung eines Screensavers mit welchem die Anwendung startet.
	 * Unterklasse der PageOverlay Klasse, zerstört allerdings das Objekt zunächst
	 * direkt wieder. Ein Neues wird durch den init() Aufruf erstellt.
	 *
	 * Der Screensaver kann durch Klick auf den Screen ausgeblendet werden.
	 *
	 * Nach X Minuten Inaktivität wird der Screensaver wieder angezeigt und die
	 * aktuelle Session gelöscht.
	 */
	public class Screensaver extends PageOverlay {

		private var timer:Timer = new Timer(1000 * 60 * 5); // 5 minutes

		private var added:Boolean;

		private var __width:Number;
		private var __height:Number;
		private var __background:uint;

		public function Screensaver(background:* = 0xffffff, w:Number = 870,h:Number = 700) {
			// Destroy the auto overlay
			destroy(0);

			// Save width, height and background color
			__width = w;
			__height = h;
			__background = background;

			// Add event listener to check user inactivity
			Main.STAGE.addEventListener(MouseEvent.MOUSE_MOVE, restartTimer);
			Main.STAGE.addEventListener(MouseEvent.MOUSE_DOWN, restartTimer);
			Main.STAGE.addEventListener(MouseEvent.MOUSE_UP, restartTimer);

			Main.STAGE.addEventListener(KeyboardEvent.KEY_DOWN, restartTimer);
			Main.STAGE.addEventListener(KeyboardEvent.KEY_UP, restartTimer);

			// Add event listener for timer complete
			timer.addEventListener(TimerEvent.TIMER, show);

			// Show screensaver
			show(null);
		}

		private function show(e:Event):void {
			// Screensaver is already shown
			if (added)
				return;

			// New screensaver
			init(__background, __width, __height);

			added = true;

			setText('Check-in & Info Terminal');

			var logo:MovieClip = new LogoBig();
			logo.x = __width * 0.5 - logo.width * 0.5
			logo.y = __height * 0.5 - logo.height * 0.5
			contentBox.addChild(logo);

			// Click on the screen to destroy the screensaver
			contentBox.buttonMode = true;
			contentBox.addEventListener(MouseEvent.CLICK, resetScreen);
		}

		private function restartTimer(e:Event):void {
			timer.stop();
			timer.start();
		}

		private function resetScreen(e:Event):void {
			// Remove overlay
			destroy();

			// Open Index page
			Main.CONTENT.pushHome(Views.Index);

			// No screensaver
			added = false;
		}
	}
}