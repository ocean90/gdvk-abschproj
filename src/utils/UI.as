package utils {
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.net.URLRequest;

	import com.greensock.TweenLite;

	import widgets.BigButton;
	import widgets.SmallButton;
	import views.Views;
	import views.View;
	import widgets.InverseText;

	public class UI extends MovieClip {

		var viewStack:Vector.<View> = new Vector.<View>();

		var inverseText1:InverseText;
		var inverseText2:InverseText;

		var home:SmallButton;
		var back:SmallButton;
		var logout:SmallButton;

		var indexPage:DisplayObject;
		var testPage:DisplayObject;

		public function UI() {
			inverseText1 = new InverseText();
			inverseText1.x = 0;
			inverseText1.y = 38;
			inverseText1.textField.x = 25;
			inverseText1.shapeWidth = 240;
			inverseText1.shapeHeight = 50;
			inverseText1.setText('Es wird laut!');
			addChild(inverseText1);

			inverseText2 = new InverseText();
			inverseText2.x = Grid.COLUMN_1 * 2;
			inverseText2.y = 88;
			inverseText2.textField.x = 25;
			inverseText2.shapeWidth = 300;
			inverseText2.shapeHeight = 50;
			inverseText2.setText('WELTREKORD');
			addChild(inverseText2);

			home = new SmallButton('Hauptmenü', 'lightgray');
			home.textFormat.color = '0x000000';
			home.x = Grid.COLUMN_1;
			home.y = Grid.BUTTON_BAR_Y;
			home.shapeWidth = Grid.SPAN_1;
			home.shapeHeight = Grid.BUTTON_BAR_HEIGHT;
			home.addEventListener(MouseEvent.CLICK, onHome);
			home.update();
			addChild(home);

			back = new SmallButton('Zurück', 'lightgray');
			back.textFormat.color = '0x000000';
			back.x = Grid.COLUMN_2;
			back.y = Grid.BUTTON_BAR_Y;
			back.shapeWidth = Grid.SPAN_1;
			back.shapeHeight = Grid.BUTTON_BAR_HEIGHT;
			back.addEventListener(MouseEvent.CLICK, onBack);
			back.update();
			addChild(back);

			// Achtung: "SecurityError: Error #2000: Kein aktiver Sicherheitskontext."
			// bedeutet einfach nur das die URL falsch ist!
			var loader:Loader = new Loader();
			loader.load(new URLRequest('../resources/german_32.png'));
			home.addChild(loader);

			// Achtung: "SecurityError: Error #2000: Kein aktiver Sicherheitskontext."
			// bedeutet einfach nur das die URL falsch ist!
			var loader:Loader = new Loader();
			loader.load(new URLRequest('../resources/english_32.png'));
			back.addChild(loader);

			logout = new SmallButton('Abmelden', 'lightgray');
			logout.textFormat.color = '0x000000';
			logout.x = Grid.COLUMN_6;
			logout.y = Grid.BUTTON_BAR_Y;
			logout.shapeWidth = Grid.SPAN_1;
			logout.shapeHeight = Grid.BUTTON_BAR_HEIGHT;
			logout.addEventListener(MouseEvent.CLICK, onBack);
			logout.update();
			addChild(logout);

			pushView(Views.Index);
		}

		public function updateButtonBar() {
			if (viewStack.length > 1) {
				home.textFormat.color = '0x000000';
				home.update();
				back.visible = true;
			} else {
				home.textFormat.color = '0x888888';
				home.update();
				back.visible = false;
			}
		}

		public function onHome(e:Event) {
			if (viewStack.length == 1) {
				return;
			}

			// get current view and remove all others
			var prevView:View = viewStack.pop();
			while (viewStack.length > 1) {
				viewStack.pop();
			}
			var homeView:View = viewStack[viewStack.length - 1];

			homeView.x = -1280;
			homeView.visible = true;
			homeView.buttonMode = false;

			TweenLite.to(prevView, 0.8, { x: 1280 });
			TweenLite.to(homeView, 0.8, { x: 0 });

			this.updateButtonBar();
		}

		public function onBack(e:Event) {
			popView();
		}

		public function pushView(view:View) {
			if (viewStack.length == 0) {
				// first view from bottom -- demo/test case only...

				viewStack.push(view);
				view.alpha = 0;
				view.visible = true;
				addChild(view);

				TweenLite.to(view, 1.6, { delay: 0.5, alpha: 1 });

			} else {
				// all other views

				var prevPage:View = viewStack[viewStack.length - 1];

				viewStack.push(view);
				view.x = 1280;
				view.visible = true;
				addChild(view);

				TweenLite.to(prevPage, 0.8, { x: -1280, visible: false });
				TweenLite.to(view, 0.8, { x: 0 });
			}

			this.updateButtonBar();
		}

		public function popView() {
			if (viewStack.length == 1) {
				return;
			}

			// remove last and push previous to the front
			var lastPage:View = viewStack.pop();
			var prevPage:View = viewStack[viewStack.length - 1];

			prevPage.x = -1280;
			prevPage.visible = true;

			TweenLite.to(lastPage, 0.8, { x: 1280 });
			TweenLite.to(prevPage, 0.8, { x: 0 });

			this.updateButtonBar();
		}
	}

}
