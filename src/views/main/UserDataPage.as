package views.main {
	import views.View;
	import widgets.TextLabel;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import utils.Grid;
	import com.greensock.TweenLite;
	import com.greensock.easing.Back;
	import widgets.BigButton;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import widgets.SmallButton;
	import widgets.InverseText;
	import com.greensock.easing.Quint;
	import views.overlays.BarcodeOverlay;
	
	public class UserDataPage extends View {

		private var barcodeButton:SmallButton;

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
				
				Main.HEADER.addHeadline('Fakten für den Weltrekord', 200, delayTime += addDelay);
				posY = 220;
				createLine('Ihr Platz', 'Flur 2. Etage - Platz 2.106', posY += lineHeight, delayTime += addDelay);
				createLine('Ihr Betreuer', 'Herr Schmitz', posY += lineHeight, delayTime += addDelay);
				
				delayTime += 0.3;
				Main.HEADER.addHeadline('Persönliche Daten', 400, delayTime += addDelay);
				posY = 420;
				createLine('Persönliche ID:', Main.USER.getData('id'), posY += lineHeight, delayTime += addDelay);
				createLine('Vorname', Main.USER.getData('firstname'), posY += lineHeight, delayTime += addDelay);
				createLine('Nachname:', Main.USER.getData('lastname'), posY += lineHeight, delayTime += addDelay);
				createLine('Stadt:', Main.USER.getData('city'), posY += lineHeight, delayTime += addDelay);
				createLine('Geburtsdatum:', Main.USER.getData('dateOfBirth'), posY += lineHeight, delayTime += addDelay);
				
				delayTime += 0.3;
				addRightHeadline('Barcode', Grid.COLUMN_4, 200, delayTime += addDelay);
				posY = 220;
				lineHeight = 35;
				createBarcodeText('Für den Weltrekord ist es nötig, dass alle', posY += lineHeight, delayTime += addDelay);
				createBarcodeText('Teilnehmer einen eindeutigen Teilnehmer-', posY += lineHeight, delayTime += addDelay);
				createBarcodeText('Barcode erhalten und gut sichtbar an Ihrem', posY += lineHeight, delayTime += addDelay);
				createBarcodeText('Platz befestigen. Bitte drucken Sie sich den', posY += lineHeight, delayTime += addDelay);
				createBarcodeText('Barcode daher direkt hier aus!', posY += lineHeight, delayTime += addDelay);
				
				posY = 220;
				barcodeButton = new SmallButton('Barcode\ndrucken', 'green');
				barcodeButton.x = Grid.COLUMN_6;
				barcodeButton.y = posY += lineHeight;
				barcodeButton.shapeWidth = Grid.SPAN_1;
				barcodeButton.shapeHeight = Grid.SPAN_1 * 0.95;
				barcodeButton.addEventListener(MouseEvent.CLICK, onPrintBarcode);
				barcodeButton.update();
				
				barcodeButton.alpha = 0;
				barcodeButton.x = Grid.COLUMN_6 + Grid.COLUMN_2;
				addChild(barcodeButton);
				TweenLite.to(barcodeButton, 0.8, { x: Grid.COLUMN_6, autoAlpha: 1.0, delay: delayTime += addDelay, ease:Back.easeOut });
				
			} else if (Main.LANGUAGE == 'EN') {
				Main.HEADER.setText('My data');
				
				Main.HEADER.addHeadline('Facts for the worldrecord', 200, delayTime += addDelay);
				posY = 220;
				createLine('Your place', 'Corridor 2nd floor - Field 2.106', posY += lineHeight, delayTime += addDelay);
				createLine('Your advisor', 'Herr Schmitz', posY += lineHeight, delayTime += addDelay);
				
				delayTime += 0.3;
				Main.HEADER.addHeadline('Personal data', 400, delayTime += addDelay);
				posY = 420;
				createLine('Personal ID:', Main.USER.getData('id'), posY += lineHeight, delayTime += addDelay);
				createLine('Firstname:', Main.USER.getData('firstname'), posY += lineHeight, delayTime += addDelay);
				createLine('Surname:', Main.USER.getData('lastname'), posY += lineHeight, delayTime += addDelay);
				createLine('City', Main.USER.getData('city'), posY += lineHeight, delayTime += addDelay);
				createLine('Date of birth:', Main.USER.getData('dateOfBirth'), posY += lineHeight, delayTime += addDelay);
				
				delayTime += 0.3;
				addRightHeadline('Barcode', Grid.COLUMN_4, 200, delayTime += addDelay);
				posY = 220;
				lineHeight = 35;
				createBarcodeText('It\' required for the worldrecord that all', posY += lineHeight, delayTime += addDelay);
				createBarcodeText('participants have an unique barcode identifier', posY += lineHeight, delayTime += addDelay);
				createBarcodeText('which is clearly visible on your drums.', posY += lineHeight, delayTime += addDelay);
				createBarcodeText('Please print now and here your barcode:', posY += lineHeight, delayTime += addDelay);
				
				posY = 220;
				barcodeButton = new SmallButton('Print\nbarcode', 'green');
				barcodeButton.x = Grid.COLUMN_6;
				barcodeButton.y = posY += lineHeight;
				barcodeButton.shapeWidth = Grid.SPAN_1;
				barcodeButton.shapeHeight = Grid.SPAN_1 * 0.95;
				barcodeButton.addEventListener(MouseEvent.CLICK, onPrintBarcode);
				barcodeButton.update();
				
				barcodeButton.alpha = 0;
				barcodeButton.x = Grid.COLUMN_6 + Grid.COLUMN_2;
				addChild(barcodeButton);
				TweenLite.to(barcodeButton, 0.8, { x: Grid.COLUMN_6, autoAlpha: 1.0, delay: delayTime += addDelay, ease:Quint.easeOut });
			}
		}
		
		private function createLine(labelText:String, valueText:String, posY:int, delay:Number = 0) {
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
		
		private function createBarcodeText(labelText:String, posY:int, delay:Number) {
			var label:TextLabel = new TextLabel();
			label.x = Grid.COLUMN_4;
			label.y = posY;
			label.shapeWidth = Grid.SPAN_3;
			label.shapeHeight = 50;
			label.setText(labelText);
			
			label.x = Grid.COLUMN_6; // add extra space for the animcation
			label.alpha = 0;
			addChild(label);
			TweenLite.to(label, 0.8, { x: Grid.COLUMN_4, autoAlpha: 1.0, delay: delay, ease:Quint.easeOut });
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
