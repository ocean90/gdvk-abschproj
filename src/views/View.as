package views {
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	/**
	 * Ausgelagert falls wir doch irgendwas MovieClip oder was anderes anleiten müssen.
	 */
	public class View extends Sprite {
		public function View() {
			// disable overflow for this view. for the background image we use here height * 2
			scrollRect = new Rectangle(0, 0, Main.STAGE.stageWidth, Main.STAGE.stageHeight * 2);
		}
		
		/**
		 * Wird auf allen Views im ViewStack aufgerufen wenn diese im View Stack hinzugefügt werden.
		 */
		public function update() {}
		/**
		 * Wird auf allen Views aufgerufen wenn die View von vorher wieder angezeigt wird.
		 * Wird für die Zurück funktion z.b. auf der MemberInfoPage verwendet um die Header
		 * nochmal zu setzen ohne alle Animationen nochmal durchzulaufen!
		 *
		 * Gibt true zurück wenn die Anzeige danach ok ist und die Update methode NICHT mehr
		 * aufgerufen werden soll.
		 */
		public function onResume():Boolean {
			return false;
		}
	}	
}
