package views {
	import views.main.IndexPage;
	import views.main.PlanPage;

	import views.events.WorkshopsPage;
	import views.events.EventPage2;
	import views.events.TimetablePage;

	import views.user.CheckInPage;
	import views.user.UserDataPage;

	public class Views {

		public static var Index:View = new IndexPage();
		
		public static var Plan:View = new PlanPage();

		public static var CheckIn:CheckInPage = new CheckInPage();
		public static var UserData:UserDataPage = new UserDataPage();

		public static var Event1:View = new WorkshopsPage();
		public static var Event2:View = new EventPage2();
		public static var Event3:View = new TimetablePage();
	}

}
