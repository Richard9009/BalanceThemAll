package stages.Tutorials 
{
	import flash.errors.IllegalOperationError;
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class DialogPath 
	{
		private static const ENUM_PASS:String = "KDAU2I2983JHDH2084JD_JID2";
		
		public static const TUTORIAL:DialogPath = new DialogPath(ENUM_PASS, "tutorial");
		public static const SKIP_TUTORIAL:DialogPath = new DialogPath(ENUM_PASS, "skip tutorial");
		public static const SUCCESS:DialogPath = new DialogPath(ENUM_PASS, "success");
		public static const FAILED:DialogPath = new DialogPath(ENUM_PASS, "failed");
		
		public static const CATCH_RETURN:DialogPath = new DialogPath(ENUM_PASS, "return from the next dialog");
		public static const ALL_PATHS:DialogPath = new DialogPath(ENUM_PASS, "all paths");
		
		private var _path:String;
		
		public function DialogPath(pass:String, path:String) 
		{
			if (pass != ENUM_PASS) throw new IllegalOperationError("Can't instantiate this class");
			_path = path;
		}
		
	}

}