package widgets {
	import flash.display.DisplayObject;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.display.Sprite;
	
	public class TextLabel extends Sprite {

		public var textFormat:TextFormat;
		public var textField:TextField;
		
		public var shapeWidth:int;
		public var shapeHeight:int;
		
		public function TextLabel() {
			textFormat = new TextFormat();
			textFormat.color = '0x000000';
			textFormat.font = 'Myriad Pro';
			textFormat.size = 20;
			textFormat.leading = 20;
			
			textField = new TextField();
			textField.mouseEnabled = false;
			
			addChild(textField);
		}

		public function setText(text:String) {
			textField.text = text;
			this.update();
		}
		
		public function update() {
			textField.setTextFormat(textFormat);
			if (shapeWidth && shapeHeight) {
				textField.width = shapeWidth;
				textField.height = shapeHeight;
				// hack from http://stackoverflow.com/questions/1568181/flash-vertical-text-alignment-in-middle
				// center button vertical
				textField.y = shapeHeight * 0.5 - textField.textHeight * 0.5;
			} else {
				textField.width = textField.textWidth;
				textField.height = textField.textHeight;
				textField.y = 0;
			}
		}
	}
	
}
