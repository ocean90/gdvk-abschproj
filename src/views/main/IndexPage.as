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
		private var map:BigButton;
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
			userdata.maxIconSizeWidth = 284;
			userdata.setIcon(new CheckinIcon(), -20, -60);
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

			map = new BigButton(Grid.COLUMN_3, 231, 'red');
			map.setIcon(new LocationIcon(), -20, -60);
			map.addEventListener(MouseEvent.CLICK, function(e:Event) {
				Main.CONTENT.pushView(Views.Map);
			});

			timetable = new BigButton(Grid.COLUMN_5, 231, 'blue');
			timetable.setIcon(new TimetableIcon(), -20, -70);
			timetable.addEventListener(MouseEvent.CLICK, function(e:Event) {
				Main.CONTENT.pushView(Views.Timetable);
			});

			workshops = new BigButton(Grid.COLUMN_3, 441, 'purple');
			workshops.setIcon(new WorkshopsIcon(), -20, -70);
			workshops.addEventListener(MouseEvent.CLICK, function(e:Event) {
				Main.CONTENT.pushView(Views.Workshops);
			});

			members = new BigButton(Grid.COLUMN_5, 441, 'green');
			members.maxIconSizeWidth = 200;
			members.setIcon(new MembersIcon(), -20, -10);
			members.addEventListener(MouseEvent.CLICK, function(e:Event) {
				Main.CONTENT.pushView(Views.MemberInfo);
			});

			catering = new BigButton(Grid.COLUMN_1, 651, 'moos')
			catering.setIcon(new CateringIcon(), -20, -10)

			infrastructure = new BigButton(Grid.COLUMN_3, 651, 'brown');
			infrastructure.setIcon(new InfrastructureIcon(), -20, -60)

			help = new BigButton(Grid.COLUMN_5, 651);
			help.setIcon(new HelpIcon(), -40, -30)
			help.addEventListener(MouseEvent.CLICK, function(e:Event) {
				Main.CONTENT.showOverlay(new HelpOverlay());
			});

			update();

			addChild(userdata);
			addChild(map);
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
				map.setText('Lageplan');
				timetable.setText('Zeitplan');
				workshops.setText('Workshops');
				members.setText('Teilnehmer');
				catering.setText('Verpflegung');
				infrastructure.setText('Infrastruktur');
				help.setText('Vor-Ort-Hilfe');
			} else if (Main.LANGUAGE == 'EN') {
				Main.HEADER.setText('Now it gets loud!');

				userdata.setText(Main.USER.isLoggedIn() ? 'My data' : 'Check-in');
				map.setText('Map');
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
