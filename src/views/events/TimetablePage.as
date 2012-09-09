package views.events {
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	import com.greensock.TweenLite;
	import com.greensock.easing.Back;
	import com.greensock.easing.Quint;

	import utils.Grid;
	import utils.Colors;

	import views.View;
	import views.Views;
	import widgets.InverseText;

	public class TimetablePage extends View {
		var table:Array;
		var _container:Sprite;
		var textFormat:TextFormat;
		var time:TextField;
		var title:TextField;

		var friday:Sprite;
		var saturday:Sprite;
		var sundayHeadline:InverseText;
		var sunday:Sprite;

		public function TimetablePage() {
			_container = new Sprite();
			addChild(_container);

			fillTable();
			layout();
		}

		public function layout():void {
			var i:int;

			// Friday
			friday = new Sprite();
			friday.x = 0;
			friday.y = 240;
			_container.addChild(friday);
			textFormat = new TextFormat();
			for ( i = 0; i < table['friday'].length; i++ ) {
				textFormat = new TextFormat();
				textFormat.color = 0x000000;
				textFormat.font = 'Myriad Pro';
				textFormat.size = 20;

				time = new TextField();
				time.mouseEnabled = false;
				time.text = _dateHelper(table['friday'][i]);
				time.x = Grid.COLUMN_1;
				time.y = (i+1) * 30;
				time.width = Grid.SPAN_1;
				time.setTextFormat(textFormat);

				friday.addChild(time);

				title = new TextField();
				title.mouseEnabled = false;
				title.text = table['friday'][i].title;
				title.x = Grid.COLUMN_2;
				title.y = (i+1) * 30;
				title.width = Grid.SPAN_2;
				title.setTextFormat(textFormat);
				friday.addChild(title);
			}

			// Sunday
			sunday = new Sprite();
			sunday.x = 0;
			sunday.y = 240;
			_container.addChild(sunday);
			textFormat = new TextFormat();
			for ( i = 0; i < table['sunday'].length; i++ ) {
				textFormat = new TextFormat();
				textFormat.color = 0x000000;
				textFormat.font = 'Myriad Pro';
				textFormat.size = 20;

				time = new TextField();
				time.mouseEnabled = false;
				time.text = _dateHelper(table['sunday'][i]);
				time.x = Grid.COLUMN_4;
				time.y = (i+1) * 30;
				time.width = Grid.SPAN_1;
				time.setTextFormat(textFormat);

				sunday.addChild(time);

				title = new TextField();
				title.mouseEnabled = false;
				title.text = table['sunday'][i].title;
				title.x = Grid.COLUMN_5;
				title.y = (i+1) * 30;
				title.width = Grid.SPAN_2;
				title.setTextFormat(textFormat);
				sunday.addChild(title);
			}

			// Saturday
			saturday = new Sprite();
			saturday.x = 0;
			saturday.y = 510;
			_container.addChild(saturday);
			textFormat = new TextFormat();
			for ( i = 0; i < table['saturday'].length; i++ ) {
				textFormat = new TextFormat();
				textFormat.color = 0x000000;
				textFormat.font = 'Myriad Pro';
				textFormat.size = 20;
				if ( table['saturday'][i].red )
					textFormat.color = Colors.getColor('red');

				time = new TextField();
				time.mouseEnabled = false;
				time.text = _dateHelper(table['saturday'][i]);
				time.x = Grid.COLUMN_1;
				time.y = (i+1) * 30;
				time.width = Grid.SPAN_1;
				time.setTextFormat(textFormat);

				saturday.addChild(time);

				title = new TextField();
				title.mouseEnabled = false;
				title.text = table['saturday'][i].title;
				title.x = Grid.COLUMN_2;
				title.y = (i+1) * 30;
				title.width = Grid.SPAN_5;
				title.setTextFormat(textFormat);
				saturday.addChild(title);
			}
		}

		public function _dateHelper(obj:Object):String {
			if ( obj.begin && obj.end )
				return obj.begin + ' - ' + obj.end + ' Uhr';
			else if ( obj.begin )
				return 'ab ' + obj.begin + ' Uhr';
			else if ( obj.end )
				return 'bis ' + obj.end + ' Uhr';

			return '';
		}

		public override function update():void {
			if (Main.LANGUAGE == 'DE') {
				Main.HEADER.setText('Zeitplan');
			} else if (Main.LANGUAGE == 'EN') {
				Main.HEADER.setText('Timetable');
			}

			var delayTime:Number = 0.6;
			var addDelay:Number = 0.6;

			Main.HEADER.addHeadline('Freitag', 200, delayTime += addDelay);
			friday.alpha = 0;
			friday.x -= Grid.SPAN_2;
			TweenLite.to(friday, 0.8, { x: friday.x + Grid.SPAN_2, autoAlpha: 1, delay: delayTime += addDelay, ease:Back.easeOut });

			Main.HEADER.addHeadline('Samstag', 470, delayTime += addDelay);
			saturday.alpha = 0;
			saturday.x -= Grid.SPAN_2;
			TweenLite.to(saturday, 0.8, { x: saturday.x + Grid.SPAN_2, autoAlpha: 1, delay: delayTime += addDelay, ease:Back.easeOut });

			if (sundayHeadline == null) {
				sundayHeadline = createRightHeadline('Sonntag');
				sundayHeadline.y = 200;
				addChild(sundayHeadline);
			}
			sundayHeadline.alpha = 0;
			sundayHeadline.x += Grid.COLUMN_4 - Grid.COLUMN_PADDING + Grid.SPAN_2; // add extra space for the animation!
			addChild(sundayHeadline);
			TweenLite.to(sundayHeadline, 0.8, { x: Grid.COLUMN_4 - Grid.COLUMN_PADDING, autoAlpha: 1, delay: delayTime += addDelay, ease:Quint.easeOut });

			sunday.alpha = 0;
			sunday.x += Grid.SPAN_2;
			TweenLite.to(sunday, 0.8, { x: sunday.x - Grid.SPAN_2, autoAlpha: 1, delay: delayTime += addDelay, ease:Quint.easeOut });

		}

		public function fillTable():void {
			table = new Array();
			if (Main.LANGUAGE == 'DE') {
				table['friday'] = new Array();
				table['friday'][0] = { 'begin': '15:00', 'end': '18:00', 'title': 'Check-in'};
				table['friday'][1] = { 'begin': '18:00', 'end': '19:00', 'title': 'Begrüßung Frühankömmlinge'};
				table['friday'][2] = {                                   'title': 'Drum Clinic mit Bob Ziegler, Halle 43'};
				table['friday'][3] = { 'begin': '19:00', 'end': '20:00', 'title': 'Abendessen, Mensa'};
				table['friday'][4] = { 'begin': '20:30', 'title': 'Konzert mit den Brubakers, Halle 43', 'link': function () {
					Main.CONTENT.pushView(Views.Workshops);
				}};
				table['friday'][5] = { 'begin': '23:00', 'title': 'Party, Halle 43'};

				table['saturday'] = new Array();
				table['saturday'][0] = { 'begin': '07:00', 'end': '11:00', 'title': 'Frühstück, Mensa'};
				table['saturday'][1] = { 'begin': '10:00', 'end': '11:30', 'title': 'Workshops', 'link': function () {
					Main.CONTENT.pushView(Views.Workshops);
				}};
				table['saturday'][2] = { 'begin': '12:00', 'end': '13:30', 'title': 'Begrüßung der neuen Teilnehmer, Weltrekord Probe', 'red':1};
				table['saturday'][3] = { 'begin': '13:30', 'end': '15:00', 'title': 'Mittagessen, Mensa'};
				table['saturday'][4] = { 'begin': '14:00', 'end': '15:30', 'title': 'Workshops', 'link': function () {
					Main.CONTENT.pushView(Views.Workshops);
				}};
				table['saturday'][5] = { 'begin': '16:00', 'end': '17:00', 'title': 'Weltrekord Probe', 'red':1};
				table['saturday'][6] = { 'begin': '17:30', 'end': '18:30', 'title': 'Drum Clinic mit Ramon Trabant, Halle 43', 'link': function () {
					Main.CONTENT.pushView(Views.Workshops);
				}};
				table['saturday'][7] = { 'begin': '18:00', 'end': '19:30', 'title': 'Abendessen, Mensa'};
				table['saturday'][8] = { 'begin': '20:00', 'end': '21:00', 'title': 'Weltrekordversuch', 'red':1};
				table['saturday'][9] = { 'begin': '21:30', 'end': '23:30', 'title': 'Konzert mit Fathers Finest & Mike Radky, Halle 43', 'link': function () {
					Main.CONTENT.pushView(Views.Workshops);
				}};
				table['saturday'][10] = { 'begin': '23:00', 'title': 'Party, Halle 43'};

				table['sunday'] = new Array();
				table['sunday'][0] = { 'begin': '07:00', 'end': '11:00', 'title': 'Frühstück, Mensa'};
				table['sunday'][1] = { 'end': '14:00', 'title': 'Check-out'};
			} else if (Main.LANGUAGE == 'EN') {
				table['friday'] = new Array();
				table['friday'][0] = { 'begin': '15:00', 'end': '18:00', 'title': 'Check-in'};
				table['friday'][1] = { 'begin': '18:00', 'end': '19:00', 'title': 'Welcome arrivals'};
				table['friday'][2] = {                                   'title': 'Drum Clinic with Bob Ziegler, Halle 43'};
				table['friday'][3] = { 'begin': '19:00', 'end': '20:00', 'title': 'Supper, Mensa'};
				table['friday'][4] = { 'begin': '20:30', 'title': 'Concert with the Brubakers, Halle 43', 'link': function () {
					Main.CONTENT.pushView(Views.Workshops);
				}};
				table['friday'][5] = { 'begin': '23:00', 'title': 'Party, Halle 43'};

				table['saturday'] = new Array();
				table['saturday'][0] = { 'begin': '07:00', 'end': '11:00', 'title': 'Breakfast, Mensa'};
				table['saturday'][1] = { 'begin': '10:00', 'end': '11:30', 'title': 'Workshops', 'link': function () {
					Main.CONTENT.pushView(Views.Workshops);
				}};
				table['saturday'][2] = { 'begin': '12:00', 'end': '13:30', 'title': 'Welcome arrivals, World record test', 'red':1};
				table['saturday'][3] = { 'begin': '13:30', 'end': '15:00', 'title': 'Lunch, Mensa'};
				table['saturday'][4] = { 'begin': '14:00', 'end': '15:30', 'title': 'Workshops', 'link': function () {
					Main.CONTENT.pushView(Views.Workshops);
				}};
				table['saturday'][5] = { 'begin': '16:00', 'end': '17:00', 'title': 'World record test', 'red':1};
				table['saturday'][6] = { 'begin': '17:30', 'end': '18:30', 'title': 'Drum Clinic with Ramon Trabant, Halle 43', 'link': function () {
					Main.CONTENT.pushView(Views.Workshops);
				}};
				table['saturday'][7] = { 'begin': '18:00', 'end': '19:30', 'title': 'Supper, Mensa'};
				table['saturday'][8] = { 'begin': '20:00', 'end': '21:00', 'title': 'World record', 'red':1};
				table['saturday'][9] = { 'begin': '21:30', 'end': '23:30', 'title': 'Konzert with Fathers Finest & Mike Radky, Halle 43', 'link': function () {
					Main.CONTENT.pushView(Views.Workshops);
				}};
				table['saturday'][10] = { 'begin': '23:00', 'title': 'Party, Halle 43'};

				table['sunday'] = new Array();
				table['sunday'][0] = { 'begin': '07:00', 'end': '11:00', 'title': 'Breakfast, Mensa'};
				table['sunday'][1] = { 'end': '14:00', 'title': 'Check-out'};
			}
		}

		private function createRightHeadline(text:String):InverseText {
			var headline:InverseText = new InverseText();
			headline.textFormat.size = 30;
			headline.textField.x = Grid.COLUMN_PADDING;
			headline.setText(text);

			headline.shapeWidth = headline.textField.textWidth + Grid.COLUMN_PADDING * 2;
			headline.shapeHeight = 50;
			headline.update();

			return headline;
		}

	}
}