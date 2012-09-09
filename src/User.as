package  {
	
	public class User {
		private var loggedIn:Boolean = false;
		private var data:Object;

		public function isLoggedIn():Boolean {
			return loggedIn;
		}
		
		public function login(data:Object) {
			if (!loggedIn) {
				loggedIn = true;
				this.data = data;
				trace('Login successful:', getData('firstname'), getData('lastname'));
			} else {
				trace('Login canceled! - Already logged in:', getData('firstname'), getData('lastname'));
			}
		}
		
		public function logout() {
			if (loggedIn) {
				trace('Logged out successful:', getData('firstname'), getData('lastname'));
				loggedIn = false;
				this.data = null;
			}
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
