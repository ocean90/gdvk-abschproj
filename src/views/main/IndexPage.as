package views.main {

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	import utils.Grid;

	import views.View;
	import views.Views;
	import views.events.TimetablePage;
	import views.events.WorkshopsPage;
	import views.overlays.HelpOverlay;
	import views.overlays.CheckInOverlay;

	import widgets.BigButton;

	public class IndexPage extends View {

		private var userdata:BigButton;
		private var plan:BigButton;
		private var timetable:BigButton;
		private var workshops:BigButton;
		private var members:BigButton;
		private var catering:BigButton;
		private var infrastructure:BigButton;
		private var help:BigButton;

		public function IndexPage() {
			userdata = new BigButton(Grid.COLUMN_1, 231, 'orange');
			userdata.shapeWidth = Grid.SPAN_2;
			userdata.shapeHeight = Grid.SPAN_2;
			userdata.addEventListener(MouseEvent.CLICK, function(e:Event) {
				if (Main.USER.isLoggedIn()) {
					Main.CONTENT.pushView(Views.UserData);
				} else {
					var checkIn:CheckInOverlay = new CheckInOverlay();
					checkIn.afterFinishCallback = function(e:Event) {
						trace('check in done. load userdata now.');
						Main.CONTENT.pushView(Views.UserData);
					};
					Main.CONTENT.showOverlay(checkIn);
				}
			});

			plan = new BigButton(Grid.COLUMN_3, 231, 'red');
			plan.addEventListener(MouseEvent.CLICK, function(e:Event) {
				Main.CONTENT.pushView(Views.Map);
			});

			timetable = new BigButton(Grid.COLUMN_5, 231, 'blue');
			timetable.addEventListener(MouseEvent.CLICK, function(e:Event) {
				Main.CONTENT.pushView(Views.Timetable);
			});

			workshops = new BigButton(Grid.COLUMN_3, 441, 'purple');
			workshops.addEventListener(MouseEvent.CLICK, function(e:Event) {
				Main.CONTENT.pushView(Views.Workshops);
			});

			members = new BigButton(Grid.COLUMN_5, 441, 'green');

			catering = new BigButton(Grid.COLUMN_1, 651, 'moos')

			infrastructure = new BigButton(Grid.COLUMN_3, 651, 'brown');

			help = new BigButton(Grid.COLUMN_5, 651);
			help.addEventListener(MouseEvent.CLICK, function(e:Event) {
				Main.CONTENT.showOverlay(new HelpOverlay());
			});

			update();

			addChild(userdata);
			addChild(plan);
			addChild(timetable);
			addChild(workshops);
			addChild(members);
			addChild(catering);
			addChild(infrastructure);
			addChild(help);
		}

		public override function update() {
			if (Main.LANGUAGE == 'DE') {
				Main.HEADER.setText('Jetzt wird\'s laut!');

				userdata.setText(Main.USER.isLoggedIn() ? 'Meine Daten' : 'Check-In');
				plan.setText('Lageplan');
				timetable.setText('Zeitplan');
				workshops.setText('Workshops');
				members.setText('Teilnehmer');
				catering.setText('Verpflegung');
				infrastructure.setText('Infrastruktur');
				help.setText('Vor-Ort-Hilfe');
			} else if (Main.LANGUAGE == 'EN') {
				Main.HEADER.setText('Now it gets loud!');

				userdata.setText(Main.USER.isLoggedIn() ? 'My data' : 'Check-in');
				plan.setText('Map');
				timetable.setText('Timetable');
				workshops.setText('Workshops');
				members.setText('Members');
				catering.setText('Catering');
				infrastructure.setText('Infrastructure');
				help.setText('Local support');
			}
		}
	}

}
