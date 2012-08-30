package views.main {

	import flash.display.Sprite;

	import utils.Colors;
	import utils.Grid;

	import views.View;
	import widgets.TextLabel;
	import com.greensock.easing.Back;
	import com.greensock.TweenLite;

	public class MapPage extends View {
		private var currentPositionLabel:TextLabel;
		private var userSeatPositionLabel:TextLabel;
		private var infoPointPositionLabel:TextLabel;
		
		private var _building:Array;
		private var _house:Sprite;

		public function MapPage() {
			var lineHeight:int = 40;
			var posY:int = 260;
			
			currentPositionLabel = createLegendLabel(posY += lineHeight);
			currentPositionLabel.graphics.beginFill(Colors.getColor('red'));
			currentPositionLabel.graphics.drawCircle(12, 14, 12);
			currentPositionLabel.graphics.endFill();
			
			userSeatPositionLabel = createLegendLabel(posY += lineHeight);
			userSeatPositionLabel.graphics.beginFill(Colors.getColor('blue'));
			userSeatPositionLabel.graphics.drawCircle(12, 14, 12);
			userSeatPositionLabel.graphics.endFill();
			
			infoPointPositionLabel = createLegendLabel(posY += lineHeight);
			infoPointPositionLabel.graphics.beginFill(Colors.getColor('orange'));
			infoPointPositionLabel.graphics.drawCircle(12, 14, 12);
			infoPointPositionLabel.graphics.endFill();
		}
		
		private function createLegendLabel(posY:int):TextLabel {
			var label:TextLabel = new TextLabel();
			label.x = Grid.COLUMN_1;
			label.y = posY;
			label.shapeWidth = Grid.SPAN_1;
			label.shapeHeight = 50;
			return label;
		}
		
		private function showLegendLabel(label:TextLabel, labelText:String, delay:Number) {
			label.alpha = 0;
			label.x = -Grid.SPAN_2;
			label.setText('        ' + labelText);
			addChild(label);
			TweenLite.to(label, 0.8, { x: Grid.COLUMN_1, autoAlpha: 1, delay: delay, ease:Back.easeOut });
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

			story.graphics.beginFill(Colors.getLightColor(color));
			story.graphics.drawRect(0, 0, 600, 100);
			story.graphics.drawRect(400, 100, 100, 100);
			story.graphics.drawRect(350, 200, 500, 100);
			story.graphics.endFill();

			story.graphics.beginFill(Colors.getColor('red'));
			story.graphics.drawCircle(0, 0, 10);
			//story.rotationX = -80;
			//story.rotationY =  -10;
//			story.rotationZ = 45;

			return story;
		}

		public override function update() {
			while (numChildren > 0) {
				removeChildAt(0);
			}
			
			var delayTime:Number = 0.6;
			var addDelay:Number = 0.6;
			
			if (Main.LANGUAGE == 'DE') {
				Main.HEADER.setText('Lageplan');
				Main.HEADER.addHeadline('Legende', 200, 0.8);
				
				showLegendLabel(currentPositionLabel, 'Aktuelle Position', delayTime += addDelay);
				showLegendLabel(userSeatPositionLabel, 'Ihr Sitzplatz', delayTime += addDelay);
				showLegendLabel(infoPointPositionLabel, 'Informationspunkt', delayTime += addDelay);
				
			} else if (Main.LANGUAGE == 'EN') {
				Main.HEADER.setText('Map');
				Main.HEADER.addHeadline('Legend', 200, 0.8);
				
				showLegendLabel(currentPositionLabel, 'Your current position', delayTime += addDelay);
				showLegendLabel(userSeatPositionLabel, 'Your seat', delayTime += addDelay);
				showLegendLabel(infoPointPositionLabel, 'Information point', delayTime += addDelay);
				
			}
			
			_house = new Sprite;
			buildHouse()
			
			addChild(_house);
		}
		
	}

}
