package stages.Tutorials 
{
	import flash.events.MouseEvent;
	import mx.utils.StringUtil;
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class DialogHelper {
		
		public static const EMPTY:String = "EMPTY";
		private static const DEFAULT_PATH:Array = [DialogPath.TUTORIAL];
		
		private var _code:String;
		private var _paths:Array = new Array();
		private var _commands:Array = new Array();
		private var _event:String = MouseEvent.MOUSE_DOWN;
		private var _successEvent:String;
		private var _failedEvent:String;
		
		public function DialogHelper(code:String, commandArray:Array = null, pathArray:Array = null)
		{
			_code = code;
			_paths = (pathArray == null) ? DEFAULT_PATH : pathArray;
			_commands = commandArray;
			
			if (_commands != null && _commands[0] is DialogCommand == false) 
				throw new Error("The commandArray does not contain DialogCommand");
				
			if (_paths[0] is DialogPath == false)
				throw new Error("The pathArrat does not contain DialogPath object");
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
		
		public function inThisPath(path:DialogPath):Boolean {
			for each(var p:DialogPath in paths) {
				if (p == DialogPath.ALL_PATHS) return true;
				if (p == path) return true;
			}
			
			return false;
		}
		
		public function get paths():Array { return _paths; }
		public function get commands():Array { return _commands; }
		public function get code():String { return _code; }
		public function get event():String { return _event; }
		public function get successEvent():String { return _successEvent; }
		public function get failedEvent():String { return _failedEvent; }
		public function get isEmpty():Boolean { return code == EMPTY; }
	}

}