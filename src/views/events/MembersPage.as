package views.events {

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	import com.greensock.TweenLite;
	import com.greensock.easing.Quint;

	import utils.Grid;

	import views.View;

	import widgets.Cover;
	import widgets.CoverFlow;
	import widgets.RoundButton;
	import widgets.SmallButton;
	import views.overlays.SearchOverlay;

	public class MembersPage extends View {

		private var members:CoverFlow;

		public function MembersPage() {
			members = new CoverFlow(Main.STAGE.stageWidth, Main.STAGE.stageHeight);
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
			var infos:Array;
			var cover:Cover;

			for (var i = 1; i <= 16; i++) {
				cover = new Cover('green');
				cover.setImage(new Noten());
				cover.setTitle('Seite ' + i);
				cover.setDesc('TODO');
				cover.setAuthor('TODO');

				infos = [];
				infos["a"] = "123";
				infos["b"] = "123";
				infos["c"] = "123";
				infos["d"] = "123";
				cover.setInfos(infos);

				cover.setFreePlaces(50); // @TODO dynamisch
	
				members.push(cover);
			}
		}
	}
}
