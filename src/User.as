package  {
	
	public class User {
		private var loggedIn:Boolean = false;
		private var id:String;
		private var firstname:String;
		private var lastname:String;
		private var city:String;
		private var dateOfBirth:String;

		public function isLoggedIn():Boolean {
			return loggedIn;
		}
		
		public function login(data:Object) {
			trace('login', data);
			loggedIn = true;
			id = data['id'];
			firstname = data['firstname'];
			lastname = data['lastname'];
			city = data['city'];
			dateOfBirth = data['dateOfBirth'];
		}
		
		public function logout() {
			trace('logout');
			loggedIn = false;
			id = null;
			firstname = null;
			lastname = null;
			city = null;
			dateOfBirth = null;
		}
	}
	
}
