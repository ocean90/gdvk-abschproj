package widgets {

	import utils.Colors;
	import utils.Grid;

	public class BigButton extends AbstractButton {
		public function BigButton(posX:int = 0, posY:int = 0, color:String = 'blue') {
			this.color = color;

			this.x = posX;
			this.y = posY;
			this.shapeWidth = Grid.SPAN_2;
			this.shapeHeight = Grid.SPAN_1;

			this.defaultShadowSize = 8;
			this.pushedShadowSize = 4;
			this.maxIconSizeWidth = 250;

			textFormat.size = 30;

			setText('call setText!');
		}
	}

}
