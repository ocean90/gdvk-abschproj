package views.main {
	
	import views.View;

	public class Plan extends View {

		public function IndexPage() {
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
