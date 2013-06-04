package stages.Tutorials 
{
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	import flash.errors.IllegalOperationError;
	public class DialogCommand {
	
		protected static const ENUM_PASS:String = "87652318643ABXSJDH";
		protected static const NONE:String = "NO EVENT ASSIGNED";
		
		private static var eventHandler:TutorialEventDispatcher = TutorialEventDispatcher.getInstance();
		public var commandType:String;
		
		public var successEvent:String;
		public var failedEvent:String;
		public var waitingEvent:String;
		public var eventToDispatch:String;
		public var dialogPath:DialogPath;
		
		public function DialogCommand(pass:String, cmdType:String)
		{
			if (pass != ENUM_PASS) {
				throw new IllegalOperationError("this is an enumeration class, it can't be instanciated");
			}
			
			commandType = cmdType;
		}
		
		public function setWaitingEvent(type:String):DialogCommand
		{
			waitingEvent = type;
			return this;
		}
		
		public function setSuccessFailedEvent(success:String, failed:String):DialogCommand
		{
			successEvent = success;
			failedEvent = failed;
			return this;
		}
		
		public function setEventToDispatch(type:String):DialogCommand
		{
			eventToDispatch = type;
			return this;
		}
		
		public function setDialogPath(path:DialogPath):DialogCommand
		{
			dialogPath = path;
			return this;
		}
		
		
		public static function get stop():DialogCommand { return new DialogCommand(ENUM_PASS, "stop"); }
		public static function get promptYesNo():DialogCommand { return new DialogCommand(ENUM_PASS, "yes no question"); }
		public static function get hideNPC():DialogCommand { return new DialogCommand(ENUM_PASS, "hide npc"); }
		public static function get moveDialogBoxUp():DialogCommand { return new DialogCommand(ENUM_PASS, "move dialog box up"); }
		public static function get moveToItemBox():DialogCommand { return new DialogCommand(ENUM_PASS, "move to the middle of item box"); }
		public static function get previousTutorial():DialogCommand { return new DialogCommand(ENUM_PASS, "previous"); }
		public static function get startTutorial():DialogCommand { return new DialogCommand(ENUM_PASS, "start tutorial"); }
		public static function get turnOffTutorial():DialogCommand { return new DialogCommand(ENUM_PASS, "turn off tutorial"); }
		public static function get hideAll():DialogCommand { return new DialogCommand(ENUM_PASS, "hide all tutorial"); }
		
		public static function waitingForEvent(type:String = NONE):DialogCommand { 
			var cmd:DialogCommand = new DialogCommand(ENUM_PASS, "it needs setEvent function from dialogHelper");
			cmd.setWaitingEvent(type);
			return cmd;
		}
		public static function dispatchAnEvent(type:String = NONE):DialogCommand { 
			var cmd:DialogCommand = new DialogCommand(ENUM_PASS, "dispatch an event"); 
			cmd.setEventToDispatch(type);
			return cmd;
		}
		public static function promptSuccessFailed(success:String = NONE, failed:String = NONE):DialogCommand { 
			var cmd:DialogCommand = new DialogCommand(ENUM_PASS, "handle success and fail"); 
			cmd.setSuccessFailedEvent(success, failed);
			return cmd;
		}
		
		//public function get commandType():String { return _type; }
		
	}

}