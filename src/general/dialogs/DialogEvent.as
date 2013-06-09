package general.dialogs 
{
	import flash.events.Event;
	import general.dialogs.commands.ICommandEvent;
	
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class DialogEvent extends Event implements ICommandEvent
	{
		public static const CLOSE_DIALOG:String = "CLOSE DIALOG";
		
		public function DialogEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			
		}
		
	}

}