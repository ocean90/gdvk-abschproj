package views.main {

	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.events.Event;

	import com.greensock.TweenLite;
	import com.greensock.easing.Back;
	import com.greensock.easing.Quint;

	import utils.Grid;

	import widgets.TextLabel;
	import widgets.BigButton;
	import widgets.InverseText;

	import views.View;
	import views.overlays.BarcodeOverlay;
	import flash.display.MovieClip;

	public class UserDataPage extends View {

		private var barcodeButton:BigButton;

		public function UserDataPage() {
			// constructor code
		}

		public override function onResume():Boolean {
			if (Main.LANGUAGE == 'DE') {
				Main.HEADER.setText('Meine Daten');
				Main.HEADER.addHeadline('Fakten für den Weltrekord', 200);
				Main.HEADER.addHeadline('Persönliche Daten', 400);
			} else if (Main.LANGUAGE == 'EN') {
				Main.HEADER.setText('My data');
				Main.HEADER.addHeadline('Facts for the worldrecord', 200);
				Main.HEADER.addHeadline('Personal data', 400);
			}
			return true;
		}

		public override function update() {
			while (numChildren > 0) {
				removeChildAt(0);
			}

			var lineHeight:int = 40;
			var posY:int;

			var delayTime:Number = 0.8;
			var addDelay:Number = 0.05;

			if (Main.LANGUAGE == 'DE') {
				Main.HEADER.setText('Meine Daten');

				Main.HEADER.addHeadline('Persönliche Daten', 200, delayTime += addDelay);
				posY = 220;
				addPersonalData('Persönliche ID:', Main.USER.getData('id'), posY += lineHeight, delayTime += addDelay);
				addPersonalData('Vorname', Main.USER.getData('firstname'), posY += lineHeight, delayTime += addDelay);
				addPersonalData('Nachname:', Main.USER.getData('lastname'), posY += lineHeight, delayTime += addDelay);
				addPersonalData('Stadt:', Main.USER.getData('city'), posY += lineHeight, delayTime += addDelay);
				addPersonalData('Geburtsdatum:', Main.USER.getData('dateOfBirth'), posY += lineHeight, delayTime += addDelay);

				delayTime += 0.3;
				addRightHeadline('Ihre Teilnahme', Grid.COLUMN_3, 200, delayTime += addDelay);
				posY = 220;
				addRecordData('Dein Platz', 'Flur 2. Etage', posY += lineHeight, delayTime += addDelay);
				addRecordData('', 'Sitz 2.106', posY += lineHeight, delayTime += addDelay);

				addHelperImage(575, delayTime += addDelay);
				addRightHeadline('Dein Betreuer', Grid.COLUMN_3, 500, delayTime += addDelay);
				addRecordData('Dominik Schilling', '', 850, delayTime += addDelay);

				delayTime += 0.3;
				addRightHeadline('Barcode', Grid.COLUMN_5, 200, delayTime += addDelay);
				posY = 220;
				lineHeight = 35;
				createBarcodeText('Für den Weltrekord ist es nötig, dass alle', posY += lineHeight, delayTime += addDelay);
				createBarcodeText('Teilnehmer einen eindeutigen Teilnehmer-', posY += lineHeight, delayTime += addDelay);
				createBarcodeText('Barcode erhalten und gut sichtbar an Ihrem', posY += lineHeight, delayTime += addDelay);
				createBarcodeText('Platz befestigen. Bitte drucke Dir den', posY += lineHeight, delayTime += addDelay);
				createBarcodeText('Barcode daher direkt hier aus!', posY += lineHeight, delayTime += addDelay);

				barcodeButton = new BigButton(Grid.COLUMN_5, 500, 'green');
				barcodeButton.shapeWidth = Grid.SPAN_2;
				barcodeButton.shapeHeight = Grid.SPAN_1;
				barcodeButton.addEventListener(MouseEvent.CLICK, onPrintBarcode);
				barcodeButton.maxIconSizeWidth = 284;
				barcodeButton.setIcon(new BarcodeIcon(), -20, -70);
				barcodeButton.setText('Barcode drucken');

				barcodeButton.alpha = 0;
				barcodeButton.x = Grid.COLUMN_6 + Grid.COLUMN_2;
				addChild(barcodeButton);
				TweenLite.to(barcodeButton, 0.8, { x: Grid.COLUMN_5, autoAlpha: 1.0, delay: delayTime += addDelay, ease:Quint.easeOut });

			} else if (Main.LANGUAGE == 'EN') {
				Main.HEADER.setText('My data');

				Main.HEADER.addHeadline('Personal data', 200, delayTime += addDelay);
				posY = 220;
				addPersonalData('Personal ID:', Main.USER.getData('id'), posY += lineHeight, delayTime += addDelay);
				addPersonalData('Firstname:', Main.USER.getData('firstname'), posY += lineHeight, delayTime += addDelay);
				addPersonalData('Surname:', Main.USER.getData('lastname'), posY += lineHeight, delayTime += addDelay);
				addPersonalData('City', Main.USER.getData('city'), posY += lineHeight, delayTime += addDelay);
				addPersonalData('Date of birth:', Main.USER.getData('dateOfBirth'), posY += lineHeight, delayTime += addDelay);

				delayTime += 0.3;
				addRightHeadline('Your membership', Grid.COLUMN_3, 200, delayTime += addDelay);
				posY = 220;
				addRecordData('Your place', 'Corridor 2nd floor', posY += lineHeight, delayTime += addDelay);
				addRecordData('', 'Seat 2.106', posY += lineHeight, delayTime += addDelay);

				addHelperImage(525, delayTime += addDelay);
				addRightHeadline('Your advisor', Grid.COLUMN_3, 500, delayTime += addDelay);
				addRecordData('Pierre Favre', '', 800, delayTime += addDelay);

				delayTime += 0.3;
				addRightHeadline('Barcode', Grid.COLUMN_5, 200, delayTime += addDelay);
				posY = 220;
				lineHeight = 35;
				createBarcodeText('It\' required for the worldrecord that all', posY += lineHeight, delayTime += addDelay);
				createBarcodeText('participants have an unique barcode identifier', posY += lineHeight, delayTime += addDelay);
				createBarcodeText('which is clearly visible on your drums.', posY += lineHeight, delayTime += addDelay);
				createBarcodeText('Please print now and here your barcode:', posY += lineHeight, delayTime += addDelay);

				barcodeButton = new BigButton(Grid.COLUMN_5, 500, 'green');
				barcodeButton.shapeWidth = Grid.SPAN_2;
				barcodeButton.shapeHeight = Grid.SPAN_1;
				barcodeButton.addEventListener(MouseEvent.CLICK, onPrintBarcode);
				barcodeButton.setIcon(new BarcodeIcon(), -20, -70);
				barcodeButton.setText('Print barcode');

				barcodeButton.alpha = 0;
				barcodeButton.x = Grid.COLUMN_6 + Grid.COLUMN_2;
				addChild(barcodeButton);
				TweenLite.to(barcodeButton, 0.8, { x: Grid.COLUMN_5, autoAlpha: 1.0, delay: delayTime += addDelay, ease:Quint.easeOut });
			}
		}

		private function addPersonalData(labelText:String, valueText:String, posY:int, delay:Number = 0) {
			var label:TextLabel = new TextLabel();
			label.x = Grid.COLUMN_1;
			label.y = posY;
			label.shapeWidth = Grid.SPAN_1;
			label.shapeHeight = 50;
			label.setText(labelText);

			var value:TextLabel = new TextLabel();
			value.x = Grid.COLUMN_2;
			value.y = posY;
			value.shapeWidth = Grid.SPAN_4;
			value.shapeHeight = 50;
			value.setText(valueText);

			var line:Sprite = new Sprite();
			line.addChild(label);
			line.addChild(value);

			line.x = -Grid.SPAN_1;
			line.alpha = 0;
			addChild(line);
			TweenLite.to(line, 0.8, { x: 0, autoAlpha: 1.0, delay: delay, ease:Back.easeOut });
		}

		private function addRecordData(labelText:String, valueText:String, posY:int, delay:Number = 0) {
			var label:TextLabel = new TextLabel();
			label.x = Grid.COLUMN_3;
			label.y = posY;
			label.shapeWidth = Grid.SPAN_1;
			label.shapeHeight = 50;
			label.setText(labelText);

			var value:TextLabel = new TextLabel();
			value.x = Grid.COLUMN_4;
			value.y = posY;
			value.shapeWidth = Grid.SPAN_4;
			value.shapeHeight = 50;
			value.setText(valueText);

			var line:Sprite = new Sprite();
			line.addChild(label);
			line.addChild(value);

			line.x = Grid.SPAN_2; // add extra space for the animcation
			line.alpha = 0;
			addChild(line);
			TweenLite.to(line, 0.8, { x: 0, autoAlpha: 1.0, delay: delay, ease:Back.easeOut });
		}

		private function addHelperImage(posY:int, delay:Number = 0) {
			var helper:MovieClip = new BetreuerImage();
			helper.x = Grid.COLUMN_3;
			helper.y = posY;

			helper.x = Grid.COLUMN_3 + Grid.SPAN_2; // add extra space for the animcation
			helper.alpha = 0;
			addChild(helper);
			TweenLite.to(helper, 0.8, { x: Grid.COLUMN_3, autoAlpha: 1.0, delay: delay, ease:Back.easeOut });
		}

		private function createBarcodeText(labelText:String, posY:int, delay:Number) {
			var label:TextLabel = new TextLabel();
			label.x = Grid.COLUMN_5;
			label.y = posY;
			label.shapeWidth = Grid.SPAN_2;
			label.shapeHeight = 50;
			label.setText(labelText);

			label.x = Grid.COLUMN_5 + Grid.SPAN_2; // add extra space for the animcation
			label.alpha = 0;
			addChild(label);
			TweenLite.to(label, 0.8, { x: Grid.COLUMN_5, autoAlpha: 1.0, delay: delay, ease:Quint.easeOut });
		}

		private function addRightHeadline(text:String, posX:int, posY:int, delay:Number = 0) {
			var headline:InverseText = new InverseText();
			headline.x = posX;
			headline.y = posY;
			headline.textFormat.size = 30;
			headline.textField.x = Grid.COLUMN_PADDING;
			headline.setText(text);

			headline.shapeWidth = headline.textField.textWidth + Grid.COLUMN_PADDING * 2;
			headline.shapeHeight = 50;
			headline.update();

			// einblenden
			headline.x = posX + Grid.COLUMN_2; // add extra space for the animation!
			headline.alpha = 0;
			addChild(headline);

			TweenLite.to(headline, 0.8, { x: posX - Grid.COLUMN_PADDING, alpha: 1.0, delay: delay, ease:Quint.easeOut });
		}

		public function onPrintBarcode(e:Event) {
			Main.CONTENT.showOverlay(new BarcodeOverlay());
		}
	}

}
