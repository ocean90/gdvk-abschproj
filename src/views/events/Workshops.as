package views.events {

	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	import utils.Grid;

	import views.View;
	import views.Views;
	import views.events.CoverFlow;
	import views.events.CoverFlows;

	import widgets.SmallButton;

	public class Workshops extends View {
		var workshops:CoverFlows = new CoverFlows();

		public function Workshops() {
			registerWorkshops();
			addChild(workshops);

			update();

			// @TODO mit Pfeilen ersetzen
			var prev:SmallButton = new SmallButton('prev', 'lightgray');
			var next:SmallButton = new SmallButton('next', 'lightgray');

			prev.x = Grid.COLUMN_1;
			prev.y = 400;
			prev.shapeWidth = Grid.SPAN_1;
			prev.shapeHeight = Grid.BUTTON_BAR_HEIGHT;
			prev.addEventListener(MouseEvent.CLICK, prevWorkshop);
			addChild(prev);

			next.x = Grid.COLUMN_6;
			next.y = 400;
			next.shapeWidth = Grid.SPAN_1;
			next.shapeHeight = Grid.BUTTON_BAR_HEIGHT;
			next.addEventListener(MouseEvent.CLICK, nextWorkshop);
			addChild(next);
		}

		public override function update() {
			var i:int,
				j:int,
				current:int = workshops.currentCover;

			if (current > 0) {
				j = workshops.length();
				for (i = 0; i < current; i++) {
					j--;
					var w = workshops.getCover(i);
					w.x = Grid.COLUMN_2 - 25 - 100 - j * 100;
					w.y = Grid.SPAN_1 + 50 + 100
					w.scaleX = 0.6;
					w.scaleY = 0.6;
					w.alpha = 0.9;

					w.rotationY = -30;
				}
			}

			if (current < workshops.length()) {
				j = 0;
				for (i = current + 1; i < workshops.length(); i++) {
					j++;
					var w = workshops.getCover(i);
					workshops.setChildIndex(w, workshops.numChildren - i);
					w.x = Grid.COLUMN_2 - 25 + 300 + j * 100;
					w.y = Grid.SPAN_1 + 50 + 100
					w.scaleX = 0.6;
					w.scaleY = 0.6;
					w.alpha = 0.9;

					w.rotationY = 30;
				}
			}

			workshops.setChildIndex(workshops.getCover(current), workshops.numChildren - 1);
			workshops.getCover(current).x = Grid.COLUMN_2 - 25;
			workshops.getCover(current).y = Grid.SPAN_1 + 50;
			workshops.getCover(current).scaleX = 1;
			workshops.getCover(current).scaleY = 1;
			workshops.getCover(current).rotationY = 0;
			workshops.getCover(current).alpha = 1;
		}

		public function nextWorkshop(e:Event) {
			workshops.nextCover();
			update();
		}

		public function prevWorkshop(e:Event) {
			workshops.prevCover();
			update();
		}

		public function registerWorkshops() {
			// Relaxed Hand Technique
			var cover:CoverFlow = new CoverFlow('red');
			cover.setImage('../resources/noten.png');
			cover.setTitle('Relaxed Hand Technique');
			cover.setDesc('Moeller-Technik nach Sanford A. Moeller und Jim Chapin, Stickcontrol, Rudiments; Koordination und Unabhängigkeit, Rhythmische Konzepte, Notenlesen, Musikalische Stilistiken von Blues über Jazz und Rock bis zu neuesten Stilen, Groove-und Timing-Übungen, Fill-ins und Solospiel, Improvisation, Begleitung.');
			cover.setAuthor('Maren Reus');

			var infos = new Array();
			infos["Ort"] = "Halle 43, Raum S2";
			infos["Uhrzeit"] = "10:00 & 14:00 Uhr";
			infos["Zielgruppe"] = "Fortgeschrittene";
			infos["Preis"] = "kostenlos";
			cover.setInfos(infos);

			cover.setFreePlaces(50); // @TODO dynamisch

			workshops.pushCover(cover);

			// Fluide Grooves
			var cover:CoverFlow = new CoverFlow('green');
			cover.setImage('../resources/noten.png');
			cover.setTitle('Fluide Grooves');
			cover.setDesc('Puls, Stilrichtungen & Grooves, Rudiments, Moeller- Technik, melodiöse Gestaltung von Stickings, Stimmen der Trommeln und Soundideen, das Set als Soloinstrument');
			cover.setAuthor('Pascal Hettig');

			var infos = new Array();
			infos["Ort"] = "FH, Raum 3.112";
			infos["Uhrzeit"] = "10:00 & 14:00 Uhr";
			infos["Zielgruppe"] = "nicht für Anfänger geeignet";
			infos["Preis"] = "kostenlos";
			cover.setInfos(infos);

			cover.setFreePlaces(50); // @TODO dynamisch

			workshops.pushCover(cover);

			// Drum Tuning & Setup
			var cover:CoverFlow = new CoverFlow('yellow');
			cover.setImage('../resources/noten.png');
			cover.setTitle('Drum Tuning & Setup');
			cover.setDesc('Groove, Sound und Spielfreude sind mit die wichtigsten Faktoren, wenn es ans Musikmachen geht. Dies erreicht man jedoch nicht allein durch eine ausgefeilte Spieltechnik – es bedarf auch eines gut klingenden und auf den Spieler eingestimmten Instruments.');
			cover.setAuthor('Ramon Delt, Silvia Lopez');

			var infos = new Array();
			infos["Ort"] = "FH, Raum 2.111";
			infos["Uhrzeit"] = "10:00 & 14:00 Uhr";
			infos["Zielgruppe"] = "alle";
			infos["Preis"] = "kostenlos";
			cover.setInfos(infos);

			cover.setFreePlaces(50); // @TODO dynamisch

			workshops.pushCover(cover);

			// Body Percussion
			var cover:CoverFlow = new CoverFlow();
			cover.setImage('../resources/noten.png');
			cover.setTitle('Body Percussion');
			cover.setDesc('Rhythmus ist der gemeinsame Nenner der Musik der verschiedenen Kulturen. Jede Art des gemeinsamen Musizierens erfordert gewisse rhythmische Grundfertigkeiten. Bodypercussion ist eine Methode des praktischen Erlernens und Erlangens rhythmischer Sicherheit. Es ermöglicht die Erkundung von Rhythmen ohne den Einsatz von Instrumenten und Notenmaterial.');
			cover.setAuthor('Brune Belchatjut-Halmarkat, Johannes Schwer');

			var infos = new Array();
			infos["Ort"] = "FH, Raum 1.400";
			infos["Uhrzeit"] = "10:00 & 14:00 Uhr";
			infos["Zielgruppe"] = "alle";
			infos["Preis"] = "kostenlos";
			cover.setInfos(infos);

			cover.setFreePlaces(80); // @TODO dynamisch

			workshops.pushCover(cover);
		}


	}

}
