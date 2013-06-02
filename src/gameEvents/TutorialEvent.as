package gameEvents 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class TutorialEvent extends Event
	{
		public static const START_TUTORIAL:String = "START TUTORIAL";
		public static const ANSWERED_YES:String = "ANSWERED YES";
		public static const ANSWERED_NO:String = "ANSWERED NO";
		public static const DRAG_THE_BOOK:String = "DRAG THE BOOK";
		public static const GET_OUT_ITEMBOX:String = "GET THE BOOK OUT OF ITEM BOX";
		public static const STOP_DRAG_BOOK:String = "STOP DRAGGING THE BOOK";
		public static const DRAW_STAR_LINE:String = "DRAW VERTICAL LINE ON THE STARS FOR A CLUE";
		public static const READY_TO_DROP:String = "ITEMS ARE READY TO DROP";
		public static const BOOKS_RELEASED:String = "BOOKS ARE ALREADY RELEASED";
		public static const TUTORIAL_CLEAR:String = "TUTORIAL CLEAR";
		public static const TUTORIAL_FAILED:String = "TUTORIAL FAILED";
		public static const CLOSE_TUTORIAL:String = "CLOSE TUTORIAL";
		
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