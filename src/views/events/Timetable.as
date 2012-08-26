package views.events {
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	import utils.Grid;

	import views.View;

	public class Timetable extends View {
		var table:Array;
		var _container:Sprite;

		public function Timetable() {
			update();
			_container = new Sprite();
			addChild(_container);

			fillTable()
			layout()
		}

		public function layout() {
			// Friday
			var friday:Sprite = new Sprite();
			friday.x = Grid.COLUMN_1;
			friday.y = 200;
			_container.addChild(friday);
			for ( var i:int = 0; i < table['friday'].length; i++ ) {
				var textFormat:TextFormat = new TextFormat();
				textFormat.color = 0x000000;
				textFormat.font = 'Myriad Pro';
				textFormat.size = 18;

				var time:TextField = new TextField();
				time.mouseEnabled = false;
				time.text = _dateHelper(table['friday'][i]);

				time.width = 200;
				time.y = i * 25;
				time.setTextFormat(textFormat);

				friday.addChild(time);

				var title:TextField = new TextField();
				title.mouseEnabled = false;
				title.text = table['friday'][i].title;
				title.x = 150;
				title.width = Grid.SPAN_3;
				title.y = i * 25;
				title.setTextFormat(textFormat);
				friday.addChild(title);
			}

			// Sunday
			var sunday:Sprite = new Sprite();
			sunday.x = Grid.COLUMN_5;
			sunday.y = 200;
			_container.addChild(sunday);
			for ( var i:int = 0; i < table['sunday'].length; i++ ) {
				var textFormat:TextFormat = new TextFormat();
				textFormat.color = 0x000000;
				textFormat.font = 'Myriad Pro';
				textFormat.size = 18;

				var time:TextField = new TextField();
				time.mouseEnabled = false;
				time.text = _dateHelper(table['sunday'][i]);

				time.width = 200;;
				time.y = i * 25;
				time.setTextFormat(textFormat);

				sunday.addChild(time);

				var title:TextField = new TextField();
				title.mouseEnabled = false;
				title.text = table['sunday'][i].title;
				title.x = 150;
				title.width = Grid.SPAN_3;
				title.y = i * 25;
				title.setTextFormat(textFormat);
				sunday.addChild(title);
			}

			// Saturday
			var saturday:Sprite = new Sprite();
			saturday.x = Grid.COLUMN_1;
			saturday.y = 400;
			_container.addChild(saturday);
			for ( var i:int = 0; i < table['saturday'].length; i++ ) {
				var textFormat:TextFormat = new TextFormat();
				textFormat.color = 0x000000;
				textFormat.font = 'Myriad Pro';
				textFormat.size = 28;

				var time:TextField = new TextField();
				time.mouseEnabled = false;
				time.text = _dateHelper(table['saturday'][i]);

				time.width = 300;;
				time.y = i * 50;
				time.setTextFormat(textFormat);

				saturday.addChild(time);

				var title:TextField = new TextField();
				title.mouseEnabled = false;
				title.text = table['saturday'][i].title;
				title.x = 220;
				title.width = Grid.SPAN_6;
				title.y = i * 50;
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

		public override function update() {
			if (Main.LANGUAGE == 'DE') {
				Main.HEADER.setText('Zeitplan');
			} else if (Main.LANGUAGE == 'EN') {
				Main.HEADER.setText('Timetable');
			}
		}

		public function fillTable() {
			//if (Main.LANGUAGE == 'DE') {
			table = new Array();
			table['friday'] = new Array();
			table['friday'][0] = { 'begin': '15:00', 'end': '18:00', 'title': 'Check-in'};
			table['friday'][1] = { 'begin': '18:00', 'end': '19:00', 'title': 'Begrüßung Frühankömmlinge, Drum Clinic mit Bob Ziegler, Halle 43'};
			table['friday'][2] = { 'begin': '19:00', 'end': '20:00', 'title': 'Abendessen, Mensa'};
			table['friday'][3] = { 'begin': '20:30', 'title': 'Konzert mit den Brubakers, Halle 43', 'link':''}; // View
			table['friday'][4] = { 'begin': '23:00', 'title': 'Party, Halle 43'};

			table['saturday'] = new Array();
			table['saturday'][0] = { 'begin': '07:00', 'end': '11:00', 'title': 'Frühstück, Mensa'};
			table['saturday'][1] = { 'begin': '10:00', 'end': '11:30', 'title': 'Workshops', 'link':''}; // View
			table['saturday'][2] = { 'begin': '12:00', 'end': '13:30', 'title': 'Begrüßung der neuen Teilnehmer, Weltrekord Probe', 'red':1};
			table['saturday'][3] = { 'begin': '13:30', 'end': '15:00', 'title': 'Mittagessen, Mensa'};
			table['saturday'][4] = { 'begin': '14:00', 'end': '15:30', 'title': 'Workshops', 'link':''}; // View
			table['saturday'][5] = { 'begin': '16:00', 'end': '17:00', 'title': 'Weltrekord Probe', 'red':1};
			table['saturday'][6] = { 'begin': '17:30', 'end': '18:30', 'title': 'Drum Clinic mit Ramon Trabant, Halle 43', 'link':''}; // View
			table['saturday'][7] = { 'begin': '18:00', 'end': '19:30', 'title': 'Abendessen, Mensa'};
			table['saturday'][8] = { 'begin': '20:00', 'end': '21:00', 'title': 'Weltrekordversuch', 'red':1};
			table['saturday'][9] = { 'begin': '21:30', 'end': '23:30', 'title': 'Konzert mit Fathers Finest & Mike Radky, Halle 43', 'link':''}; // View
			table['saturday'][10] = { 'begin': '23:00', 'title': 'Party, Halle 43'};

			table['sunday'] = new Array();
			table['sunday'][0] = { 'begin': '07:00', 'end': '11:00', 'title': 'Frühstück, Mensa'};
			table['sunday'][1] = { 'end': '14:00', 'title': 'Check-out'};
		}
	}
}