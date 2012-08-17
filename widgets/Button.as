package utils {
		
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.display.Stage;
	import flash.display.Sprite;
	
	public class Buttons extends Sprite {
		private var color:String;
		private var drawWidth:int;
		private var drawHeight:int;

		public function Buttons(posX:int = 0, posY:int = 0, color:String = 'blue') {
			this.x = posX;
			this.y = posY;
			this.buttonMode = true;
			
			this.color = color;
			this.drawWidth = 390;
			this.drawHeight = 180;
			
			trace('new button: ', this.x, this.y, this.width, this.height);
			drawButton();
			
			this.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		private function drawButton():void {
			// 3D Effect draw darken color
			graphics.beginFill(Colors.getDarkColor(this.color));
			graphics.drawRoundRect(0, 0, this.drawWidth, this.drawHeight, 10);
			graphics.endFill();
			
			// Draw normal color
			graphics.beginFill(Colors.getColor(this.color));
			graphics.drawRoundRect(0, 0, this.drawWidth, this.drawHeight - 10, 10);
			graphics.endFill();
		}

		private function onClick(e:Event) {
			trace('click!');
			
			// Draw click status. We need no onLeave because we have a touchscreen
			graphics.beginFill(Colors.getColor(this.color));
			graphics.drawRoundRect(0, 0, this.drawWidth, this.drawHeight - 6, 10);
			graphics.endFill();
			
			// TODO call another method?
		}
	}
	
}
