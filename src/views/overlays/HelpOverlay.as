package views.overlays {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	import utils.Grid;
	import utils.Colors;

	import widgets.SmallButton;

	import views.PageOverlay;
	import widgets.TextLabel;

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
			
			if (Main.LANGUAGE == 'DE') {
				infoText.setText('Wenn Sie hilfe an ihrem aktuellen Ort brauchen drücken Sie bitte auf "Hilfe rufen".\n' +
								 'Wir werden anschließend einen freundlichen Helfer zu Ihnen schicken!\n\n\n');
			} else {
				infoText.setText('If you need help in their current location, feel free to press "Call help".\n' +
								 'We will then send a friendly helper to you!\n\n\n');
			}
			addChild(infoText);
			
			showCancelButton((Main.LANGUAGE == 'DE' ? 'Abbrechen' : 'Cancel'), function() {
				Main.CONTENT.hideOverlay();
			});
			showSubmitButton((Main.LANGUAGE == 'DE' ? 'Hilfe rufen' : 'Call help'), function() {
				if (Main.LANGUAGE == 'DE') {
					infoText.setText('Hilfe ist unterwegs!\n' +
									 'Bitte warten Sie an Ihrem Terminal und schließen Sie dieses Fenster\n' +
									 'erst wenn unsere Unterstützung Sie erreicht hat.\n' +
									 'Sollten Sie keine Hilfe mehr benötigen drücken Sie einfach auf Abbrechen.');
				} else {
					infoText.setText('Help is on the way!\n' +
									 'Please wait at your terminal and close the window\n' +
									 'when you have reached by our support.\n' +
									 'If you didn\'t need help anymore please press Cancel.');
				}
				submit.visible = false;
			});
		}
	}
}