package views.events {

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	import utils.Grid;

	import views.View;

	import widgets.Cover;
	import widgets.CoverFlow;
	import widgets.RoundButton;
	import widgets.SmallButton;

	public class WorkshopsPage extends View {

		private var workshops:CoverFlow;

		public function WorkshopsPage() {
			workshops = new CoverFlow(Main.STAGE.stageWidth, Main.STAGE.stageHeight);
			addChild(workshops);

			registerWorkshops();
		}

		// TODO
		private var TODO:Boolean = false;

		public override function update() {
			if (Main.LANGUAGE == 'DE') {
				Main.HEADER.setText('Workshops');
			} else if (Main.LANGUAGE == 'EN') {
				Main.HEADER.setText('Workshops');
			}

			Main.CONTENT.resetButtonBar();
			Main.FOOTER.animateFooter(Grid.COLUMN_3 - Grid.COLUMN_PADDING);

			// TODO irgendwoher den status nehmen
			if (TODO) {
				Main.CONTENT.showCancelButton(Main.LANGUAGE == 'DE' ? 'Von Workshop Abmelden' : 'Unsubscribe from workshop', function(e:Event) {
					trace('abmelden vom workshop');
					TODO = !TODO;
					update();
				});
				Main.CONTENT.cancelButton.x = Grid.COLUMN_5;
				Main.CONTENT.cancelButton.shapeWidth = Grid.SPAN_2;
				Main.CONTENT.cancelButton.update();
			} else {
				Main.CONTENT.showSubmitButton(Main.LANGUAGE == 'DE' ? 'An Workshop Teilnehmen' : 'Subscribe to workshop', function(e:Event) {
					trace('anmelden zum workshop');
					TODO = !TODO;
					update();
				});
				Main.CONTENT.submitButton.x = Grid.COLUMN_5;
				Main.CONTENT.submitButton.shapeWidth = Grid.SPAN_2;
				Main.CONTENT.submitButton.update();
			}
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
			cover = new Cover('orange');
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
