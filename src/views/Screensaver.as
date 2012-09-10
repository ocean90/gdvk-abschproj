package views {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import com.greensock.TweenLite;

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
		private var timer2:Timer = new Timer(1000 * 10); // 10 seconds

		private var added:Boolean;

		private var __width:Number;
		private var __height:Number;
		private var __background:uint;
		
		private var en:TextField;
		private var de:TextField;

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
			timer.start();
			
			// Language switcher
			timer2.addEventListener(TimerEvent.TIMER, switchLanguage);
			
			var textFormat:TextFormat = new TextFormat();
			textFormat.color = '0x000000';
			textFormat.font = 'Myriad Pro';
			textFormat.size = 40;
			textFormat.align = 'center';

			en = new TextField();
			de = new TextField();
			en.mouseEnabled = de.mouseEnabled = false;
			en.width = de.width = __width;
			en.text = "Touch the screen to start";
			de.text = "Berühre den Bildschirm um zu starten";
			de.setTextFormat(textFormat);
			en.setTextFormat(textFormat);
			en.alpha = 0;

			// Show screensaver
			show(null);
		}

		public function show(e:Event):void {
			// Screensaver is already shown
			if (added)
				return;
				
			timer2.start();

			// New screensaver
			init(__background, __width, __height);

			added = true;
			
			setText('Check-in & Info Terminal');

			var logo:MovieClip = new LogoBig();
			logo.x = __width * 0.5 - logo.width * 0.5
			logo.y = __height * 0.5 - logo.height * 0.5
			contentBox.addChild(logo);
			
			de.y = en.y = logo.y + logo.height + 50;
			contentBox.addChild(de);
			contentBox.addChild(en);

			// reset screen when screensaver is shown
			Main.resetEnvironment();
			
			// Click on the screen to destroy the screensaver
			contentBox.buttonMode = true;
			contentBox.addEventListener(MouseEvent.CLICK, resetScreen);
		}
		
		private function switchLanguage(e:Event):void {
			if (! added)
				return;
				
			timer2.stop();
				
			if ( en.alpha == 0 ) {
				TweenLite.to(de, .2, { alpha: 0, onComplete: function() {
					TweenLite.to(en, 0.3, { alpha: 1 });
				}});
			} else {
				TweenLite.to(en, .2, { alpha: 0, onComplete: function() {
					TweenLite.to(de, 0.3, { alpha: 1 });
				}});
			}

			timer2.start();
			
		}

		private function restartTimer(e:Event):void {
			timer.stop();
			timer.start();
		}

		private function resetScreen(e:Event):void {
			// reset screen. Normally this should already happen when screensaver is shown
			Main.resetEnvironment();
			Main.CONTENT.showHome();
			
			// Remove overlay
			added = false;
			timer2.stop();
			destroy();
		}
	}
}