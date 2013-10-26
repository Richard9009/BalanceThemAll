package gameEvents 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class GameEvent extends Event 
	{
		public static const START_GAME:String = "start game";
		public static const PAUSE_GAME:String = "pause game";
		public static const RESUME_GAME:String = "resume game";
		
		public static const RESTART_LEVEL:String = "restart level";
		public static const STAGE_CLEAR:String = "stage clear";
		public static const BACK_TO_MAIN:String = "back to main";
		public static const QUIT_GAME:String = "quit game";
		public static const GAME_OVER:String = "game over";
		
		public static const GOTO_NEXT_STAGE:String = "go to next stage";
		public static const REPLAY_THIS_STAGE:String = "replay this stage";
		public static const OPENING_COMPLETE:String = "opening complete";
		
		public function GameEvent(type:String) 
		{
			super(type, true, false);
		}
		
	}

}