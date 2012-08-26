package views {
	import views.main.IndexPage;
	//import views.main.Plan;

	import views.events.Workshops;
	import views.events.EventPage2;
	import views.events.Timetable;

	import views.user.CheckInPage;
	import views.user.UserDataPage;

	public class Views {

		public static var Index:View = new IndexPage();
		
		//public static var Plan:View = new Plan();

		public static var CheckIn:CheckInPage = new CheckInPage();
		public static var UserData:UserDataPage = new UserDataPage();

		public static var Event1:View = new Workshops();
		public static var Event2:View = new EventPage2();
		public static var Event3:View = new Timetable();
	}

}
