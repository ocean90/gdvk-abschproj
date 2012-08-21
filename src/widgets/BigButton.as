package widgets {

	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.display.Stage;
	import flash.display.Sprite;

	import utils.Colors;
	import flash.text.StaticText;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import utils.Grid;
	import fl.text.TLFTextField;
	import flash.text.TextFormat;

	public class BigButton extends Sprite {
		private var textFormat:TextFormat;
		private var textField:TextField;
		
		private var color:String;
		private var drawWidth:int;
		private var drawHeight:int;

		public function BigButton(posX:int = 0, posY:int = 0, color:String = 'blue') {
			this.x = posX;
			this.y = posY;
			this.buttonMode = true;
			
			this.color = color;
			this.drawWidth = Grid.SPAN_2;
			this.drawHeight = Grid.SPAN_1;
			
			trace('new button with current fix width and height and text!!', this.x, this.y, this.width, this.height);
			
			mouseUp(null);
			
			textFormat = new TextFormat();
			textFormat.color = '0xffffff';
			textFormat.font = 'Myriad Pro';
			textFormat.size = 30;
			textFormat.align = TextFieldAutoSize.CENTER;
			
			textField = new TextField();
			textField.mouseEnabled = false;
			setText('Hallo\nasdsd');
			
			addChild(textField);
			
			
			this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			this.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
		}
		
		public function setText(text:String) {
			textField.text = text;
			textField.setTextFormat(textFormat);
			
			textField.width = Grid.SPAN_2;
			// hack from http://stackoverflow.com/questions/1568181/flash-vertical-text-alignment-in-middle
			textField.y = this.height * 0.5 - textField.textHeight * 0.5;
		}
		
		private function mouseDown(e:Event) {
			// 3D Effect draw darken color
			graphics.beginFill(Colors.getDarkColor(this.color));
			graphics.drawRoundRect(0, 0, this.drawWidth, this.drawHeight, 10);
			graphics.endFill();
			
			// Draw normal color
			graphics.beginFill(Colors.getColor(this.color));
			graphics.drawRoundRect(0, 0, this.drawWidth, this.drawHeight - 6, 10);
			graphics.endFill();
		}
		
		private function mouseUp(e:Event) {
			// 3D Effect draw darken color
			graphics.beginFill(Colors.getDarkColor(this.color));
			graphics.drawRoundRect(0, 0, this.drawWidth, this.drawHeight, 10);
			graphics.endFill();
			
			// Draw normal color
			graphics.beginFill(Colors.getColor(this.color));
			graphics.drawRoundRect(0, 0, this.drawWidth, this.drawHeight - 10, 10);
			graphics.endFill();
		}
	}
	
}
