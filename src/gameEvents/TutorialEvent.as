package gameEvents 
{
	import flash.events.Event;
	import general.dialogs.commands.ICommandEvent;
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class TutorialEvent extends Event implements ICommandEvent
	{		
	//==============================================STAGE 1_1===========================================================================	
		public static const DRAG_THE_BOOK:String = "DRAG THE BOOK";
		public static const GET_OUT_ITEMBOX:String = "GET THE BOOK OUT OF ITEM BOX";
		public static const BACK_TO_ITEMBOX:String = "BACK TO ITEMBOX";
		public static const STOP_DRAG_BOOK:String = "STOP DRAGGING THE BOOK";
		public static const DRAW_STAR_LINE:String = "DRAW VERTICAL LINE ON THE STARS FOR A CLUE";
		public static const READY_TO_DROP:String = "ITEMS ARE READY TO DROP";
		public static const BOOKS_RELEASED:String = "BOOKS ARE ALREADY RELEASED";
		public static const TUTORIAL_CLEAR:String = "TUTORIAL CLEAR";
		public static const TUTORIAL_FAILED:String = "TUTORIAL FAILED";
		public static const CLOSE_TUTORIAL:String = "CLOSE TUTORIAL";
	
	//===============================================STAGE 1_2=========================================================================
		public static const HANDS_ARE_FULL:String = "THERE ARE 2 ITEMS ON HANDS";
		public static const POWER_USED:String = "POWER USED";
		public static const ON_BALANCE_POSITION:String = "ON BALANCE POSITION";
		public static const OUT_FROM_BALANCE_ZONE:String = "GOT OUT OF BALANCE ZONE";
		public static const LOCK_STAGE:String = "LOCK STAGE";
		public static const UNLOCK_STAGE:String = "UNLOCK STAGE";
		public static const LOCK_DROP:String = "LOCK_DOUBLE_CLICK";
		public static const UNLOCK_DROP:String = "UNLOCK_DOUBLE_CLICK";
		public static const CHECK_BALANCE_LINE:String = "CHECK BALANCE LINE";
		
	//===============================================STAGE1_3==========================================================================
		public static const OBJECT_POINTED:String = "OBJECT POINTED";
		public static const OBJECT_ROTATED:String = "OBJECT ROTATED";
		public static const RESTART_TUTORIAL:String = "RESTART TUTORIAL";
		
		
		public function TutorialEvent(type:String) 
		{
			super(type, true);
		}
		
		override public function clone():Event 
		{
			return new TutorialEvent(type);
		}
	}

}