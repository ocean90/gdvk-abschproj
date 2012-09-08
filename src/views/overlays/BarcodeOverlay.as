package views.overlays {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	import com.greensock.TweenLite;

	import utils.Grid;
	import utils.Colors;

	import views.PageOverlay;
	import widgets.SmallButton;
	import widgets.TextLabel;

	/**
	 * Barcode Druck Dialog der angezeigt wird wenn man auf der Benutzer-Daten-Seite
	 * auf "Barcode drucken" drückt.
	 * Entgegen der anderen Overlays bietet dieses Overlay keine Option zum beenden an.
	 * Es zeigt dem Benutzer an das jetzt etwas passiert und er in den Druckausgabe-
	 * Schacht schauen muss. Das Fenster verschwindet dann automatisch wieder!
	 */
	public class BarcodeOverlay extends PageOverlay {
		
		var infoText:TextLabel;
		
		public function BarcodeOverlay(background:* = 0xffffff, w:Number = 870,h:Number = 700) {
			super(background, w, h);
			setText(Main.LANGUAGE == 'DE' ? 'Barcode' : 'Barcode');
			
			infoText = new TextLabel();
			infoText.x = Grid.COLUMN_2;
			infoText.y = 300;
			infoText.shapeWidth = Grid.SPAN_4;
			infoText.shapeHeight = 100;
			infoText.textFormat.leading = 20;
			
			if (Main.LANGUAGE == 'DE') {
				infoText.setText('Ihr Barcode wird jetzt gedruckt. Bitte haben Sie einen moment geduld.\n');
			} else {
				infoText.setText('Your barcode is now printed. Please be patient a moment.\n');
			}
			addChild(infoText);
			
			var box1:Sprite = new Sprite();
			box1.graphics.beginFill(0x000000);
			box1.graphics.drawRoundRect(0, 0, 200, 200, 10);
			box1.graphics.endFill();
			
			var box2:Sprite = new Sprite();
			box2.graphics.beginFill(0xffffff);
			box2.graphics.drawRoundRect(10, 10, 200 - 20, 200 - 20, 10);
			box2.graphics.endFill();
			
			addChild(box1);
			addChild(box2);
			
			box1.x = Main.STAGE.width * 0.5 - 100;
			box1.y = 440;
			
			box2.alpha = 0;
			box2.x = box1.x;
			box2.y = box1.y + 200;
			
			TweenLite.to(box2, 0.2, { autoAlpha: 1, delay: 2, onComplete: function() {
				TweenLite.to(box2, 4, { y: box1.y, onComplete: function() {
					Main.CONTENT.hideOverlay();
				}});
			}});
		}
	}
}