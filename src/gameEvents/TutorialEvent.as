package gameEvents 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class TutorialEvent extends Event
	{
		public static const ANSWERED_YES:String = "ANSWERED YES";
		public static const ANSWERED_NO:String = "ANSWERED NO";
		public static const DRAG_THE_BOOK:String = "DRAG THE BOOK";
		public static const GET_OUT_ITEMBOX:String = "GET THE BOOK OUT OF ITEM BOX"; 
		
		public function TutorialEvent(type:String) 
		{
			super(type);
		}
		
		override public function clone():Event 
		{
			return new TutorialEvent(type);
		}
	}

}