package views.main {
	
	import views.View;

	public class PlanPage extends View {

		public function PlanPage() {
			update();
		}

		public override function update() {
			if (Main.LANGUAGE == 'DE') {
				Main.HEADER.setText('Lageplan');
			} else if (Main.LANGUAGE == 'EN') {
				Main.HEADER.setText('Plan');

			}
		}
	}

}
