package views.events {
	import views.View;

	public class Timetable extends View {
		var table:Array;
		public function Timetable() {
			update();

			fillTable()

			trace(table['friday'][0].begin);

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
			table['saturday'][0] = { 'begin': '07:00', 'end': '11:00', 'title': 'Frühstück, Mensa'};
			table['saturday'][1] = { 'end': '14:00', 'title': 'Check-out'};


		}
	}
}