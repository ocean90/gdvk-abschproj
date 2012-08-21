package views {
	import views.main.IndexPage;
	import views.main.TestPage;
	import views.events.EventPage1;
	import views.events.EventPage2;
	
	public class Views {
		
		public static var Index:View = new IndexPage();
		public static var Test:View = new TestPage();
		
		public static var Event1:View = new EventPage1();
		public static var Event2:View = new EventPage2();
	}
	
}
