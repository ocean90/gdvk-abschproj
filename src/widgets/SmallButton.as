package widgets {

	import utils.Colors;
	import utils.Grid;

	/**
	 * Implementiert einen kleinen Button, Breite entspricht einer
	 * Spalte. Text kann direkt per Aufruf definiert werden.
	 */
	public class SmallButton extends AbstractButton {
		public function SmallButton(text:String, color:String = 'blue') {
			this.color = color;

			this.x = 0;
			this.y = 0;
			this.shapeWidth = Grid.SPAN_1;
			this.shapeHeight = Grid.BUTTON_BAR_BUTTON_HEIGHT;

			this.defaultShadowSize = 4;
			this.pushedShadowSize = 2;

			textFormat.size = 20;

			setText(text);
		}
	}

}
