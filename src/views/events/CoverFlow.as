package views.events {
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	import utils.Colors;
	import utils.Grid;

	public class CoverFlow extends Sprite {
		public var color:String;
		public var shapeWidth:int;
		public var shapeHeight:int;

		public function CoverFlow(color:String = 'blue') {
			this.color = color;
			this.shapeWidth = 870
			this.shapeHeight = 600

			this.paintBox();

			this.x = Grid.COLUMN_2 - 25;
			this.y = Grid.SPAN_1 + 50;
		}

		public function paintBox() {
			graphics.beginFill(Colors.getColor(this.color));
			graphics.drawRect(0, 0, this.shapeWidth, this.shapeHeight);
			graphics.endFill();
		}

		public function setImage(path:String) {
			var loader:Loader = new Loader();
			loader.load(new URLRequest(path));
			loader.x = 25;
			loader.y = 25
			addChild(loader);

			var overlay:MovieClip = new MovieClip();
			overlay.graphics.beginFill(Colors.getColor(this.color));
			overlay.graphics.drawRect(205, 25, this.shapeWidth-205, 140);
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
			textField.x = 230;
			textField.y = 45;
			textField.width = this.shapeWidth-205;
			textField.height = 55;
			textField.setTextFormat(textFormat);

			addChild(textField);
		}

		public function setDesc(desc:String) {
			var textFormat:TextFormat = new TextFormat();
			textFormat.color = '0x000000';
			textFormat.font = 'Georgia';
			textFormat.size = 24;
			textFormat.italic = true;
			textFormat.leading = 12;

			var textField:TextField = new TextField();
			textField.mouseEnabled = false;
			textField.text = desc;
			textField.x = 435;
			textField.y = 160;
			textField.wordWrap = true;
			textField.width = this.shapeWidth-435-25;
			textField.height = this.shapeHeight - 140;
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
			textField.x = 230;
			textField.y = 45 + 55;
			textField.width = this.shapeWidth-205;
			textField.height = 25;
			textField.setTextFormat(textFormat);

			addChild(textField);
		}

		public function setInfos(data:Array) {
			var textFormat:TextFormat = new TextFormat();
			textFormat.color = '0xffffff';
			textFormat.font = 'Myriad Pro';
			textFormat.size = 24;
			textFormat.leading = 12;

			var textFieldLeft:TextField = new TextField();
			var textFieldRight:TextField = new TextField();
			textFieldLeft.multiline = textFieldRight.multiline = true;

			for (var key:String in data){
				textFieldLeft.appendText(key+":\n");
				textFieldRight.appendText(data[key]+"\n");
			}

			textFieldLeft.setTextFormat(textFormat);
			textFieldRight.setTextFormat(textFormat);

			textFieldLeft.x = 25;
			textFieldRight.x = 230;
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
			textFormat.size = 24;
			textFormat.leading = 12;

			var textFieldLeft:TextField = new TextField();
			var textFieldRight:TextField = new TextField();

			textFieldLeft.text = "Anzahl der aktuell verfügbaren Plätze";
			textFieldLeft.wordWrap = true;
			textFieldRight.appendText("\n" + places);

			textFieldLeft.setTextFormat(textFormat);
			textFieldRight.setTextFormat(textFormat);

			textFieldLeft.x = 25;
			textFieldRight.x = 230;
			textFieldLeft.y = textFieldRight.y = 435;

			textFieldLeft.width = textFieldRight.width = 192.5; //(180*2+25)/2
			textFieldLeft.height = textFieldRight.height = 230;

			addChild(textFieldLeft);
			addChild(textFieldRight);
		}
	}
}