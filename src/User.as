package  {
	
	public class User {
		private var loggedIn:Boolean = false;
		private var data:Object;

		public function isLoggedIn():Boolean {
			return loggedIn;
		}
		
		public function login(data:Object) {
			trace('login', data);
			loggedIn = true;
			this.data = data;
		}
		
		public function logout() {
			trace('logout');
			loggedIn = false;
			this.data = null;
		}
		
		public function getData(key:String) {
			var value = data != null ? data[key] : null;
			
			if (value == null) {
				return 'Nicht hinterlegt';
			} else {
				return value;
			}
		}
	}
	
}
