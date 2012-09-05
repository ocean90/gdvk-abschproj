package views {
	import flash.display.Sprite;
	
	/**
	 * Ausgelagert falls wir doch irgendwas MovieClip oder was anderes anleiten müssen.
	 */
	public class View extends Sprite {
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
