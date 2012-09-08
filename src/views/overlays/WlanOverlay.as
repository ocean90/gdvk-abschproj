package views.overlays {
	import com.greensock.TweenLite;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	import utils.Colors;
	import utils.Grid;

	import views.PageOverlay;

	import widgets.SmallButton;
	import widgets.TextLabel;

	/**
	 * WLAN Dialog der Name und Passwort des Netzwerkes anzeigt.
	 */
	public class WlanOverlay extends PageOverlay {

		var infoText:TextLabel;

		public function WlanOverlay(background:* = 0xffffff, w:Number = 870,h:Number = 700) {
			super(background, w, h);
			setText('WLAN');

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

			var nameBox:Sprite = new Sprite();
			nameBox.graphics.beginFill(Colors.getColor('lightgray'));
			nameBox.graphics.drawRect(0, 0, Grid.SPAN_4, 80);
			nameBox.graphics.endFill();

			var name:TextLabel = new TextLabel();
			name.setText('WLAN-FH-WORLDRECORD');
			name.shapeWidth = Grid.SPAN_4;
			name.shapeHeight = 80;
			name.textFormat.size = 50;
			name.textFormat.letterSpacing = 10;
			name.textFormat.align = 'center';
			name.update();

			nameBox.addChild(name);
			nameBox.x = Grid.COLUMN_2;
			nameBox.y = 450;
			addChild(nameBox);

			var pwBox:Sprite = new Sprite();
			pwBox.graphics.beginFill(Colors.getColor('lightgray'));
			pwBox.graphics.drawRect(0, 0, Grid.SPAN_4, 80);
			pwBox.graphics.endFill();

			var pw:TextLabel = new TextLabel();
			pw.setText('1234567890abcdef');
			pw.shapeWidth = Grid.SPAN_4;
			pw.shapeHeight = 80;
			pw.textFormat.size = 50;
			pw.textFormat.letterSpacing = 10;
			pw.textFormat.align = 'center';
			pw.update();

			pwBox.addChild(pw);
			pwBox.x = Grid.COLUMN_2;
			pwBox.y = 600;
			addChild(pwBox);

			showCancelButton((Main.LANGUAGE == 'DE' ? 'Zurück' : 'Back'), function() {
				Main.CONTENT.hideOverlay();
			});
		}
	}
}