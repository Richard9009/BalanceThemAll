package stages.Tutorials 
{
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class DialogHelper {
		
		private var _code:String;
		private var _noDialog:Boolean;
		private var _commands:Array = new Array();
		private var _event:String = MouseEvent.MOUSE_DOWN;
		
		public function DialogHelper(code:String, isForNo:Boolean = false, commandArray:Array = null)
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
		
		public function get isForNoAnswer():Boolean { return _noDialog; }
		public function get commands():Array { return _commands; }
		public function get code():String { return _code; }
		public function get event():String { return _event; }
	}

}