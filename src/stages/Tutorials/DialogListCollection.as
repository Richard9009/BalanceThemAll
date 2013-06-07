package stages.Tutorials 
{
	import flash.errors.IllegalOperationError;
	import gameEvents.TutorialEvent;
	import stages.Tutorials.commands.DialogCommand;
	import stages.Tutorials.commands.EventCommand;
	import stages.Tutorials.commands.TutorialCommand;
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
		
// =======================================================================================================================================================================		
	
		public function get dialogList1_1():Array { return _dialogList1_1; } 
		private var _dialogList1_1:Array = 	
				[	
					new DialogHelper("stage1_1.greeting", [TutorialCommand.promptYesNo]),
					
					new DialogHelper("stage1_1.beginTutorial", [DialogCommand.dispatchAnEvent(TutorialEvent.LOCK_DOUBLE_CLICK)]),
					
					new DialogHelper("stage1_1.dragBook", [TutorialCommand.moveDialogBoxUp, 
															EventCommand.waitingForEvent(TutorialEvent.DRAG_THE_BOOK)]), 
					
			/*3*/	new DialogHelper("stage1_1.dragItToMe", [TutorialCommand.moveDialogBoxUp, EventCommand.waitingForEvent(TutorialEvent.GET_OUT_ITEMBOX)]),
					
					new DialogHelper("stage1_1.releaseDrag", [TutorialCommand.hideNPC, TutorialCommand.moveToItemBox, 
											DialogCommand.promptSuccessFailed(TutorialEvent.STOP_DRAG_BOOK, TutorialEvent.BACK_TO_ITEMBOX)]),
					
					new DialogHelper(DialogHelper.EMPTY, [DialogCommand.jumpToDialog(3)], [DialogPath.FAILED]),										
															
					new DialogHelper("stage1_1.getAnotherBook", [TutorialCommand.moveDialogBoxUp, EventCommand.waitingForEvent(TutorialEvent.DRAG_THE_BOOK)],
																[DialogPath.SUCCESS]),
					
			/*7*/	new DialogHelper("stage1_1.getAnotherBook", [TutorialCommand.moveDialogBoxUp, EventCommand.waitingForEvent(TutorialEvent.GET_OUT_ITEMBOX)]),
					
					new DialogHelper("stage1_1.getAnotherBook", [TutorialCommand.hideNPC, TutorialCommand.moveToItemBox, 
												DialogCommand.promptSuccessFailed(TutorialEvent.STOP_DRAG_BOOK, TutorialEvent.BACK_TO_ITEMBOX)]),
																									
					
					new DialogHelper("stage1_1.moveBookToStar", [TutorialCommand.hideNPC, DialogCommand.dispatchAnEvent(TutorialEvent.DRAW_STAR_LINE) , 
											DialogCommand.promptSuccessFailed(TutorialEvent.READY_TO_DROP, TutorialEvent.BACK_TO_ITEMBOX)], [DialogPath.SUCCESS]),
					
					new DialogHelper("stage1_1.releaseBooks", [DialogCommand.promptSuccessFailed(TutorialEvent.BOOKS_RELEASED, TutorialEvent.BACK_TO_ITEMBOX), 
												DialogCommand.dispatchAnEvent(TutorialEvent.UNLOCK_DOUBLE_CLICK), TutorialCommand.hideNPC], [DialogPath.SUCCESS]),
					
					new DialogHelper(DialogHelper.EMPTY, [DialogCommand.jumpToDialog(7)], [DialogPath.FAILED]),
					
					new DialogHelper("stage1_1.waitForIt", [TutorialCommand.hideNPC, 
									DialogCommand.promptSuccessFailed(TutorialEvent.TUTORIAL_CLEAR, TutorialEvent.TUTORIAL_FAILED)], [DialogPath.SUCCESS])
									,
					
					new DialogHelper("stage1_1.gotTheStars", null, [DialogPath.SUCCESS]),
					
					new DialogHelper("stage1_1.didnotGetStars", null, [DialogPath.FAILED]),
					
		new DialogHelper("stage1_1.noTutorial", [TutorialCommand.turnOffTutorial], [DialogPath.SKIP_TUTORIAL]),
					
					new DialogHelper(DialogHelper.EMPTY, [DialogCommand.stop], [DialogPath.ALL_PATHS]) 
				];
				
//=====================================================================================================================================================================

		public function get dialogList1_2():Array { return _dialogList1_2; }
		private var _dialogList1_2:Array = 
			[
				new DialogHelper(DialogHelper.EMPTY, [TutorialCommand.hideAll, EventCommand.waitingForEvent(TutorialEvent.HANDS_ARE_FULL)]),
				
				new DialogHelper("stage1_2.askNeedHelp", [TutorialCommand.promptYesNo, DialogCommand.dispatchAnEvent(TutorialEvent.LOCK_STAGE)]),
				
				new DialogHelper("stage1_2.beginTutorial", [DialogCommand.dispatchAnEvent(TutorialEvent.UNLOCK_STAGE), 
								 DialogCommand.dispatchAnEvent(TutorialEvent.LOCK_DOUBLE_CLICK)]),
				
		/*3*/	new DialogHelper("stage1_2.dropInItemBox", [TutorialCommand.moveDialogBoxUp, 
								EventCommand.waitingForEvent(TutorialEvent.GET_OUT_ITEMBOX)], [DialogPath.SKIP_ME]),		
				
				new DialogHelper("stage1_2.explainFoundation", [TutorialCommand.hideNPC, TutorialCommand.moveToItemBox,
								DialogCommand.dispatchAnEvent(TutorialEvent.CHECK_BALANCE_LINE), 
								DialogCommand.promptSuccessFailed(TutorialEvent.ON_BALANCE_POSITION, TutorialEvent.BACK_TO_ITEMBOX)]),
				
								
				new DialogHelper(DialogHelper.EMPTY, [DialogCommand.jumpToDialog(3)], [DialogPath.FAILED]),				
								
		/*6*/	new DialogHelper("stage1_2.readyToDrop", [DialogCommand.promptSuccessFailed(TutorialEvent.BOOKS_RELEASED, TutorialEvent.OUT_FROM_BALANCE_ZONE), 
								DialogCommand.dispatchAnEvent(TutorialEvent.UNLOCK_DOUBLE_CLICK)], [DialogPath.SUCCESS]),				
								
				new DialogHelper(DialogHelper.EMPTY, [DialogCommand.jumpToDialog(11)], [DialogPath.FAILED]),
				
				new DialogHelper("stage1_2.waitForIt", [DialogCommand.promptSuccessFailed(TutorialEvent.TUTORIAL_CLEAR, TutorialEvent.TUTORIAL_FAILED)
														,TutorialCommand.hideNPC], [DialogPath.SUCCESS]),
				
				new DialogHelper("stage1_2.gotTheStars", null, [DialogPath.SUCCESS]),
				new DialogHelper("stage1_2.didnotGetStars", null, [DialogPath.FAILED]),
		
		/*11*/	new DialogHelper("stage1_2.outOfZone", [DialogCommand.promptSuccessFailed(TutorialEvent.ON_BALANCE_POSITION, TutorialEvent.BACK_TO_ITEMBOX), 
														TutorialCommand.hideNPC, DialogCommand.dispatchAnEvent(TutorialEvent.LOCK_DOUBLE_CLICK)], [DialogPath.SKIP_ME]),
				
				new DialogHelper(DialogHelper.EMPTY, [DialogCommand.jumpToDialog(6)], [DialogPath.SUCCESS]),
				new DialogHelper(DialogHelper.EMPTY, [DialogCommand.jumpToDialog(3)], [DialogPath.FAILED]),
				new DialogHelper("stage1_2.skipTutorial", [DialogCommand.dispatchAnEvent(TutorialEvent.UNLOCK_STAGE), TutorialCommand.turnOffTutorial], [DialogPath.SKIP_TUTORIAL]),
				new DialogHelper(DialogHelper.EMPTY, [DialogCommand.stop], [DialogPath.ALL_PATHS])
			]
	}

}

class SingletonEnforcer { }