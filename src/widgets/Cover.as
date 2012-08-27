package widgets {
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	import utils.Colors;
	import utils.Grid;

	public class Cover extends Sprite {
		private var _color:uint;
		private var _shapeWidth:Number;
		private var _shapeHeight:Number;

		public function Cover(color:String = 'blue', width:Number = 870, height:Number = 600) {
			_color = Colors.getColor(color);
			_shapeWidth = width;
			_shapeHeight = height;

			paintCover();
		}

		public function paintCover() {
			graphics.beginFill(_color);
			graphics.drawRect(0, 0, _shapeWidth, _shapeHeight);
			graphics.endFill();
		}

		public function setImage(image:MovieClip) {
			image.x = 30;
			image.y = 25
			image.width = 390;
			addChild(image);

			var overlay:Sprite = new Sprite();
			overlay.graphics.beginFill(_color);
			overlay.graphics.drawRect(Grid.COLUMN_2 - 25, 25, _shapeWidth-Grid.COLUMN_2 - 25, 140);
			overlay.graphics.endFill();
			addChild(overlay);
		}

		public function setTitle(title:String) {
			var textFormat:TextFormat = new TextFormat();
			textFormat.color = '0xffffff';
			textFormat.font = 'Myriad Pro';
			textFormat.size = 48;

			var textField:TextField = new TextField();
			textField.mouseEnabled = false;
			textField.text = title;
			textField.x = Grid.COLUMN_2;
			textField.y = 50;
			textField.width = _shapeWidth-Grid.COLUMN_2;
			textField.height = 55;
			textField.setTextFormat(textFormat);

			addChild(textField);
		}

		public function setDesc(desc:String) {
			var textFormat:TextFormat = new TextFormat();
			textFormat.color = '0x000000';
			textFormat.font = 'Georgia';
			textFormat.size = 23;
			textFormat.italic = true;
			textFormat.leading = 10;

			var textField:TextField = new TextField();
			textField.mouseEnabled = false;
			textField.text = desc;
			textField.x = Grid.COLUMN_3;
			textField.y = 160;
			textField.wordWrap = true;
			textField.width = _shapeWidth-Grid.COLUMN_3 - 30;
			textField.height = _shapeHeight - 140;
			textField.setTextFormat(textFormat);

			addChild(textField);
		}

		public function setAuthor(author:String) {
			var textFormat:TextFormat = new TextFormat();
			textFormat.color = '0xffffff';
			textFormat.font = 'Myriad Pro';
			textFormat.size = 24;

			var textField:TextField = new TextField();
			textField.mouseEnabled = false;
			textField.text = '~ ' + author;
			textField.x = Grid.COLUMN_2;
			textField.y = 50 + 55;
			textField.width = _shapeWidth-Grid.COLUMN_2 - 30;
			textField.height = 25;
			textField.setTextFormat(textFormat);

			addChild(textField);
		}

		public function setInfos(data:Array) {
			var textFormat:TextFormat = new TextFormat();
			textFormat.color = '0xffffff';
			textFormat.font = 'Myriad Pro';
			textFormat.size = 21;
			textFormat.leading = 10;

			var textFieldLeft:TextField = new TextField();
			var textFieldRight:TextField = new TextField();
			textFieldLeft.multiline = textFieldRight.multiline = true;
			textFieldLeft.mouseEnabled = textFieldRight.mouseEnabled = false;

			for (var key:String in data){
				textFieldLeft.appendText(key+":\n");
				textFieldRight.appendText(data[key]+"\n");
			}

			textFieldLeft.setTextFormat(textFormat);
			textFieldRight.setTextFormat(textFormat);

			textFieldLeft.x = 30;
			textFieldRight.x = 235;
			textFieldLeft.y = textFieldRight.y = 285;

			textFieldLeft.width = textFieldRight.width = 192.5; //(180*2+25)/2
			textFieldLeft.height = textFieldRight.height = 230;

			addChild(textFieldLeft);
			addChild(textFieldRight);

		}

		public function setFreePlaces(places:int) {
			var textFormat:TextFormat = new TextFormat();
			textFormat.color = '0xffffff';
			textFormat.font = 'Myriad Pro';
			textFormat.size = 21;
			textFormat.leading = 10;

			var textFieldLeft:TextField = new TextField();
			var textFieldRight:TextField = new TextField();

			textFieldLeft.text = "Anzahl der aktuell verfügbaren Plätze:";
			textFieldLeft.wordWrap = true;
			textFieldRight.appendText("\n" + places);
			textFieldLeft.mouseEnabled = textFieldRight.mouseEnabled = false;

			textFieldLeft.setTextFormat(textFormat);
			textFieldRight.setTextFormat(textFormat);

			textFieldLeft.x = 30;
			textFieldRight.x = 235;
			textFieldLeft.y = textFieldRight.y = 435;

			textFieldLeft.width = textFieldRight.width = 192.5; //(180*2+25)/2
			textFieldLeft.height = textFieldRight.height = 230;

			addChild(textFieldLeft);
			addChild(textFieldRight);
		}

		/*
		 * Overide some setters and getters
		 */
		public override function set width(w:Number):void {
			_shapeWidth = w;
		}

		public override function get width():Number {
			return _shapeWidth;
		}

		public override function set height(h:Number):void {
			_shapeHeight = h;
		}

		public override function get height():Number {
			return _shapeHeight;
		}
	}
}