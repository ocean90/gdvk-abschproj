package views.main {

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	import utils.Grid;

	import views.View;
	import views.Views;
	import views.overlays.RepairOverlay;
	import views.overlays.WlanOverlay;
	import views.overlays.FirstHelpOverlay;

	import widgets.BigButton;

	public class InfrastructurePage extends View {

		private var map:BigButton;
		private var wlan:BigButton;
		private var repair:BigButton;
		private var firsthelp:BigButton;

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

			repair = new BigButton(Grid.COLUMN_5, 231, 'cyan');
			repair.setIcon(new RepairIcon(), -20, -35);
			repair.addEventListener(MouseEvent.CLICK, function(e:Event) {
				Main.CONTENT.showOverlay(new RepairOverlay());
			});

			firsthelp = new BigButton(Grid.COLUMN_1, 441, 'orange');
			firsthelp.setIcon(new FirstHelpIcon(), -20, -40);
			firsthelp.addEventListener(MouseEvent.CLICK, function(e:Event) {
				Main.CONTENT.showOverlay(new FirstHelpOverlay());
			});
/*
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
			addChild(repair);
			addChild(firsthelp);
		}

		public override function update():void {
			if (Main.LANGUAGE == 'DE') {
				Main.HEADER.setText('Infrastruktur');

				map.setText('Lageplan');
				wlan.setText('WLAN');
				repair.setText('Reparatur');
				firsthelp.setText('Erste Hilfe');

			} else if (Main.LANGUAGE == 'EN') {
				Main.HEADER.setText('Infrastructur');

				map.setText('Map');
				wlan.setText('WLAN');
				repair.setText('Repair');
				firsthelp.setText('First help');

			}
		}
	}

}
