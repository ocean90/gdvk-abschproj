package utils {
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.events.Event;
		
	import com.greensock.TweenLite;
	
	import widgets.BigButton;
	import widgets.SmallButton;
	import views.Views;
	import views.View;
	
	public class UI extends MovieClip {

		var viewStack:Vector.<View> = new Vector.<View>();

		var home:SmallButton;
		var back:SmallButton;

		var indexPage:DisplayObject;
		var testPage:DisplayObject;

		public function UI() {
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
			back.visible = false;
			
			pushView(Views.Index);
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
			
			TweenLite.to(prevView, 0.8, { x: 1280 });
			TweenLite.to(homeView, 0.8, { x: 0 });
			
			back.visible = false;
		}
		
		public function onBack(e:Event) {
			popView();
		}
		
		public function pushView(view:View) {
			if (viewStack.length == 0) {
				// first view from bottom -- demo/test case only...
				
				viewStack.push(view);
				view.x = 0;
				view.y = 1024;
				view.visible = true;
				addChild(view);
				
				TweenLite.to(view, 0.8, { delay: 1, x: 0, y: 0 });
				
			} else {
				// all other views
				
				var prevPage:View = viewStack[viewStack.length - 1];
				
				viewStack.push(view);
				view.x = 1280;
				view.visible = true;
				addChild(view);
				
				TweenLite.to(prevPage, 0.8, { x: -1280, visible: false });
				TweenLite.to(view, 0.8, { x: 0 });
				
				back.visible = true;
			}
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
			
			back.visible = viewStack.length > 1;
		}
	}
	
}
