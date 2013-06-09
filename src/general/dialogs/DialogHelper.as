package general.dialogs 
{
	import general.dialogs.commands.BaseCommandClass;
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class DialogHelper {
		
		public static const EMPTY:String = "EMPTY";
		private static const DEFAULT_PATH:Array = [DialogPath.DEFAULT];
		
		private var _code:String;
		private var _paths:Array = new Array();
		private var _commands:Array = new Array();

		public function DialogHelper(code:String, commandArray:Array = null, pathArray:Array = null)
		{
			_code = code;
			_paths = (pathArray == null) ? DEFAULT_PATH : pathArray;
			_commands = commandArray;
			
			if (_commands != null && _commands[0] is BaseCommandClass == false) 
				throw new Error("The commandArray does not contain DialogCommand. CODE: "+code);
				
			if (_paths[0] is DialogPath == false)
				throw new Error("The pathArray does not contain DialogPath object. CODE: "+code);
		}
		
		public function inThisPath(path:DialogPath):Boolean {
			for each(var p:DialogPath in paths) {
				if (p == DialogPath.ALL_PATHS) return true;
				if (p == path) return true;
			}
			
			return false;
		}
		
		public function runCommands():void
		{
			for each(var cmd:BaseCommandClass in _commands) {
				cmd.executeAllActions();
			}
		}
		
		public function get paths():Array { return _paths; }
		public function get code():String { return _code; }
		public function get isEmpty():Boolean { return code == EMPTY; }
	}

}