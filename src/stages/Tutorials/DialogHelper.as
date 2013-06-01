package stages.Tutorials 
{
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class DialogHelper {
		
		private var _code:String;
		private var _noDialog:Boolean;
		private var _command:DialogCommand;
		
		public function DialogHelper(code:String, isForNo:Boolean = false, command:DialogCommand = null)
		{
			_code = code;
			_noDialog = isForNo;
			_command = command;
		}
		
		public function get isForNoAnswer():Boolean { return _noDialog; }
		public function get command():DialogCommand { return _command; }
		public function get code():String { return _code; }
	}

}