package gameEvents 
{
	import flash.events.Event;
	import general.dialogs.commands.ICommandEvent;
	
	/**
	 * ...
	 * @author Herichard
	 */
	public class CueEvent extends Event implements ICommandEvent
	{
		public static const CUE_ITEM_PANEL:String = "cue item panel";
		public static const CUE_AN_OBJECT:String = "cue an object";
		public static const CUE_DROP_BUTTON:String = "cue drop button";
		public static const REMOVE_ALL:String = "remove all";
		
		public function CueEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new CueEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("CueEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}