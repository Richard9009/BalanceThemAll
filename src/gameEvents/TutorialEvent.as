package gameEvents 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class TutorialEvent extends Event
	{
		public static var ANSWERED_YES:String = "ANSWERED YES";
		public static var ANSWERED_NO:String = "ANSWERED NO";
		
		public function TutorialEvent(type:String) 
		{
			super(type);
		}
		
	}

}