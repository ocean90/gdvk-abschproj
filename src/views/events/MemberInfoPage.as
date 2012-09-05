package views.events {

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	import com.greensock.TweenLite;
	import com.greensock.easing.Quint;

	import utils.Grid;

	import views.View;

	import widgets.RoundButton;
	import widgets.SmallButton;
	import widgets.TextLabel;
	import flash.text.TextFormatAlign;
	import utils.Colors;
	import com.greensock.easing.Back;

	public class MemberInfoPage extends View {

		private var recordMarker:TextLabel;
		private var memberLabel:TextLabel;
		private var memberMarker:Sprite;
		private var checkedInLabel:TextLabel;
		private var checkedInMarker:Sprite;

		public function MemberInfoPage() {
			
			recordMarker = new TextLabel();
			recordMarker.x = Grid.COLUMN_4;
			recordMarker.y = 205;
			recordMarker.shapeWidth = Grid.SPAN_3;
			recordMarker.shapeHeight = 50;
			recordMarker.textFormat.align = TextFormatAlign.CENTER;
			
			recordMarker.graphics.lineStyle(2, 0xdd2222);
			recordMarker.graphics.moveTo(recordMarker.shapeWidth * 0.5 - 10, 40);
			recordMarker.graphics.lineTo(recordMarker.shapeWidth * 0.5 + 10, 40);
			
			recordMarker.graphics.moveTo(recordMarker.shapeWidth * 0.5, 40);
			recordMarker.graphics.lineTo(recordMarker.shapeWidth * 0.5, 600);
			
			memberLabel = new TextLabel();
			memberLabel.x = Grid.COLUMN_1;
			memberLabel.y = 270;
			memberLabel.shapeWidth = Grid.SPAN_4;
			memberLabel.shapeHeight = 50;
			
			memberMarker = new Sprite();
			
			checkedInLabel = new TextLabel();
			checkedInLabel.x = Grid.COLUMN_1;
			checkedInLabel.y = 570;
			checkedInLabel.shapeWidth = Grid.SPAN_4;
			checkedInLabel.shapeHeight = 50;
			
			checkedInMarker = new Sprite();
			
		}

		public override function update() {
			while (numChildren > 0) {
				removeChildAt(0);
			}
			
			var memberCount:int = 743;
			var checkedInCount:int = 176;
			var markerCount:int = 700;
			
			addChild(memberLabel);
			addChild(memberMarker);
			addChild(checkedInLabel);
			addChild(checkedInMarker);
			// record marker overlays the other both markers
			addChild(recordMarker);
			
			var lineHeight:int = 40;
			var posY:int;
			
			var delayTime:Number = 0.8;
			var addDelay:Number = 0.6;
			
			if (Main.LANGUAGE == 'DE') {
				Main.HEADER.setText('Teilnehmer');
				
				recordMarker.alpha = 0;
				recordMarker.setText('Weltrekordmarke (' + markerCount + ')');
				
				memberLabel.alpha = 0;
				memberLabel.x = -Grid.SPAN_1;
				memberLabel.setText('Es haben sich ' + memberCount + ' Teilnehmer registriert!');
				
				checkedInLabel.alpha = 0;
				checkedInLabel.x = -Grid.SPAN_1;
				checkedInLabel.setText('Und es sind bereits ' + checkedInCount + ' Teilnehmer eingecheckt!');
				
				Main.HEADER.addHeadline('Registriert', 200, delayTime += addDelay);
				TweenLite.to(memberLabel, 1.2, { x: Grid.COLUMN_1, autoAlpha: 1.0, delay: delayTime += addDelay, ease:Back.easeOut });
				Main.HEADER.addHeadline('Bereits eingecheckt', 500, delayTime += addDelay);
				TweenLite.to(checkedInLabel, 1.2, { x: Grid.COLUMN_1, autoAlpha: 1.0, delay: delayTime += addDelay, ease:Back.easeOut });
			} else if (Main.LANGUAGE == 'EN') {
				Main.HEADER.setText('Members');
				
				recordMarker.alpha = 0;
				recordMarker.setText('Worldrecord-mark (' + markerCount + ')');
				
				memberLabel.alpha = 0;
				memberLabel.x = -Grid.SPAN_1;
				memberLabel.setText('There are ' + memberCount + ' members who registered!');
				
				checkedInLabel.alpha = 0;
				checkedInLabel.x = -Grid.SPAN_1;
				checkedInLabel.setText('And there are already ' + checkedInCount + ' members who checked-in!');
				
				Main.HEADER.addHeadline('Registered', 200, delayTime += addDelay);
				TweenLite.to(memberLabel, 1.2, { x: Grid.COLUMN_1, autoAlpha: 1.0, delay: delayTime += addDelay, ease:Back.easeOut });
				Main.HEADER.addHeadline('Already checked in', 500, delayTime += addDelay);
				TweenLite.to(checkedInLabel, 1.2, { x: Grid.COLUMN_1, autoAlpha: 1.0, delay: delayTime += addDelay, ease:Back.easeOut });
			}
			
			delayTime += 1.0;
			
			var markerPos:Number = recordMarker.x + recordMarker.shapeWidth * 0.5;
			var memberLength:Number = markerPos * memberCount / markerCount;
			var checkedInLength:Number = markerPos * checkedInCount / markerCount;
			
			memberMarker.x = -Main.STAGE.stageWidth;
			memberMarker.y = 350;
			memberMarker.alpha = 0;
			memberMarker.graphics.clear();
			memberMarker.graphics.beginFill(Colors.getColor('green')); // green like the index colored button members!
			memberMarker.graphics.drawRoundRect(0, 0, memberLength + 200, 50, 10);
			memberMarker.graphics.endFill();
			
			TweenLite.to(memberMarker, 0.2, { autoAlpha: 1.0, delay: delayTime, onComplete: function() {
				TweenLite.to(memberMarker, 8, { x: -200, ease:Quint.easeOut });
			} });
			
			checkedInMarker.x = -Main.STAGE.stageWidth;
			checkedInMarker.y = 650;
			checkedInMarker.alpha = 0;
			checkedInMarker.graphics.clear();
			checkedInMarker.graphics.beginFill(Colors.getColor('orange')); // orange like the index colored button check-in!
			checkedInMarker.graphics.drawRoundRect(0, 0, checkedInLength + 200, 50, 10);
			checkedInMarker.graphics.endFill();
			
			TweenLite.to(checkedInMarker, 0.2, { autoAlpha: 1.0, delay: delayTime, onComplete: function() {
				TweenLite.to(checkedInMarker, 4, { x: -200, delay: 1, ease:Quint.easeOut });
			} });
			
			TweenLite.to(recordMarker, 0.8, { autoAlpha: 1.0, delay: delayTime });
		}
	}
}
