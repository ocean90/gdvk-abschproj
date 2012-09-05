package views {
	
	import views.main.IndexPage;
	import views.main.MapPage;
	import views.main.UserDataPage;

	import views.events.WorkshopsPage;
	import views.events.TimetablePage;
	import views.events.MemberInfoPage;
	import views.events.MemberListPage;

	public class Views {

		public static var Index:IndexPage = new IndexPage();
		public static var Map:MapPage = new MapPage();
		public static var UserData:UserDataPage = new UserDataPage();

		public static var Workshops:WorkshopsPage = new WorkshopsPage();
		public static var Timetable:TimetablePage = new TimetablePage();
		public static var MemberInfo:MemberInfoPage = new MemberInfoPage();
		public static var MemberList:MemberListPage = new MemberListPage();
	}

}
