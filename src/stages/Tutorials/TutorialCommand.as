package stages.Tutorials 
{
	import general.dialogs.commands.BaseCommandClass;
	import stages.Tutorials.Tutorial;
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class TutorialCommand extends BaseCommandClass
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
		
		
		//=======================================================================================================
		
		public static function get hideAll():TutorialCommand { 
			return new TutorialCommand(ENUM_PASS, "hide all tutorial")
						.addAction( function hideAll_action():void { tutorial.visible = false });
		}
		
		public static function get turnOffTutorial():TutorialCommand { 
			return new TutorialCommand(ENUM_PASS, "turn off tutorial")
						.addAction(function turnOffTutorial_action():void {
							Tutorial.tutorialOn = false;
						}); 
		}
		
		public static function get hideNPC():TutorialCommand {
			return new TutorialCommand(ENUM_PASS, "hide npc")
					.addAction(function hideNPC_action():void {
						tutorial.npc.visible = false;
					}); 
		}
		
		public static function get moveDialogBoxUp():TutorialCommand { 
			return new TutorialCommand(ENUM_PASS, "move dialog box up")
					.addAction(function moveDialogBoxUp_action():void {
						tutorial.moveTo(Tutorial.ABOVE_ITEM_BOX);
					}); 
		}
		public static function get moveToItemBox():TutorialCommand { 
			return new TutorialCommand(ENUM_PASS, "move dialog box up")
					.addAction(function moveToItemBox_action():void {
						tutorial.moveTo(Tutorial.ON_ITEM_BOX);
					});
		}
	}

}