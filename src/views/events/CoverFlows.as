package views.events {
	import flash.display.Sprite;

	import views.events.CoverFlow;

	public class CoverFlows extends Sprite {
		private	var CoverFlowStack:Vector.<CoverFlow> = new Vector.<CoverFlow>();
		private var _currentCover:int;

		public function CoverFlows() {
			this._currentCover = 0;
		}

		public function pushCover(cover:CoverFlow) {
			CoverFlowStack.push(cover);
			addChild(cover);
		}

		public function popCover():CoverFlow {
			if ( this.isEmpty() )
				return null;

			return CoverFlowStack.pop();
		}

		public function set currentCover(i:int) {
			this._currentCover = i;
		}

		public function get currentCover():int {
			return this._currentCover;
		}

		public function getCover(i:int):CoverFlow {
			return CoverFlowStack[i];
		}

		public function nextCover() {
			if ( this._currentCover + 1 > length() - 1 )
				return null;

			this._currentCover++;
			trace(this._currentCover);
		}

		public function prevCover() {
			if ( this._currentCover - 1 < 0 )
				return null;

			this._currentCover--;
			trace(this._currentCover);
		}

		private function isEmpty() {
			return CoverFlowStack.length > 0;
		}

		public function length() {
			return CoverFlowStack.length;
		}
	}
}