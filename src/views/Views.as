package views {
	
	import views.main.IndexPage;
	import views.main.MapPage;
	import views.main.UserDataPage;

	import views.events.WorkshopsPage;
	import views.events.TimetablePage;
	import views.events.MemberInfoPage;
	import views.events.MemberListPage;

	/**
	 * Konstanten für die Views. Über diesen Trick werden die Klassen frühzeitig geladen
	 * und man bekommt fail-fast-Fehlermeldungen wenn man irgendwo im ActionScript was
	 * falsch gemacht hat. Zusätzlich hilft dies den Speicher richtig einzuschätzen wenn
	 * sowieso das meißte bereits geladen und initialisiert wurden ist.
	 */
	public class Views {

		public static const Index:IndexPage = new IndexPage();
		public static const Map:MapPage = new MapPage();
		public static const UserData:UserDataPage = new UserDataPage();

		public static const Workshops:WorkshopsPage = new WorkshopsPage();
		public static const Timetable:TimetablePage = new TimetablePage();
		public static const MemberInfo:MemberInfoPage = new MemberInfoPage();
		public static const MemberList:MemberListPage = new MemberListPage();
	}

}
