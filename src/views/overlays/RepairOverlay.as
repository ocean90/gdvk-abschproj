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
	public class RepairOverlay extends PageOverlay {

		var infoText:TextLabel;

		public function RepairOverlay(background:* = 0xffffff, w:Number = 870,h:Number = 700) {
			super(background, w, h);
			setText(Main.LANGUAGE == 'DE' ? 'Reparatur' : 'Repair');

			infoText = new TextLabel();
			infoText.x = Grid.COLUMN_2;
			infoText.y = 300;
			infoText.shapeWidth = Grid.SPAN_4;
			infoText.shapeHeight = 100;
			infoText.textFormat.leading = 20;

			if (Main.LANGUAGE == 'DE') {
				infoText.setText('Als Teilnehmer hast Du Zugriff auf das WLAN-Netzwerk der Fachhochschule Köln.\nNetzwerkname und Passwort lauten:');
			} else {
				infoText.setText('As a member you get access to the wireless network.\nName of the network and password are:');
			}
			addChild(infoText);

			showCancelButton((Main.LANGUAGE == 'DE' ? 'Abbrechen' : 'Cancel'), function() {
				Main.CONTENT.hideOverlay();
			});
		}
	}
}