package widgets {

	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.display.Stage;
	import flash.display.Sprite;

	import utils.Colors;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import utils.Grid;
	import flash.text.TextFormat;

	public class RoundButton extends Sprite {
		public var textFormat:TextFormat;
		public var textField:TextField;
		
		public var color:String;
		public var shapeRadius:int;
		
		public var defaultShadowSize:int = 6;
		public var pushedShadowSize:int = 2;

		public function RoundButton(shapeRadius:int, text:String, color:String = 'blue') {
			this.buttonMode = true;
			this.shapeRadius = shapeRadius;
			this.color = color;
			
			textFormat = new TextFormat();
			textFormat.color = '0x888888';
			textFormat.font = 'Myriad Pro';
			textFormat.size = 50;
			textFormat.align = TextFieldAutoSize.CENTER;
			
			textField = new TextField();
			textField.mouseEnabled = false;
			textField.text = text;
			this.update();
			
			addChild(textField);
			
			this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			this.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
			this.addEventListener(MouseEvent.MOUSE_OUT, mouseUp);
		}
		
		public function update() {
			textField.setTextFormat(textFormat);
			
			textField.width = this.shapeRadius * 2;
			textField.height = this.shapeRadius * 2;
			
			// Required for recalculate the textField size and repaint the background!
			mouseUp(null);
		}
		
		protected function mouseDown(e:Event) {
			textField.x = this.shapeRadius - textField.textWidth + 3;
			textField.y = this.shapeRadius - textField.textHeight + 28
						- this.pushedShadowSize;
			
			graphics.clear();
			
			// 3D Effect draw darken color
			graphics.beginFill(Colors.getDarkColor(this.color));
			graphics.drawCircle(shapeRadius, shapeRadius, shapeRadius);
			graphics.endFill();
			
			// Draw normal color
			graphics.beginFill(Colors.getColor(this.color));
			graphics.drawCircle(shapeRadius, shapeRadius - this.pushedShadowSize, shapeRadius);
			graphics.endFill();
		}
		
		protected function mouseUp(e:Event) {
			textField.x = this.shapeRadius - textField.textWidth + 3;
			textField.y = this.shapeRadius - textField.textHeight + 28
						- this.defaultShadowSize;
			
			graphics.clear();
			
			// 3D Effect draw darken color
			graphics.beginFill(Colors.getDarkColor(this.color));
			graphics.drawCircle(shapeRadius, shapeRadius, shapeRadius);
			graphics.endFill();
			
			// Draw normal color
			graphics.beginFill(Colors.getColor(this.color));
			graphics.drawCircle(shapeRadius, shapeRadius - this.defaultShadowSize, shapeRadius);
			graphics.endFill();
		}
	}
	
}
