package views.main {

	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	
	import utils.Grid;
	import views.View;
	
	public class Profil extends View {

		public function Profil() {
			var textFormat:TextFormat = new TextFormat();
			textFormat.color = '0x000000';
			textFormat.font = 'Myriad Pro';
			textFormat.size = 30;
			
			var textField:TextField = new TextField();
			textField.mouseEnabled = false;
			textField.multiline = true;
			textField.wordWrap = true;
			textField.background = true;
			textField.border = true;
			
			textField.text = 'Mein Profil';
			
			textField.setTextFormat(textFormat);
			
			textField.x = Grid.COLUMN_1;
			textField.y = 200;
			textField.width = Grid.SPAN_6;
			textField.height = 600;
			
			addChild(textField);
		}

	}
	
}
