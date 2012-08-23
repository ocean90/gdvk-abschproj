package views.main {

	import flash.events.Event;
	import flash.events.MouseEvent;

	import utils.Grid;

	import views.View;
	import views.Views;

	import widgets.BigButton;

	public class IndexPage extends View {

		private var checkin:BigButton;
		private var plan:BigButton;
		private var timetable:BigButton;
		private var workshops:BigButton;
		private var members:BigButton;
		private var catering:BigButton;
		private var infrastructure:BigButton;
		private var help:BigButton;

		public function IndexPage() {
			checkin = new BigButton(Grid.COLUMN_1, 231, 'yellow');
			checkin.shapeWidth = Grid.SPAN_2;
			checkin.shapeHeight = Grid.SPAN_2;
			addChild(checkin);

			plan = new BigButton(Grid.COLUMN_3, 231, 'red');
			addChild(plan);

			timetable = new BigButton(Grid.COLUMN_5, 231, 'blue');
			addChild(timetable);

			workshops = new BigButton(Grid.COLUMN_3, 441, 'yellow');
			workshops.addEventListener(MouseEvent.CLICK, openEvent1);
			addChild(workshops);

			members = new BigButton(Grid.COLUMN_5, 441, 'green');
			addChild(members);

			catering = new BigButton(Grid.COLUMN_1, 651, 'purple')
			addChild(catering);

			infrastructure = new BigButton(Grid.COLUMN_3, 651, 'brown');
			addChild(infrastructure);

			help = new BigButton(Grid.COLUMN_5, 651);
			addChild(help);
			
			update();
		}

		public override function update() {
			if (Main.LANGUAGE == 'DE') {
				checkin.setText('Check-In');
				plan.setText('Lageplan');
				timetable.setText('Zeitplan');
				workshops.setText('Workshops');
				members.setText('Teilnehmer');
				catering.setText('Verpflegung');
				infrastructure.setText('Infrastruktur');
				help.setText('Vor-Ort-Hilfe');
			} else if (Main.LANGUAGE == 'EN') {
				checkin.setText('Check-in');
				plan.setText('Plan');
				timetable.setText('Timetable');
				workshops.setText('Workshops');
				members.setText('Members');
				catering.setText('Catering');
				infrastructure.setText('Infrastructure');
				help.setText('Local support');
			}
		}

		public function openEvent1(e:Event) {
			Main.CONTENT.pushView(Views.Event1);
		}

		public function openEvent2(e:Event) {
			Main.CONTENT.pushView(Views.Event2);
		}
	}

}
