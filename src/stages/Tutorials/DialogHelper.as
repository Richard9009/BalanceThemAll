package stages.Tutorials 
{
	import flash.events.MouseEvent;
	import mx.utils.StringUtil;
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class DialogHelper {
		
		private var _code:String;
		private var _noDialog:Boolean;
		private var _commands:Array = new Array();
		private var _event:String = MouseEvent.MOUSE_DOWN;
		private var _successEvent:String;
		private var _failedEvent:String;
		
		public function DialogHelper(code:String, commandArray:Array = null, isForNo:Boolean = false)
		{
			_code = code;
			_noDialog = isForNo;
			_commands = commandArray;
			
			if (_commands != null && _commands[0] is DialogCommand == false) 
				throw new Error("The commandArray does not contain DialogCommand");
		}
		
		public function setEvent(type:String):DialogHelper {
			_event = type;
			return this;
		}
		
		public function setSuccessEvent(type:String):DialogHelper {
			_successEvent = type;
			return this;
		}
		
		public function setFailedEvent(type:String):DialogHelper {
			_failedEvent = type;
			return this;
		}
		
		public function get isForNoAnswer():Boolean { return _noDialog; }
		public function get commands():Array { return _commands; }
		public function get code():String { return _code; }
		public function get event():String { return _event; }
		public function get successEvent():String { return _successEvent; }
		public function get failedEvent():String { return _failedEvent; }
	}

}