package stages.Tutorials 
{
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class TutorialCommand extends DialogCommand
	{
		private static var tutorial:Tutorial;
		private var actionList:Array = new Array();
		
		public function TutorialCommand(pass:String, cmdType:String) 
		{
			super(pass, cmdType);
		}
		
		public static function setTutorial(tutor:Tutorial):void
		{
			tutorial = tutor;
		}
		
		public function addAction(action:Function):TutorialCommand
		{
			actionList.push(action);
			return this;
		}
		
		public function executeAllActions():void 
		{
			for each(var act:Function in actionList) act();
		}
		
		private function hideTutorial():void
		{
			tutorial.visible = false;
		}
		
		public static function get hideAll():TutorialCommand { 
			var cmd:TutorialCommand = new TutorialCommand(ENUM_PASS, "hide all tutorial");
			cmd.addAction(cmd.hideTutorial);
			return cmd;
		}
	}

}