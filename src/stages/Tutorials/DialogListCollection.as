package stages.Tutorials 
{
	import flash.errors.IllegalOperationError;
	import gameEvents.TutorialEvent;
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class DialogListCollection 
	{
		private static var instance:DialogListCollection;
		
		public function DialogListCollection(pass:SingletonEnforcer) 
		{
			if (pass == null) throw new IllegalOperationError("This class is a singleton. Use getInstance method to access it");
		}
		
		public static function getInstance():DialogListCollection 
		{
			if (instance == null) instance = new DialogListCollection(new SingletonEnforcer());
			return instance;
		}
		
		public function get dialogList1_1():Array { return _dialogList1_1; } 
		private var _dialogList1_1:Array = 	
				[	
					new DialogHelper("stage1_1.greeting", [DialogCommand.promptYesNo]),
					new DialogHelper("stage1_1.beginTutorial", [DialogCommand.startTutorial]),
					new DialogHelper("stage1_1.dragBook", [DialogCommand.moveDialogBoxUp, 
															DialogCommand.waitingForEvent]).setEvent(TutorialEvent.DRAG_THE_BOOK), 
					new DialogHelper("stage1_1.dragItToMe", [DialogCommand.waitingForEvent]).setEvent(TutorialEvent.GET_OUT_ITEMBOX),
					new DialogHelper("stage1_1.releaseDrag", [DialogCommand.hideNPC, DialogCommand.moveToItemBox,
																DialogCommand.waitingForEvent]).setEvent(TutorialEvent.STOP_DRAG_BOOK),
					new DialogHelper("stage1_1.getAnotherBook", [DialogCommand.moveDialogBoxUp,
																DialogCommand.waitingForEvent]).setEvent(TutorialEvent.DRAG_THE_BOOK),
					new DialogHelper("stage1_1.getAnotherBook", [DialogCommand.waitingForEvent]).setEvent(TutorialEvent.GET_OUT_ITEMBOX),
					new DialogHelper("stage1_1.getAnotherBook", [DialogCommand.hideNPC, DialogCommand.moveToItemBox,
																DialogCommand.waitingForEvent]).setEvent(TutorialEvent.STOP_DRAG_BOOK),
					new DialogHelper("stage1_1.moveBookToStar", [DialogCommand.hideNPC, DialogCommand.drawStarLines,
																DialogCommand.waitingForEvent]).setEvent(TutorialEvent.READY_TO_DROP),
					new DialogHelper("stage1_1.releaseBooks", [DialogCommand.waitingForEvent]).setEvent(TutorialEvent.BOOKS_RELEASED),
					new DialogHelper("stage1_1.waitForIt", [DialogCommand.hideNPC, DialogCommand.promptSuccessFailed])
									.setSuccessEvent(TutorialEvent.TUTORIAL_CLEAR).setFailedEvent(TutorialEvent.TUTORIAL_FAILED),
					new DialogHelper("stage1_1.gotTheStars", null, [DialogPath.SUCCESS]),
					new DialogHelper("stage1_1.didnotGetStars", null, [DialogPath.FAILED]),
					new DialogHelper("stage1_1.noTutorial", [DialogCommand.turnOffTutorial], [DialogPath.SKIP_TUTORIAL]),
					new DialogHelper("", [DialogCommand.stop], [DialogPath.ALL_PATHS]) 
				];
	}

}

class SingletonEnforcer { }