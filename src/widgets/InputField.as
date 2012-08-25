package widgets {
	import flash.display.Sprite;
	import flash.text.TextFormat;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import utils.Colors;
	import com.greensock.TweenLite;
	
	public class InputField extends Sprite {

		public var textFormat:TextFormat;
		public var textField:TextField;
		
		public var shapeWidth:int;
		public var shapeHeight:int;
		
		public var defaultShadowSize:int = 6;
		public var pushedShadowSize:int = 2;
		
		// to use this plugin: http://www.greensock.com/as/docs/tween/com/greensock/plugins/HexColorsPlugin.html
		public var borderColor:Object = { hex: 0x000000 };
		
		public function InputField() {
			textFormat = new TextFormat();
			textFormat.color = '0x000000';
			textFormat.font = 'Myriad Pro';
			textFormat.size = 30;
			
			textField = new TextField();
			textField.type = TextFieldType.INPUT;
			textField.selectable = true;
			textField.mouseEnabled = true;
			textField.tabEnabled = true;
			textField.alwaysShowSelection = true;
			
			// layout
//			textField.border = true;
//			textField.borderColor = 0x666666;
//			textField.background = true;
//			textField.backgroundColor = 0xeeeeee;
			
			textField.setTextFormat(textFormat);
			textField.defaultTextFormat = textFormat;
			addChild(textField);
		}

		public function update() {
			textField.x = 5;
			textField.y = 8;
			textField.width = this.shapeWidth - textField.x * 2;
			textField.height = this.shapeHeight - textField.y * 2;
			
			// hack from http://stackoverflow.com/questions/1568181/flash-vertical-text-alignment-in-middle
			// center button vertical
//			textField.y =  (this.shapeHeight - this.defaultShadowSize) * 0.5 - textField.textHeight * 0.5;
			
			graphics.clear();
			
			// draw box
			graphics.lineStyle(2, this.borderColor.hex);
			graphics.beginFill(0xeeeeee);
			graphics.drawRoundRect(0, 0, this.shapeWidth, this.shapeHeight, 10);
			graphics.endFill();
		}
		
		public function highlight(color:uint) {
			borderColor.hex = color;
			update();
			TweenLite.to(borderColor, 1.6, {
				delay: 1.6,
				hexColors: { hex: 0x000000 },
				onUpdate: update
			} );
		}
	}
	
}
