package views {
	import flash.display.Sprite;
	
	/**
	 * Ausgelagert falls wir doch irgendwas MovieClip oder was anderes anleiten müssen.
	 */
	public class View extends Sprite {
		
		/**
		 * Wird auf allen Views im ViewStack aufgerufen wenn die Sprache geändert wird.
		 * Kann von dennen implementiert werden welche die Texte ändern können.
		 */
		public function update() {
		}
		
	}	
}
