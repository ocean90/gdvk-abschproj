package views.events {

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	import com.greensock.TweenLite;
	import com.greensock.easing.Quint;

	import utils.Grid;

	import views.View;
	import views.overlays.SearchOverlay;

	import widgets.Cover;
	import widgets.CoverFlow;
	import widgets.RoundButton;
	import widgets.SmallButton;
	import widgets.TextLabel;

	public class MembersPage extends View {

		private var members:CoverFlow;

		public function MembersPage() {
			members = new CoverFlow(Main.STAGE.stageWidth, Main.STAGE.stageHeight, 0xcccccc);
			addChild(members);

			registerMembers();
		}

		// TODO
		private var TODO:Boolean = false;

		public override function update() {
			if (Main.LANGUAGE == 'DE') {
				Main.HEADER.setText('Teilnehmer');
			} else if (Main.LANGUAGE == 'EN') {
				Main.HEADER.setText('Members');
			}

			Main.FOOTER.resetButtonBar();

			// TODO irgendwoher den status nehmen
			if (TODO) {
				Main.FOOTER.showCancelButton(Main.LANGUAGE == 'DE' ? 'Alle anzeigen' : 'Show all', cancelSearch);
				Main.FOOTER.cancel.x = Grid.COLUMN_6 + Grid.SPAN_2;
				Main.FOOTER.cancel.update();
				
				TweenLite.to(Main.FOOTER.cancel, 0.5, { x: Grid.COLUMN_6, ease:Quint.easeOut });
			} else {
				Main.FOOTER.showSubmitButton(Main.LANGUAGE == 'DE' ? 'Suchen' : 'Search', openSearch);
				Main.FOOTER.submit.x = Grid.COLUMN_6 + Grid.SPAN_2;
				Main.FOOTER.submit.update();
				
				TweenLite.to(Main.FOOTER.submit, 0.5, { x:Grid.COLUMN_6, ease:Quint.easeOut });
			}
			
			TweenLite.to(Main.FOOTER.background, 0.5, { x: -Main.FOOTER.background.width + Grid.COLUMN_6 - Grid.COLUMN_PADDING, ease:Quint.easeOut });
		}
		
		public function cancelSearch(e:Event) {
			TODO = !TODO;
			update();
		}

		public function openSearch(e:Event) {
			var searchOverlay:SearchOverlay = new SearchOverlay();
			searchOverlay.searchCallback = function() {
				TODO = !TODO;
				update();
			};
			
			Main.CONTENT.showOverlay(searchOverlay);
		}

		public function registerMembers() {
			var cover:Cover;
			var posY:int;
			
			for (var i = 1; i <= 16; i++) {
				cover = new Cover();
				posY = 0;
				
				addLine(cover, 'Nachname', 'Vorname', 'Stadt', 'Firma', posY += 5);
				posY += 10;
				
				for (var line = 0; line < 18; line++) {
					addLine(cover, 'Hallo ' + line, 'City', '', '', posY += 30);
				}
				
				members.push(cover);
			}
		}
		
		private function addLine(cover:Cover, lastname:String, firstname:String, city:String, company:String, posY:int) {
			var lastnameLabel:TextLabel = new TextLabel();
			lastnameLabel.x = Grid.COLUMN_1;
			lastnameLabel.y = posY;
			lastnameLabel.shapeWidth = Grid.SPAN_1;
			lastnameLabel.shapeHeight = 50;
			lastnameLabel.setText(lastname);
			
			var firstnameLabel:TextLabel = new TextLabel();
			firstnameLabel.x = Grid.COLUMN_2;
			firstnameLabel.y = posY;
			firstnameLabel.shapeWidth = Grid.SPAN_1;
			firstnameLabel.shapeHeight = 50;
			firstnameLabel.setText(firstname);
			
			var cityLabel:TextLabel = new TextLabel();
			cityLabel.x = Grid.COLUMN_3;
			cityLabel.y = posY;
			cityLabel.shapeWidth = Grid.SPAN_1;
			cityLabel.shapeHeight = 50;
			cityLabel.setText(city);
			
			var companyLabel:TextLabel = new TextLabel();
			companyLabel.x = Grid.COLUMN_4;
			companyLabel.y = posY;
			companyLabel.shapeWidth = Grid.SPAN_1;
			companyLabel.shapeHeight = 50;
			companyLabel.setText(company);
			
			cover.addChild(lastnameLabel);
			cover.addChild(firstnameLabel);
			cover.addChild(cityLabel);
			cover.addChild(companyLabel);
		}
		
	}
}
