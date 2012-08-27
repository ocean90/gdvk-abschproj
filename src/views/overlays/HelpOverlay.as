package views.overlays {
	import flash.display.Sprite;

	import utils.Colors;

	public class HelpOverlay extends Sprite {
		public function HelpOverlay() {
			//var _content:Sprite = new Sprite();
			//_content.graphics.beginFill(Colors.getColor('blue'));
			//_content.graphics.drawRect(0,0,2000,900);
			//_content.graphics.endFill();
			this.name = 'test';
			this.graphics.beginFill(0xffffff);
			this.graphics.drawRect(0, 0, 200, 200);
			this.graphics.endFill();
			//addChild(_content);
		}
	}
}