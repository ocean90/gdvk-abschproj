package views {
	import views.main.IndexPage;
	import views.main.MapPage;

	import views.events.WorkshopsPage;
	import views.events.TimetablePage;

	import views.user.CheckInPage;
	import views.user.UserDataPage;

	public class Views {

		public static var Index:View = new IndexPage();
		
		public static var Map:View = new MapPage();

		public static var CheckIn:CheckInPage = new CheckInPage();
		public static var UserData:UserDataPage = new UserDataPage();

		public static var Workshops:View = new WorkshopsPage();
		public static var Timetable:View = new TimetablePage();
	}

}
