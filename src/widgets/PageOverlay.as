﻿package widgets {
	import com.greensock.TweenLite;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;

	import utils.Colors;
	import utils.Grid;
	import views.View;
	import flash.events.MouseEvent;
	import com.greensock.easing.Back;

	public class PageOverlay extends View {
		
		private var _owidth:Number;
		private var _oheight:Number;
		private var _background:uint;
		private var _stagewidth:Number;
		private var _stageheight:Number;

		private var _overlay:Sprite;
		private var darkenContent:Sprite;
		public var darkenButtonBar:Sprite; // ja das ist ein hack, egal..
		private var contentBox:Sprite;
		
		public var content:Sprite

		private var leftOverlapping:int = 200;
		private var bigHeader:InverseText;
		
		public var cancel:SmallButton;
		// callback function, argument Event
		private var cancelCallback:Function;

		public var submit:SmallButton;
		// callback function, argument Event
		private var submitCallback:Function;

		public function PageOverlay(background:* = 0xffffff, w:Number = 870,h:Number = 700) {
			_owidth = w;
			_oheight = h;
			_background = Colors.getColor(background);;
			_stagewidth = Main.STAGE.stageWidth;
			_stageheight = Main.STAGE.stageHeight

			_overlay = new Sprite();
			_overlay.visible = false;
			_overlay.alpha = 0;
			// Wird dem Content angehangen damit es zwar Header und Footer überlagert, aber nicht das Keyboard.
			Main.CONTENT.addChild(_overlay);

			darkenPage();
			paintContentBox();
			
			content = new Sprite();
			content.x = Grid.COLUMN_PADDING;
			content.y = Grid.COLUMN_PADDING;
			
			bigHeader = new InverseText();
			bigHeader.x = -leftOverlapping;
			bigHeader.y = 38;
			bigHeader.textFormat.size = 40;
			bigHeader.textField.x = Grid.COLUMN_PADDING + leftOverlapping;
			bigHeader.shapeWidth = 200;
			bigHeader.shapeHeight = 80;
			bigHeader.setText('BigHeader');
			bigHeader.visible = false;
			
			cancel = new SmallButton('', 'red');
			cancel.textFormat.color = '0x000000';
			cancel.x = Grid.COLUMN_PADDING;
			cancel.y = this.height - Grid.BUTTON_BAR_BUTTON_HEIGHT - Grid.COLUMN_PADDING;
			cancel.shapeWidth = Grid.SPAN_1;
			cancel.shapeHeight = Grid.BUTTON_BAR_BUTTON_HEIGHT;
			cancel.visible = false;
			cancel.addEventListener(MouseEvent.CLICK, onCancel);

			submit = new SmallButton('', 'green');
			submit.textFormat.color = '0x000000';
			submit.x = this.width - Grid.COLUMN_PADDING - Grid.SPAN_1;
			submit.y = this.height - Grid.BUTTON_BAR_BUTTON_HEIGHT - Grid.COLUMN_PADDING;
			submit.shapeWidth = Grid.SPAN_1;
			submit.shapeHeight = Grid.BUTTON_BAR_BUTTON_HEIGHT;
			submit.visible = false;
			submit.addEventListener(MouseEvent.CLICK, onSubmit);
			
			contentBox.addChild(content);
			contentBox.addChild(bigHeader);
			contentBox.addChild(cancel);
			contentBox.addChild(submit);

			// Don't overflow.
			contentBox.scrollRect = new Rectangle(0, 0, _owidth, _owidth);

			_overlay.visible = true;
			TweenLite.to(_overlay, 0.5, { alpha: 1});
		}

		public function destroy() {
			TweenLite.to(_overlay, 0.3, { alpha: 0, onComplete: function() {
				_overlay.visible = false;
				while (_overlay.numChildren) {
					_overlay.removeChildAt(0);
				}
			}});
		}

		public function darkenPage() {
			darkenContent = new Sprite();
			darkenContent.graphics.beginFill(0x000000);
			darkenContent.graphics.drawRect(0, 0, _stagewidth, _stageheight - Grid.BUTTON_BAR_HEIGHT);
			darkenContent.graphics.endFill();
			darkenContent.alpha = 0.8;

			_overlay.addChild(darkenContent);
			
			darkenButtonBar = new Sprite();
			darkenButtonBar.graphics.beginFill(0x000000);
			darkenButtonBar.graphics.drawRect(0, _stageheight - Grid.BUTTON_BAR_HEIGHT, _stagewidth, VirtualKeyboard.KEYBOARD_HEIGHT);
			darkenButtonBar.graphics.endFill();
			darkenButtonBar.alpha = 0.8;

			_overlay.addChild(darkenButtonBar);
		}

		public function paintContentBox() {
			var x:int, y:int;
			contentBox = new Sprite();
			contentBox.x = _stagewidth * 0.5 - _owidth * 0.5;
			contentBox.y = _stageheight * 0.5 - _oheight * 0.5;
			contentBox.graphics.beginFill(_background);
			contentBox.graphics.drawRect(0, 0, _owidth, _oheight);
			contentBox.graphics.endFill();

			_overlay.addChild(contentBox);
		}

		public function setText(text:String) {
			if (text == bigHeader.textField.text) {
				return;
			}
			
			// ausblenden
			TweenLite.to(bigHeader, 0.4, { x: -leftOverlapping - bigHeader.shapeWidth, onComplete: function() {
				// updaten
				bigHeader.setText(text);
				if (text == null) {
					return;
				}
				
				bigHeader.shapeWidth = bigHeader.textField.textWidth + 50 + leftOverlapping;
				bigHeader.update();
				
				// einblenden
				bigHeader.x = -bigHeader.shapeWidth;
				bigHeader.visible = true;
				TweenLite.to(bigHeader, 0.8, { x: -leftOverlapping, ease:Back.easeOut });
			}});
		}
		
		public function showCancelButton(text:String, callback:Function) {
			cancel.x = Grid.COLUMN_2 - Grid.COLUMN_2 + Grid.COLUMN_PADDING;
			cancel.shapeWidth = Grid.SPAN_1;
			cancel.visible = true;
			cancel.setText(text);
			cancelCallback = callback;
		}

		public function onCancel(e:Event) {
			if (cancelCallback != null) {
				cancelCallback(e);
			}
		}

		public function showSubmitButton(text:String, callback:Function) {
			submit.x = Grid.COLUMN_5 - Grid.COLUMN_2 + Grid.COLUMN_PADDING;
			submit.shapeWidth = Grid.SPAN_1;
			submit.visible = true;
			submit.setText(text);
			submitCallback = callback;
		}

		public function onSubmit(e:Event) {
			if (submitCallback != null) {
				submitCallback(e);
			}
		}

		/*
		* Overide some setters and getters
		*/
		public override function set width(w:Number):void {
			_owidth = w;
		}

		public override function get width():Number {
			return _owidth;
		}

		public override function set height(h:Number):void {
			_oheight = h;
		}

		public override function get height():Number {
			return _oheight;
		}
	}
}