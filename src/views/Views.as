package views {
	import views.main.IndexPage;
	import views.main.TestPage;
	import views.events.Workshops;
	import views.events.EventPage2;
	import views.checkin.CheckInSwitchPage;
	import views.checkin.RegistrationPage;
	import views.checkin.ValidateDataPage;

	public class Views {

		public static var Index:View = new IndexPage();
		public static var Test:View = new TestPage();
		
		public static var CheckInSwitch:View = new CheckInSwitchPage();
		public static var ValidateData:View = new ValidateDataPage();
		public static var Registration:View = new RegistrationPage();
		

		public static var Event1:View = new Workshops();
		public static var Event2:View = new EventPage2();
	}

}
