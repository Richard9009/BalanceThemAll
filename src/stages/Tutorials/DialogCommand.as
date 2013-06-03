package stages.Tutorials 
{
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	import flash.errors.IllegalOperationError;
	public class DialogCommand {
	
		private static const ENUM_PASS:String = "87652318643ABXSJDH";
		
		public static var stop:DialogCommand = new DialogCommand(ENUM_PASS, "stop");
		public static var promptYesNo:DialogCommand = new DialogCommand(ENUM_PASS, "yes no question");
		public static var hideNPC:DialogCommand = new DialogCommand(ENUM_PASS, "hide npc");
		public static var waitingForEvent:DialogCommand = new DialogCommand(ENUM_PASS, "it needs setEvent function from dialogHelper");
		public static var moveDialogBoxUp:DialogCommand = new DialogCommand(ENUM_PASS, "move dialog box up");
		public static var moveToItemBox:DialogCommand = new DialogCommand(ENUM_PASS, "move to the middle of item box");
		public static var previousTutorial:DialogCommand = new DialogCommand(ENUM_PASS, "previous");
		public static var drawStarLines:DialogCommand = new DialogCommand(ENUM_PASS, "draw star lines");
		public static var startTutorial:DialogCommand = new DialogCommand(ENUM_PASS, "start tutorial");
		public static var turnOffTutorial:DialogCommand = new DialogCommand(ENUM_PASS, "turn off tutorial");
		
		public static var hideAll:DialogCommand = new DialogCommand(ENUM_PASS, "hide all tutorial");
		public static var lockStage:DialogCommand = new DialogCommand(ENUM_PASS, "disable mouse interaction to stage");
		public static var unlockStage:DialogCommand = new DialogCommand(ENUM_PASS, "enable mouse interaction to stage");
		public static var lockDropItem:DialogCommand = new DialogCommand(ENUM_PASS, "lockDropItem");
		public static var allowDropItem:DialogCommand = new DialogCommand(ENUM_PASS, "allow drop item");
		public static var promptSuccessFailed:DialogCommand = new DialogCommand(ENUM_PASS, "it needs setSuccessEvent and setFailedEvent from dialogHelper");
		
		private var command:String;
		
		public function DialogCommand(pass:String, cmd:String)
		{
			if (pass != ENUM_PASS) {
				throw new IllegalOperationError("this is an enumeration class, it can't be instanciated");
			}
			
			command = cmd;
		}
	}

}