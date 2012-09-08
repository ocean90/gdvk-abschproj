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
	 * Eine eigene Funktion als Overlay implementiert. Der "Ich brauche Hilfe" Dialog.
	 * Schritt 1: Nochmal Info anzeigen und die Option anbieten wirklich hilfe zu rufen.
	 * Dies soll verhindern das Hilfe geschickt wird nur weil der Benutzer z.b. auf der
	 * Startseite "aus Spaß" oder "ausversehen" auf den Hilfe-Button gedrückt hat.
	 * Schritt 2: Information das jetzt wirklich Hilfe Unterwegs ist.
	 */
	public class HelpOverlay extends PageOverlay {
		
		var infoText:TextLabel;
		
		public function HelpOverlay(background:* = 0xffffff, w:Number = 870,h:Number = 700) {
			super(background, w, h);
			setText(Main.LANGUAGE == 'DE' ? 'Vor-Ort-Hilfe' : 'Local support');
			
			infoText = new TextLabel();
			infoText.x = Grid.COLUMN_2;
			infoText.y = 300;
			infoText.shapeWidth = Grid.SPAN_4;
			infoText.shapeHeight = 300;
			infoText.textFormat.leading = 20;
			
			if (Main.LANGUAGE == 'DE') {
				infoText.setText('Wenn Sie hilfe an ihrem aktuellen Ort brauchen drücken Sie bitte auf "Hilfe rufen".\n' +
								 'Wir werden anschließend einen freundlichen Helfer zu Ihnen schicken!\n\n\n');
			} else {
				infoText.setText('If you need help in your current location, feel free to press "Call help".\n' +
								 'We will then send a friendly helper to you!\n\n\n');
			}
			addChild(infoText);
			
			showCancelButton((Main.LANGUAGE == 'DE' ? 'Abbrechen' : 'Cancel'), function() {
				Main.CONTENT.hideOverlay();
			});
			showSubmitButton((Main.LANGUAGE == 'DE' ? 'Hilfe rufen' : 'Call help'), function() {
				infoText.alpha = 0;
				if (Main.LANGUAGE == 'DE') {
					setText('Hilfe ist unterwegs!');
					infoText.setText('Bitte warten Sie an Ihrem Terminal und schließen Sie dieses Fenster\n' +
									 'erst wenn unsere Unterstützung Sie erreicht hat.\n' +
									 'Sollten Sie keine Hilfe mehr benötigen drücken Sie einfach auf Abbrechen.\n\n');
				} else {
					setText('Help is on the way!');
					infoText.setText('Please wait at your terminal and close the window\n' +
									 'when you have reached by our support.\n' +
									 'If you didn\'t need help anymore please press Cancel.\n\n');
				}
				TweenLite.to(infoText, 2.0, { autoAlpha: 1 });
				TweenLite.to(submit, 0.4, { autoAlpha: 0 });
			});
		}
	}
}