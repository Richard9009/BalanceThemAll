package gameEvents 
{
	import flash.events.Event;
	import general.dialogs.commands.ICommandEvent;
	
	/**
	 * ...
	 * @author Herichard
	 */
	public class MessageEvent extends Event implements ICommandEvent
	{
		public static const SHOW_MESSAGE:String = "show message";
		public static const HIDE_MESSAGE:String = "hide message";
		private var _messageCode:String;
		
		public function MessageEvent(type:String, msgCode:String = "") 
		{ 
			super(type, true, false);
			_messageCode = msgCode;
		} 
		
		public override function clone():Event 
		{ 
			return new MessageEvent(type, _messageCode);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("MessageEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get messageCode():String { return _messageCode; }
		
	}
	
}