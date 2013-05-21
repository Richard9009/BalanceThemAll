package gameEvents 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class BalanceLineEvent extends Event 
	{
		public static const START_DRAW_LINE:String = "start draw line";
		public static const STOP_DRAW_LINE:String = "stop draw line";
		
		public function BalanceLineEvent(type:String) 
		{
			super(type, false, false);
		}
		
	}

}