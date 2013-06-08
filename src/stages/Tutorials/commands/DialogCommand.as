package stages.Tutorials.commands 
{
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	import flash.errors.IllegalOperationError;
	import stages.Tutorials.*;
	public class DialogCommand {
	
		protected static const ENUM_PASS:String = "87652318643ABXSJDH";
		protected static const NONE:String = "NO EVENT ASSIGNED";
		
		private static var eventHandler:TutorialEventDispatcher = TutorialEventDispatcher.getInstance();
		protected var actionList:Array = new Array();
		private var _commandType:String;
		
		public var successEvent:String;
		public var failedEvent:String;
		public var waitingEvent:String;
		public var eventToDispatch:String;
		public var dialogIndex:int;
		
		public function DialogCommand(pass:String, cmdType:String)
		{
			if (pass != ENUM_PASS) {
				throw new IllegalOperationError("this is an enumeration class, it can't be instanciated");
			}
		
			_commandType = cmdType;
		}
		
		public function executeAllActions():void 
		{
			for each(var act:Function in actionList) act();
		}
		
		public static function get stop():DialogCommand { return new DialogCommand(ENUM_PASS, "stop"); }
		
		public static function jumpToDialog(index:int = 0):DialogCommand {
			var cmd:DialogCommand = new DialogCommand(ENUM_PASS, "jump to a specific dialog");
			cmd.dialogIndex = index;
			return cmd;
		}
		
		public static function get allowSkip():DialogCommand { return new DialogCommand(ENUM_PASS, "allow skip"); }
		
		public function get commandType():String { return _commandType; }
		
	}

}