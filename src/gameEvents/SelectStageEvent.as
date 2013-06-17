package gameEvents 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class SelectStageEvent extends Event 
	{
		public static const OPEN_SELECT_LEVEL:String = "OPEN SELECT LEVEL";
		public static const OPEN_SELECT_LEVEL_FROM_OPTION:String = "OPEN SELECT LEVEL FROM OPTION";
		public static const BACK_TO_LAST_SCENE:String = "BACK TO LAST SCENE";
		public static const STAGE_SELECTED:String = "STAGE SELECTED";
		
		
		public function SelectStageEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			
		}
		
	}

}