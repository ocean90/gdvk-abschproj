package views.main {

	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	
	import utils.Grid;
	import views.View;
	
	public class TestPage extends View {

		public function TestPage() {
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
			
			textField.text = 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,';
			
			textField.text += textField.text + textField.text + textField.text + textField.text + textField.text;
			
			textField.setTextFormat(textFormat);
			
			textField.x = Grid.COLUMN_1;
			textField.y = 200;
			textField.width = Grid.SPAN_6;
			textField.height = 600;
			
			addChild(textField);
		}

	}
	
}
