package widgets {

	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.display.Stage;
	import flash.display.Sprite;

	import utils.Colors;

	public class BigButton extends Sprite {
		private var color:String;
		private var drawWidth:int;
		private var drawHeight:int;

		public function BigButton(posX:int = 0, posY:int = 0, color:String = 'blue') {
			this.x = posX;
			this.y = posY;
			this.buttonMode = true;
			
			this.color = color;
			this.drawWidth = 390;
			this.drawHeight = 180;
			
			trace('new button: ', this.x, this.y, this.width, this.height);
			
			mouseUp(null);
			this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			this.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
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
