package views {
	import views.View;
	
	import views.main.IndexPage;
	import views.main.MapPage;
	import views.main.UserDataPage;

	import views.events.WorkshopsPage;
	import views.events.TimetablePage;
	import views.events.MembersPage;

	public class Views {

		public static var Index:View = new IndexPage();
		public static var Map:View = new MapPage();
		public static var UserData:UserDataPage = new UserDataPage();

		public static var Workshops:View = new WorkshopsPage();
		public static var Timetable:View = new TimetablePage();
		public static var Members:View = new MembersPage();
	}

}
