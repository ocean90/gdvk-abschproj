package widgets {
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	
	public class InverseText extends Sprite {
		
		public var textFormat:TextFormat;
		public var textField:TextField;
		
		public var shape:Shape;
		public var shapeWidth:int;
		public var shapeHeight:int;

		public function InverseText() {
			
			textFormat = new TextFormat();
			textFormat.color = '0xffffff';
			textFormat.font = 'Myriad Pro';
			textFormat.size = 30;
			
			textField = new TextField();
			textField.mouseEnabled = false;
			
			shape = new Shape();
			
			addChild(shape);
			addChild(textField);
			
		}

		public function setText(text:String) {
			textField.text = text;
			this.update();
		}
		
		public function update() {
			textField.setTextFormat(textFormat);
			
			shape.graphics.beginFill(0x000000);
			shape.graphics.drawRect(0, 0, this.shapeWidth, this.shapeHeight);
			shape.graphics.endFill();
			
			textField.width = this.shapeWidth + textField.x;
			textField.height = this.shapeHeight;
			
			// hack from http://stackoverflow.com/questions/1568181/flash-vertical-text-alignment-in-middle
			// center button vertical
			textField.y =  this.shapeHeight * 0.5 - textField.textHeight * 0.5;
		}
		
	}
	
}
