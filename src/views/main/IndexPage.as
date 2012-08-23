package views.main {

	import flash.events.Event;
	import flash.events.MouseEvent;

	import utils.Grid;

	import views.View;
	import views.Views;

	import widgets.BigButton;

	public class IndexPage extends View {

		public function IndexPage() {
			var checkin:BigButton = new BigButton(Grid.COLUMN_1, 231, 'yellow');
			checkin.shapeWidth = Grid.SPAN_2;
			checkin.shapeHeight = Grid.SPAN_2;
			checkin.setText('Check-In');
			addChild(checkin);

			var plan:BigButton = new BigButton(Grid.COLUMN_3, 231, 'red');
			plan.setText('Lageplan');
			addChild(plan);

			var timetable:BigButton = new BigButton(Grid.COLUMN_5, 231, 'blue');
			timetable.setText('Zeitplan');
			addChild(timetable);

			var workshops:BigButton = new BigButton(Grid.COLUMN_3, 441, 'yellow');
			workshops.setText('Workshops');
			workshops.addEventListener(MouseEvent.CLICK, openEvent1);
			addChild(workshops);

			var members:BigButton = new BigButton(Grid.COLUMN_5, 441, 'green');
			members.setText('Teilnehmer');
			addChild(members);

			var catering:BigButton = new BigButton(Grid.COLUMN_1, 651, 'purple')
			catering.setText('Verpflegung');
			addChild(catering);

			var infrastructure:BigButton = new BigButton(Grid.COLUMN_3, 651, 'brown');
			infrastructure.setText('Infrastruktur');
			addChild(infrastructure);

			var help:BigButton = new BigButton(Grid.COLUMN_5, 651);
			help.setText('Vor-Ort-Hilfe');
			addChild(help);
		}

		public function openEvent1(e:Event) {
			Main.CONTENT.pushView(Views.Event1);
		}

		public function openEvent2(e:Event) {
			Main.CONTENT.pushView(Views.Event2);
		}
	}

}
