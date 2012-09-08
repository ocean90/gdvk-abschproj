package views.main {

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	import utils.Grid;

	import views.View;
	import views.Views;

	import widgets.BigButton;

	import views.overlays.WlanOverlay;

	public class InfrastructurePage extends View {

		private var map:BigButton;
		private var wlan:BigButton;

		public function InfrastructurePage() {
			wlan = new BigButton(Grid.COLUMN_1, 231, 'blue');
			wlan.setIcon(new WlanIcon(), -30, -10);
			wlan.addEventListener(MouseEvent.CLICK, function(e:Event) {
				Main.CONTENT.showOverlay(new WlanOverlay());
			});

			map = new BigButton(Grid.COLUMN_3, 231, 'red');
			map.setIcon(new LocationIcon(), -20, -50);
			map.addEventListener(MouseEvent.CLICK, function(e:Event) {
				Main.CONTENT.pushView(Views.Map);
			});
			/*
			timetable = new BigButton(Grid.COLUMN_5, 231, 'blue');
			timetable.setIcon(new TimetableIcon(), -20, -35);
			timetable.addEventListener(MouseEvent.CLICK, function(e:Event) {
				Main.CONTENT.pushView(Views.Timetable);
			});

			workshops = new BigButton(Grid.COLUMN_3, 441, 'purple');
			workshops.setIcon(new WorkshopsIcon(), -20, -40);
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
			catering.setIcon(new CateringIcon(), -20, -20)

			infrastructure = new BigButton(Grid.COLUMN_3, 651, 'brown');
			infrastructure.setIcon(new InfrastructureIcon(), -20, -60)

			help = new BigButton(Grid.COLUMN_5, 651);
			help.setIcon(new HelpIcon(), -40, -30)
			help.addEventListener(MouseEvent.CLICK, function(e:Event) {
				Main.CONTENT.showOverlay(new HelpOverlay());
			});
			*/
			update();

			addChild(map);
			addChild(wlan);
		}

		public override function update() {
			if (Main.LANGUAGE == 'DE') {
				Main.HEADER.setText('Infrastruktur');

				map.setText('Lageplan');
				wlan.setText('WLAN');
			} else if (Main.LANGUAGE == 'EN') {
				Main.HEADER.setText('Infrastructur');

				map.setText('Map');
				wlan.setText('WLAN');
			}
		}
	}

}
