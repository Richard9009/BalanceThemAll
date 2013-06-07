package stages.Tutorials.commands 
{
	import gameEvents.TutorialEvent;
	import stages.Tutorials.Tutorial;
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class TutorialCommand extends DialogCommand
	{
		private static var tutorial:Tutorial;
		
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
		
		public static function get hideAll():TutorialCommand { 
			return new TutorialCommand(ENUM_PASS, "hide all tutorial")
						.addAction( function hideAll_action():void { tutorial.visible = false });
		}
		
		public static function get promptYesNo():TutorialCommand { 
			return new TutorialCommand(ENUM_PASS, "ask yes no question")
						.addAction( function promptYesNo_action():void {
							tutorial.yesButton.visible = true;
							tutorial.noButton.visible = true;
							tutorial.lockSkipDialog();
						});
		}
		
		public static function get turnOffTutorial():TutorialCommand { 
			return new TutorialCommand(ENUM_PASS, "turn off tutorial")
						.addAction(function turnOffTutorial_action():void {
							Tutorial.tutorialOn = false;
						}); 
		}
	}

}