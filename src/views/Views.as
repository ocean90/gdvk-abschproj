package views {
	import views.main.IndexPage;
	import views.main.CheckInPage;
	import views.main.TestPage;
	import views.events.Workshops;
	import views.events.EventPage2;

	public class Views {

		public static var Index:View = new IndexPage();
		public static var CheckIn:View = new CheckInPage();
		public static var Test:View = new TestPage();

		public static var Event1:View = new Workshops();
		public static var Event2:View = new EventPage2();
	}

}
