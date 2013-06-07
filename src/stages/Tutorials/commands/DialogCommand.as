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
		public static function get hideNPC():DialogCommand { return new DialogCommand(ENUM_PASS, "hide npc"); }
		public static function get moveDialogBoxUp():DialogCommand { return new DialogCommand(ENUM_PASS, "move dialog box up"); }
		public static function get moveToItemBox():DialogCommand { return new DialogCommand(ENUM_PASS, "move to the middle of item box"); }
		
		public static function waitingForEvent(type:String = NONE):DialogCommand { 
			var cmd:DialogCommand = new DialogCommand(ENUM_PASS, "it needs setEvent function from dialogHelper");
			cmd.waitingEvent = type;
			return cmd;
		}
		public static function dispatchAnEvent(type:String = NONE):DialogCommand { 
			var cmd:DialogCommand = new DialogCommand(ENUM_PASS, "dispatch an event"); 
			cmd.eventToDispatch = type;
			return cmd;
		}
		public static function promptSuccessFailed(success:String = NONE, failed:String = NONE):DialogCommand { 
			var cmd:DialogCommand = new DialogCommand(ENUM_PASS, "handle success and fail"); 
			cmd.successEvent = success;
			cmd.failedEvent = failed;
			return cmd;
		}
		
		public static function jumpToDialog(index:int = 0):DialogCommand {
			var cmd:DialogCommand = new DialogCommand(ENUM_PASS, "jump to a specific dialog");
			cmd.dialogIndex = index;
			return cmd;
		}
		
		public function get commandType():String { return _commandType; }
		
	}

}