package views.events {

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFormatAlign;

	import com.greensock.TweenLite;
	import com.greensock.easing.Quint;
	import com.greensock.easing.Back;

	import utils.Grid;

	import views.View;

	import widgets.SmallButton;
	import widgets.TextLabel;
	import utils.Colors;
	import views.Views;

	public class MemberInfoPage extends View {

		private var memberCount:int = 743;
		private var checkedInCount:int = 176;
		private var markerCount:int = 700;

		private var recordMarker:TextLabel;

		private var memberLabel:TextLabel;
		private var memberMarker:Sprite;
		private var memberButton:SmallButton;

		private var checkedInLabel:TextLabel;
		private var checkedInMarker:Sprite;
		private var checkedInButton:SmallButton;

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

			memberButton = new SmallButton('', 'green'); // green like the index colored button members!
			memberButton.x = Grid.COLUMN_6;
			memberButton.y = 295;
			memberButton.shapeWidth = Grid.SPAN_1;
			memberButton.shapeHeight = Grid.SPAN_1 * 0.95;
			memberButton.addEventListener(MouseEvent.CLICK, function(e:Event) {
				Views.MemberList.updateConfiguration(Colors.getColor('green'), memberCount);
				Main.CONTENT.pushView(Views.MemberList);
			});

			checkedInLabel = new TextLabel();
			checkedInLabel.x = Grid.COLUMN_1;
			checkedInLabel.y = 570;
			checkedInLabel.shapeWidth = Grid.SPAN_4;
			checkedInLabel.shapeHeight = 50;

			checkedInMarker = new Sprite();

			checkedInButton = new SmallButton('', 'orange'); // orange like the index colored button check-in!
			checkedInButton.x = Grid.COLUMN_6;
			checkedInButton.y = 595;
			checkedInButton.shapeWidth = Grid.SPAN_1;
			checkedInButton.shapeHeight = Grid.SPAN_1 * 0.95;
			checkedInButton.addEventListener(MouseEvent.CLICK, function(e:Event) {
				Views.MemberList.updateConfiguration(Colors.getColor('orange'), checkedInCount);
				Main.CONTENT.pushView(Views.MemberList);
			});

		}

		public override function onResume():Boolean {
			if (Main.LANGUAGE == 'DE') {
				Main.HEADER.setText('Teilnehmer');
				Main.HEADER.addHeadline('Registriert', 200);
				Main.HEADER.addHeadline('Bereits eingecheckt', 500);
			} else if (Main.LANGUAGE == 'EN') {
				Main.HEADER.setText('Members');
				Main.HEADER.addHeadline('Registered', 200);
				Main.HEADER.addHeadline('Already checked in', 500);
			}
			return true;
		}

		public override function update():void {
			while (numChildren > 0) {
				removeChildAt(0);
			}

			addChild(memberLabel);
			addChild(memberMarker);
			addChild(memberButton);

			addChild(checkedInLabel);
			addChild(checkedInMarker);
			addChild(checkedInButton);

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
				memberButton.alpha = 0;
				memberButton.setText('Teilnehmerliste\nansehen');

				checkedInLabel.alpha = 0;
				checkedInLabel.x = -Grid.SPAN_1;
				checkedInLabel.setText('Und es sind bereits ' + checkedInCount + ' Teilnehmer eingecheckt!');
				checkedInButton.alpha = 0;
				checkedInButton.setText('Checked-In-Liste\nansehen');

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
				memberButton.alpha = 0;
				memberButton.setText('View member\nlist');

				checkedInLabel.alpha = 0;
				checkedInLabel.x = -Grid.SPAN_1;
				checkedInLabel.setText('And there are already ' + checkedInCount + ' members who checked-in!');
				checkedInButton.alpha = 0;
				checkedInButton.setText('View checked-in\nlist');

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
				TweenLite.to(memberMarker, 4, { x: -200, ease:Quint.easeOut });
				TweenLite.to(memberButton, 0.8, { autoAlpha: 1.0, delay: 3.0 });
			}});

			checkedInMarker.x = -Main.STAGE.stageWidth;
			checkedInMarker.y = 650;
			checkedInMarker.alpha = 0;
			checkedInMarker.graphics.clear();
			checkedInMarker.graphics.beginFill(Colors.getColor('orange')); // orange like the index colored button check-in!
			checkedInMarker.graphics.drawRoundRect(0, 0, checkedInLength + 200, 50, 10);
			checkedInMarker.graphics.endFill();

			TweenLite.to(checkedInMarker, 0.2, { autoAlpha: 1.0, delay: delayTime, onComplete: function() {
				TweenLite.to(checkedInMarker, 4, { x: -200, ease:Quint.easeOut });
				TweenLite.to(checkedInButton, 0.8, { autoAlpha: 1.0, delay: 3.2 });
			}});

			TweenLite.to(recordMarker, 0.8, { autoAlpha: 1.0, delay: delayTime });

		}
	}
}
