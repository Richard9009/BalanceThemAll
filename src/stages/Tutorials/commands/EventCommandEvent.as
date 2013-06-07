package stages.Tutorials.commands 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class EventCommandEvent extends Event implements ICommandEvent 
	{
		public static const WAITING_COMPLETE:String = "WAITING COMPLETE";
		public static const SUCCESS:String = "SUCCESS";
		public static const FAILED:String = "FAILED";
		
		public function EventCommandEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			
		}
		
	}

}