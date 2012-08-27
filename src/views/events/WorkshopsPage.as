package views.events {

	import flash.events.Event;
	import flash.events.MouseEvent;

	import utils.Grid;

	import views.View;

	import widgets.Cover;
	import widgets.CoverFlow;
	import widgets.SmallButton;

	public class WorkshopsPage extends View {
		private var workshops:CoverFlow;

		public function WorkshopsPage() {
			workshops = new CoverFlow(Main.STAGE.stageWidth,Main.STAGE.stageHeight);
			addChild(workshops);

			registerWorkshops();
			workshops.layout();

			// @TODO mit Pfeilen ersetzen
			var prev:SmallButton = new SmallButton('prev', 'lightgray');
			var next:SmallButton = new SmallButton('next', 'lightgray');

			prev.x = Grid.COLUMN_1;
			prev.y = 400;
			prev.shapeWidth = Grid.SPAN_1;
			prev.shapeHeight = Grid.BUTTON_BAR_BUTTON_HEIGHT;
			prev.addEventListener(MouseEvent.CLICK, prevWorkshop);
			addChild(prev);

			next.x = Grid.COLUMN_6;
			next.y = 400;
			next.shapeWidth = Grid.SPAN_1;
			next.shapeHeight = Grid.BUTTON_BAR_BUTTON_HEIGHT;
			next.addEventListener(MouseEvent.CLICK, nextWorkshop);
			addChild(next);
		}

		public function nextWorkshop(e:Event) {
			workshops.next();
			workshops.layout();
		}

		public function prevWorkshop(e:Event) {
			workshops.prev();
			workshops.layout();
		}

		public function registerWorkshops() {
			var infos:Array;
			var cover:Cover;

			// Relaxed Hand Technique
			cover = new Cover('green');
			cover.setImage(new Noten());
			cover.setTitle('Relaxed Hand Technique');
			cover.setDesc('Moeller-Technik nach Sanford A. Moeller und Jim Chapin, Stickcontrol, Rudiments; Koordination und Unabhängigkeit, Rhythmische Konzepte, Notenlesen, Musikalische Stilistiken von Blues über Jazz und Rock bis zu neuesten Stilen, Groove-und Timing-Übungen, Fill-ins und Solospiel, Improvisation, Begleitung.');
			cover.setAuthor('Maren Reus');

			infos = [];
			infos["Ort"] = "Halle 43, Raum S2";
			infos["Uhrzeit"] = "10:00 & 14:00 Uhr";
			infos["Zielgruppe"] = "Fortgeschrittene";
			infos["Preis"] = "kostenlos";
			cover.setInfos(infos);

			cover.setFreePlaces(50); // @TODO dynamisch

			workshops.push(cover);

			// Fluide Grooves
			cover = new Cover('red');
			cover.setImage(new Noten());
			cover.setTitle('Fluide Grooves');
			cover.setDesc('Puls, Stilrichtungen & Grooves, Rudiments, Moeller- Technik, melodiöse Gestaltung von Stickings, Stimmen der Trommeln und Soundideen, das Set als Soloinstrument');
			cover.setAuthor('Pascal Hettig');

			infos = [];
			infos["Ort"] = "FH, Raum 3.112";
			infos["Uhrzeit"] = "10:00 & 14:00 Uhr";
			infos["Zielgruppe"] = "nicht für Anfänger geeignet";
			infos["Preis"] = "kostenlos";
			cover.setInfos(infos);

			cover.setFreePlaces(50); // @TODO dynamisch

			workshops.push(cover);

			// Drum Tuning & Setup
			cover = new Cover('yellow');
			cover.setImage(new Noten());
			cover.setTitle('Drum Tuning & Setup');
			cover.setDesc('Groove, Sound und Spielfreude sind mit die wichtigsten Faktoren, wenn es ans Musikmachen geht. Dies erreicht man jedoch nicht allein durch eine ausgefeilte Spieltechnik – es bedarf auch eines gut klingenden und auf den Spieler eingestimmten Instruments.');
			cover.setAuthor('Ramon Delt, Silvia Lopez');

			infos = [];
			infos["Ort"] = "FH, Raum 2.111";
			infos["Uhrzeit"] = "10:00 & 14:00 Uhr";
			infos["Zielgruppe"] = "alle";
			infos["Preis"] = "kostenlos";
			cover.setInfos(infos);

			cover.setFreePlaces(50); // @TODO dynamisch

			workshops.push(cover);

			// Body Percussion
			cover = new Cover();
			cover.setImage(new Noten());
			cover.setTitle('Body Percussion');
			cover.setDesc('Rhythmus ist der gemeinsame Nenner der Musik der verschiedenen Kulturen. Jede Art des gemeinsamen Musizierens erfordert gewisse rhythmische Grundfertigkeiten. Bodypercussion ist eine Methode des praktischen Erlernens und Erlangens rhythmischer Sicherheit. Es ermöglicht die Erkundung von Rhythmen ohne den Einsatz von Instrumenten und Notenmaterial.');
			cover.setAuthor('Brune Belchatjut-Halmarkat, Johannes Schwer');

			infos = [];
			infos["Ort"] = "FH, Raum 1.400";
			infos["Uhrzeit"] = "10:00 & 14:00 Uhr";
			infos["Zielgruppe"] = "alle";
			infos["Preis"] = "kostenlos";
			cover.setInfos(infos);

			cover.setFreePlaces(80); // @TODO dynamisch

			workshops.push(cover);

		}





	}

}
