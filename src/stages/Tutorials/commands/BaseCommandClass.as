package stages.Tutorials.commands 
{
	import flash.errors.IllegalOperationError;
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class BaseCommandClass 
	{
		protected static const ENUM_PASS:String = "87652318643ABXSJDH";
		protected var actionList:Array = new Array();
		private var _commandType:String;
		
		public function BaseCommandClass(pass:String, cmdType:String)
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
		
		public function get commandType():String { return _commandType; }
		
	}

}