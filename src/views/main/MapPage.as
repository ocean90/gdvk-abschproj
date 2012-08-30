package views.main {

	import flash.display.Sprite;
	import flash.geom.Point;

	import utils.Colors;
	import utils.Grid;

	import views.View;
	import widgets.TextLabel;
	import com.greensock.easing.Back;
	import com.greensock.TweenLite;

	public class MapPage extends View {
		private var mainEntryPosition:Point = new Point(400, 150);
		private var otherEntryPositions:Array = new Array();
		private var currentPosition:Point = new Point(470, 175);
		private var userSeatPosition:Point = new Point(200, 20);
		private var userSeatPositionFloor = 2; // 0 = EG
		private var infoPointPositions:Array = new Array();
		private var workshopPositions:Array = new Array();
		
		private var mainEntryPositionLabel:TextLabel;
		private var otherEntryPositionLabel:TextLabel;
		private var currentPositionLabel:TextLabel;
		private var userSeatPositionLabel:TextLabel;
		private var infoPointPositionLabel:TextLabel;
		private var workshopsLabel:TextLabel;
		
		private var _building:Array;
		private var _house:Sprite;

		public function MapPage() {
			
			infoPointPositions.push(new Point(20, 90));
			infoPointPositions.push(new Point(500, 20));
			infoPointPositions.push(new Point(420, 120));
			infoPointPositions.push(new Point(480, 120));
			infoPointPositions.push(new Point(420, 190));
			infoPointPositions.push(new Point(800, 290));
			infoPointPositions.push(new Point(830, 290));
			
			otherEntryPositions.push(new Point(0, 50));
			otherEntryPositions.push(new Point(600, 50));
			otherEntryPositions.push(new Point(300, 0));
			otherEntryPositions.push(new Point(250, 100));
			otherEntryPositions.push(new Point(500, 150));
			otherEntryPositions.push(new Point(800, 250));
			
			workshopPositions.push(new Point(300, 20));
			workshopPositions.push(new Point(350, 20));
			workshopPositions.push(new Point(700, 220));
			
			var lineHeight:int = 40;
			var posY:int = 260;
			
			mainEntryPositionLabel = createLegendLabel(posY += lineHeight);
			mainEntryPositionLabel.graphics.lineStyle(2, 0x000000);
			mainEntryPositionLabel.graphics.beginFill(0xffffff);
			mainEntryPositionLabel.graphics.drawRect(0, 11, 25, 25);
			mainEntryPositionLabel.graphics.endFill();
			
			otherEntryPositionLabel = createLegendLabel(posY += lineHeight);
			otherEntryPositionLabel.graphics.lineStyle(2, 0x000000);
			otherEntryPositionLabel.graphics.beginFill(0xffffff);
			otherEntryPositionLabel.graphics.drawRect(4, 17, 15, 15);
			otherEntryPositionLabel.graphics.endFill();
			
			currentPositionLabel = createLegendLabel(posY += lineHeight);
			currentPositionLabel.graphics.beginFill(Colors.getColor('red'));
			currentPositionLabel.graphics.drawCircle(12, 24, 12);
			currentPositionLabel.graphics.endFill();
			
			userSeatPositionLabel = createLegendLabel(posY += lineHeight);
			userSeatPositionLabel.graphics.beginFill(Colors.getColor('blue'));
			userSeatPositionLabel.graphics.drawCircle(12, 24, 12);
			userSeatPositionLabel.graphics.endFill();
			
			infoPointPositionLabel = createLegendLabel(posY += lineHeight);
			infoPointPositionLabel.graphics.beginFill(Colors.getColor('orange'));
			infoPointPositionLabel.graphics.drawCircle(12, 24, 12);
			infoPointPositionLabel.graphics.endFill();
			
			workshopsLabel = createLegendLabel(posY += lineHeight);
			workshopsLabel.graphics.beginFill(Colors.getColor('purple'));
			workshopsLabel.graphics.drawCircle(12, 24, 12);
			workshopsLabel.graphics.endFill();
		}
		
		private function createLegendLabel(posY:int):TextLabel {
			var label:TextLabel = new TextLabel();
			label.x = Grid.COLUMN_1;
			label.y = posY;
			label.shapeWidth = Grid.SPAN_2;
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
			var color:* = 'orange';
			for (var floorNumber:int = 0; floorNumber < 4; floorNumber++) {
				_building[floorNumber] = buildStory(color, floorNumber);
				//color = Colors.getLightColor(color);
				
				_building[floorNumber].x = 350 + floorNumber * 0;
				_building[floorNumber].y = 700 - floorNumber * 120;
				_building[floorNumber].rotation = -20;
				_building[floorNumber].scaleX = 0.8;
				_building[floorNumber].scaleY = 0.8;
				_building[floorNumber].rotationX = -45;
				_building[floorNumber].rotationY = -25;
				//_building[floorNumber].rotationZ = -25;

				_house.addChild(_building[floorNumber]);
			}
		}

		public function buildStory(color:*, floorNumber:int):Sprite {
			var i:int;
			var story:Sprite = new Sprite();
			
			//
			// #####   <- 1
			//    #    <- 2
			//   ##### <- 3
			
			story.graphics.beginFill(Colors.getLightColor(color), 0.3);
			story.graphics.lineStyle(2, 0x000000);
			story.graphics.drawRect(0, 0, 600, 100); // 1
			story.graphics.drawRect(350, 200, 500, 100); // 3
			story.graphics.drawRect(400, 100, 100, 100); // 2
			story.graphics.endFill();
			
			story.graphics.lineStyle(4, Colors.getLightColor(color));
			story.graphics.moveTo(400 + 3, 100);
			story.graphics.lineTo(500 - 3, 100);
			story.graphics.moveTo(400 + 3, 200);
			story.graphics.lineTo(500 - 3, 200);
			
			// mainEntryPosition
			if (mainEntryPosition && floorNumber == 0) {
				story.graphics.lineStyle(2, 0x000000);
				story.graphics.beginFill(0xffffff);
				story.graphics.drawRect(mainEntryPosition.x - 12, mainEntryPosition.y - 12, 25, 25);
				story.graphics.endFill();
			}
			
			// otherEntryPositions
			for (i = 0; i < otherEntryPositions.length; i++) {
				var otherEntryPosition:Point = otherEntryPositions[i];
				if ((floorNumber == 0 && i == 3) || (floorNumber == 1 && i != 3)) {
					story.graphics.lineStyle(2, 0x000000);
					story.graphics.beginFill(0xffffff);
					story.graphics.drawRect(otherEntryPosition.x - 7, otherEntryPosition.y - 7, 15, 15);
					story.graphics.endFill();
				}
			}
			
			// currentPosition
			if (currentPosition && floorNumber == 1) {
				story.graphics.lineStyle(2, 0x000000);
				story.graphics.beginFill(Colors.getColor('red'));
				story.graphics.drawCircle(currentPosition.x - 5, currentPosition.y - 5, 12);
				story.graphics.endFill();
			}
			
			// userSeatPosition
			if (userSeatPosition && floorNumber == userSeatPositionFloor) {
				story.graphics.lineStyle(2, 0x000000);
				story.graphics.beginFill(Colors.getColor('blue'));
				story.graphics.drawCircle(userSeatPosition.x - 5, userSeatPosition.y - 5, 12);
				story.graphics.endFill();
			}
			
			// infoPointPositions
			for (i = 0; i < infoPointPositions.length; i++) {
				if (floorNumber == 1) {
					var infoPointPosition:Point = infoPointPositions[i];
					story.graphics.lineStyle(2, 0x000000);
					story.graphics.beginFill(Colors.getColor('orange'));
					story.graphics.drawCircle(infoPointPosition.x - 5, infoPointPosition.y - 5, 12);
					story.graphics.endFill();
				}
			}

			// workshopPositions
			for (i = 0; i < workshopPositions.length; i++) {
				if ((floorNumber == 3 && i <= 1) || (floorNumber == 0 && i > 1)) {
					var workshopPosition:Point = workshopPositions[i];
					story.graphics.lineStyle(2, 0x000000);
					story.graphics.beginFill(Colors.getColor('purple'));
					story.graphics.drawCircle(workshopPosition.x - 5, workshopPosition.y - 5, 12);
					story.graphics.endFill();
				}
			}

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
				
				showLegendLabel(mainEntryPositionLabel, 'Haupteingang', delayTime += addDelay);
				showLegendLabel(otherEntryPositionLabel, 'Weitere Eingänge', delayTime += addDelay);
				showLegendLabel(currentPositionLabel, 'Aktuelle Position', delayTime += addDelay);
				showLegendLabel(userSeatPositionLabel, 'Ihr Sitzplatz', delayTime += addDelay);
				showLegendLabel(infoPointPositionLabel, 'Informationspunkt', delayTime += addDelay);
				showLegendLabel(workshopsLabel, 'Workshops', delayTime += addDelay);
			} else if (Main.LANGUAGE == 'EN') {
				Main.HEADER.setText('Map');
				Main.HEADER.addHeadline('Legend', 200, 0.8);
				
				showLegendLabel(mainEntryPositionLabel, 'Main entry', delayTime += addDelay);
				showLegendLabel(otherEntryPositionLabel, 'Other entry points', delayTime += addDelay);
				showLegendLabel(currentPositionLabel, 'Your current position', delayTime += addDelay);
				showLegendLabel(userSeatPositionLabel, 'Your seat', delayTime += addDelay);
				showLegendLabel(infoPointPositionLabel, 'Information point', delayTime += addDelay);
				showLegendLabel(workshopsLabel, 'Workshops', delayTime += addDelay);
			}
			
			_house = new Sprite();
			buildHouse();
			addChild(_house);
			
			for (var floorNumber:int = 0; floorNumber < _building.length; floorNumber++) {
				var originalY:int = _building[floorNumber].y;
				_building[floorNumber].alpha = 0;
				_building[floorNumber].y = 0;
				
				TweenLite.to(_building[floorNumber], 1.2, {
							 autoAlpha: 1,
					y: originalY,
					delay: 2.0 + 0.4 * floorNumber,
					ease:Back.easeOut
				});
			}
			
			if (Main.LANGUAGE == 'DE') {
				addDelay = 0.1;
				
				addLabel(Grid.COLUMN_2, 150, 'Workshop-Raum 3.204', delayTime += addDelay);
				addLine(350, 190, 555, 286, delayTime += addDelay);
				addLabel(Grid.COLUMN_3, 150, 'Workshop-Raum 3.208', delayTime += addDelay);
				addLine(535, 190, 591, 275, delayTime += addDelay);
				addLabel(Grid.COLUMN_6 - 15, 580, 'Workshop-Raum 1.114', delayTime += addDelay);
				addLine(Grid.COLUMN_6 - 20, 605, 900, 614, delayTime += addDelay);
			}
		}
		
		private function addLabel(posX:int, posY:int, text:String, delay:Number) {
			var label:TextLabel = new TextLabel();
			label.x = posX;
			label.y = posY;
			label.shapeWidth = Grid.SPAN_2;
			label.shapeHeight = 50;
			label.setText(text);
			addChild(label);
			
			label.alpha = 0;
			TweenLite.to(label, 1.2, { autoAlpha: 1, delay: delay });
		}
		
		private function addLine(startX:int, startY:int, endX:int, endY:int, delay:Number) {
			var sprite:Sprite = new Sprite();
			sprite.graphics.lineStyle(2, 0x000000);
			sprite.graphics.moveTo(startX, startY);
			sprite.graphics.lineTo(endX, endY);
			sprite.graphics.endFill();
			addChild(sprite);
			
			sprite.alpha = 0;
			TweenLite.to(sprite, 1.2, { autoAlpha: 1, delay: delay });
		}
	}

}
