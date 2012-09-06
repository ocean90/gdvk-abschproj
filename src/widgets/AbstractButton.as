﻿package widgets {

	import fl.motion.Color;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	import utils.Colors;
	import utils.Grid;

	public class AbstractButton extends Sprite {
		public var textFormat:TextFormat;
		public var textField:TextField;

		public var color:String;
		public var shapeWidth:int;
		public var shapeHeight:int;

		public var defaultShadowSize:int = 6;
		public var pushedShadowSize:int = 2;

		public function AbstractButton() {
			this.buttonMode = true;

			textFormat = new TextFormat();
			textFormat.color = '0xffffff';
			textFormat.font = 'Myriad Pro';
			textFormat.align = TextFieldAutoSize.CENTER;

			textField = new TextField();
			textField.mouseEnabled = false;

			addChild(textField);

			this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			this.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
			this.addEventListener(MouseEvent.MOUSE_OUT, mouseUp);
		}

		public function setText(text:String) {
			textField.text = text;
			this.update();
		}

		public function update() {
			textField.setTextFormat(textFormat);

			textField.width = this.shapeWidth;
			textField.height = this.shapeHeight;

			// Don't overflow the button. Happens through the vertical alignment hack.
			this.scrollRect = new Rectangle(0, 0, this.shapeWidth, this.shapeHeight);

			// Required for recalculate the textField size and repaint the background!
			mouseUp(null);
		}

		protected function mouseDown(e:Event) {
			// hack from http://stackoverflow.com/questions/1568181/flash-vertical-text-alignment-in-middle
			// center button vertical
			textField.y = (this.shapeHeight - this.defaultShadowSize) * 0.5 - textField.textHeight * 0.5
						- this.pushedShadowSize + this.defaultShadowSize;

			graphics.clear();

			// 3D Effect draw darken color
			graphics.beginFill(Colors.getDarkColor(this.color));
			graphics.drawRoundRect(0, 0, this.shapeWidth, this.shapeHeight, 10);
			graphics.endFill();

			// Draw normal color
			graphics.beginFill(Colors.getColor(this.color));
			graphics.drawRoundRect(0, 0, this.shapeWidth, this.shapeHeight - this.pushedShadowSize, 10);
			graphics.endFill();
		}

		protected function mouseUp(e:Event) {
			// hack from http://stackoverflow.com/questions/1568181/flash-vertical-text-alignment-in-middle
			// center button vertical
			textField.y =  (this.shapeHeight - this.defaultShadowSize) * 0.5 - textField.textHeight * 0.5;

			graphics.clear();

			// 3D Effect draw darken color
			graphics.beginFill(Colors.getDarkColor(this.color));
			graphics.drawRoundRect(0, 0, this.shapeWidth, this.shapeHeight, 10);
			graphics.endFill();

			// Draw normal color
			graphics.beginFill(Colors.getColor(this.color));
			graphics.drawRoundRect(0, 0, this.shapeWidth, this.shapeHeight - this.defaultShadowSize, 10);
			graphics.endFill();
		}

		public function setIcon(icon:MovieClip) {
			var newColorTransform:ColorTransform = icon.transform.colorTransform;
			newColorTransform.color = Colors.getDarkColor(this.color);
			icon.transform.colorTransform = newColorTransform;
			icon.width = 100;
			icon.height = 200;
			icon.x = 10;
			addChild(icon);
		}
	}

}
