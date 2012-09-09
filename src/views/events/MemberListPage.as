package views.events {

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	import com.greensock.TweenLite;
	import com.greensock.easing.Quint;

	import utils.Grid;
	import utils.Namen;

	import views.View;
	import views.overlays.SearchOverlay;

	import widgets.Cover;
	import widgets.CoverFlow;
	import widgets.SmallButton;
	import widgets.TextLabel;

	public class MemberListPage extends View {

		private var _isFiltered:Boolean;
		private var _memberCount:int;
		private var _backgroundColor;
		private var _textColor;
		private var _coverflow:CoverFlow;

		public function MemberListPage() {
		}

		public function updateConfiguration(backgroundColor:int, textColor:int, memberCount:int):void {
			_isFiltered = false;
			_memberCount = memberCount;
			_backgroundColor = backgroundColor;
			_textColor = textColor;
			if (_coverflow != null) {
				removeChild(_coverflow);
				_coverflow = null;
			}
		}

		public override function onResume():Boolean {
			if (Main.LANGUAGE == 'DE') {
				Main.HEADER.setText('Teilnehmer');
			} else if (Main.LANGUAGE == 'EN') {
				Main.HEADER.setText('Members');
			}

			Main.FOOTER.resetButtonBar();

			if (_isFiltered) {
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
			
			// Do not auto-update view when closing search dialog.
			return true;
		}

		public override function update():void {
			onResume();
			regenerateMemberPages();
		}

		public function cancelSearch(e:Event):void {
			_isFiltered = false;
			regenerateMemberPages();
			update();
		}

		public function openSearch(e:Event):void {
			var searchOverlay:SearchOverlay = new SearchOverlay();
			searchOverlay.searchCallback = function() {
				_isFiltered = true;
				regenerateMemberPages();
				update();
			};

			Main.CONTENT.showOverlay(searchOverlay);
		}

		private function regenerateMemberPages():void {
			if (_coverflow != null) {
				removeChild(_coverflow);
			}
			_coverflow = new CoverFlow(Main.STAGE.stageWidth, Main.STAGE.stageHeight, _backgroundColor);

			var cover:Cover;
			var posY:int;

			var totalMemberCount:int = _memberCount;//Math.floor(_memberCount * (_isFiltered ? 0.2 : 1.0));
			var notAddedMemberCount:int = _memberCount;
			while (notAddedMemberCount > 0) {
				cover = new Cover();
				posY = 0;

				if (Main.LANGUAGE == 'DE') {
					addHeadline(cover, 'Nachname', 'Vorname', 'Stadt', 'Firma', posY += 15);
				} else {
					addHeadline(cover, 'Lastname', 'Firstname', 'City', 'Company', posY += 15);
				}
 				posY += 10;

				for (var line = 0; line < Math.min(notAddedMemberCount, 17); line++) {
					addLine(cover,
							Namen.getLastname((totalMemberCount - notAddedMemberCount + line) * 1.0 / totalMemberCount),
							Namen.getRandomFirstname(),
							Namen.getRandomCity(),
							Namen.getRandomCompany(),
							posY += 30);
				}
				notAddedMemberCount -= Math.min(notAddedMemberCount, 17);

				// HACK to show only one page if filter is active.
				if (_isFiltered) {
					notAddedMemberCount = 0;
				}

				_coverflow.push(cover);
			}

			_coverflow.layout();
			addChild(_coverflow);
		}

		private function addHeadline(cover:Cover, lastname:String, firstname:String, city:String, company:String, posY:int):void {
			var lastnameLabel:TextLabel = new TextLabel();
			lastnameLabel.textFormat.color = _textColor;
			lastnameLabel.textFormat.bold = true;
			lastnameLabel.x = Grid.COLUMN_1;
			lastnameLabel.y = posY;
			lastnameLabel.shapeWidth = Grid.SPAN_1;
			lastnameLabel.shapeHeight = 50;
			lastnameLabel.setText(lastname);

			var firstnameLabel:TextLabel = new TextLabel();
			firstnameLabel.textFormat.color = _textColor;
			firstnameLabel.textFormat.bold = true;
			firstnameLabel.x = Grid.COLUMN_2;
			firstnameLabel.y = posY;
			firstnameLabel.shapeWidth = Grid.SPAN_1;
			firstnameLabel.shapeHeight = 50;
			firstnameLabel.setText(firstname);

			var cityLabel:TextLabel = new TextLabel();
			cityLabel.textFormat.color = _textColor;
			cityLabel.textFormat.bold = true;
			cityLabel.x = Grid.COLUMN_3;
			cityLabel.y = posY;
			cityLabel.shapeWidth = Grid.SPAN_1;
			cityLabel.shapeHeight = 50;
			cityLabel.setText(city);

			var companyLabel:TextLabel = new TextLabel();
			companyLabel.textFormat.color = _textColor;
			companyLabel.textFormat.bold = true;
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

		private function addLine(cover:Cover, lastname:String, firstname:String, city:String, company:String, posY:int):void {
			var lastnameLabel:TextLabel = new TextLabel();
			lastnameLabel.textFormat.color = _textColor;
			lastnameLabel.x = Grid.COLUMN_1;
			lastnameLabel.y = posY;
			lastnameLabel.shapeWidth = Grid.SPAN_1;
			lastnameLabel.shapeHeight = 50;
			lastnameLabel.setText(lastname);

			var firstnameLabel:TextLabel = new TextLabel();
			firstnameLabel.textFormat.color = _textColor;
			firstnameLabel.x = Grid.COLUMN_2;
			firstnameLabel.y = posY;
			firstnameLabel.shapeWidth = Grid.SPAN_1;
			firstnameLabel.shapeHeight = 50;
			firstnameLabel.setText(firstname);

			var cityLabel:TextLabel = new TextLabel();
			cityLabel.textFormat.color = _textColor;
			cityLabel.x = Grid.COLUMN_3;
			cityLabel.y = posY;
			cityLabel.shapeWidth = Grid.SPAN_1;
			cityLabel.shapeHeight = 50;
			cityLabel.setText(city);

			var companyLabel:TextLabel = new TextLabel();
			companyLabel.textFormat.color = _textColor;
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
