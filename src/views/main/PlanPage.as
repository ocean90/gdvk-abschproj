package views.main {

	import flash.display.Sprite;

	import utils.Colors;

	import views.View;

	public class PlanPage extends View {
		private var _building:Array;
		private var _house:Sprite;

		public function PlanPage() {
			update();

			_house = new Sprite;
			addChild(_house);

			buildHouse()
		}

		public function buildHouse() {
			_building = new Array();
			var color:* = 'blue';
			for( var i:int = 0; i<4; i++) {
				_building[i] = getStory(color);
				color = Colors.getLightColor(color);
				_building[i].x = 200;
				_building[i].y = 600 - i * 100;
				_house.addChild(_building[i]);
			}
		}

		public function getStory(color:*):Sprite {
			var story:Sprite = new Sprite();

			story.graphics.beginFill(Colors.getColor(color));
			story.graphics.drawRect(0, 0, 600, 100);
			story.graphics.drawRect(400, 100, 100, 100);
			story.graphics.drawRect(350, 200, 500, 100);
			story.graphics.endFill();

			story.rotationX = -80;
			story.rotationY =  -10;
			story.rotationZ = -4;

			return story;
		}

		public override function update() {
			if (Main.LANGUAGE == 'DE') {
				Main.HEADER.setText('Lageplan');
			} else if (Main.LANGUAGE == 'EN') {
				Main.HEADER.setText('Plan');
			}
		}
	}

}
