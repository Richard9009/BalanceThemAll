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