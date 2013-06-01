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
		public static var waitingForEvent:DialogCommand = new DialogCommand(ENUM_PASS, "waiting for event");
		public static var moveDialogBoxUp:DialogCommand = new DialogCommand(ENUM_PASS, "move dialog box up");
		public static var moveToItemBox:DialogCommand = new DialogCommand(ENUM_PASS, "move to the middle of item box");
		public static var drawStarLines:DialogCommand = new DialogCommand(ENUM_PASS, "draw star lines");
		
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