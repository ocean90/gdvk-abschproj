package utils {
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.events.Event;
		
	import com.greensock.TweenLite;
	
	import widgets.BigButton;
	import views.Views;
	import views.View;
	
	public class UI extends MovieClip {

		var viewStack:Vector.<View> = new Vector.<View>();

		var back:BigButton;

		var indexPage:DisplayObject;
		var testPage:DisplayObject;

		public function UI() {
			back = new BigButton(Grid.COLUMN_1, 0, 'lightgray');
			back.setText('Back');
			back.addEventListener(MouseEvent.CLICK, onBack);
			addChild(back);
			
			pushView(Views.Index);
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
				
				TweenLite.to(view, 0.8, { x: 0, y: 0 });
				
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
		}
	}
	
}
