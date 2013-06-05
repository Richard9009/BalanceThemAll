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
		
// =======================================================================================================================================================================		
		
		public function get dialogList1_1():Array { return _dialogList1_1; } 
		private var _dialogList1_1:Array = 	
				[	
					new DialogHelper("stage1_1.greeting", [DialogCommand.promptYesNo]),
					
					new DialogHelper("stage1_1.beginTutorial", [DialogCommand.startTutorial, DialogCommand.dispatchAnEvent(TutorialEvent.LOCK_DOUBLE_CLICK)]),
					
					new DialogHelper("stage1_1.dragBook", [DialogCommand.moveDialogBoxUp, 
															DialogCommand.waitingForEvent(TutorialEvent.DRAG_THE_BOOK)]), 
					
					new DialogHelper("stage1_1.dragItToMe", [DialogCommand.moveDialogBoxUp, DialogCommand.waitingForEvent(TutorialEvent.GET_OUT_ITEMBOX)],
															[DialogPath.TUTORIAL, DialogPath.CATCH_RETURN]),
					
					new DialogHelper("stage1_1.releaseDrag", [DialogCommand.hideNPC, DialogCommand.moveToItemBox, 
											DialogCommand.promptSuccessFailed(TutorialEvent.STOP_DRAG_BOOK, TutorialEvent.BACK_TO_ITEMBOX)]),
					
					new DialogHelper(DialogHelper.EMPTY, [DialogCommand.previousTutorial()], [DialogPath.FAILED]),										
															
					new DialogHelper("stage1_1.getAnotherBook", [DialogCommand.moveDialogBoxUp, DialogCommand.waitingForEvent(TutorialEvent.DRAG_THE_BOOK)],
																[DialogPath.SUCCESS, DialogPath.CATCH_RETURN]),
					
					new DialogHelper("stage1_1.getAnotherBook", [DialogCommand.waitingForEvent(TutorialEvent.GET_OUT_ITEMBOX)]),
					
					new DialogHelper("stage1_1.getAnotherBook", [DialogCommand.hideNPC, DialogCommand.moveToItemBox, 
												DialogCommand.promptSuccessFailed(TutorialEvent.STOP_DRAG_BOOK, TutorialEvent.BACK_TO_ITEMBOX)]),
																									
					
					new DialogHelper("stage1_1.moveBookToStar", [DialogCommand.hideNPC, DialogCommand.dispatchAnEvent(TutorialEvent.DRAW_STAR_LINE) , 
											DialogCommand.promptSuccessFailed(TutorialEvent.READY_TO_DROP, TutorialEvent.BACK_TO_ITEMBOX)], [DialogPath.SUCCESS]),
					
					new DialogHelper("stage1_1.releaseBooks", [DialogCommand.promptSuccessFailed(TutorialEvent.BOOKS_RELEASED, TutorialEvent.BACK_TO_ITEMBOX), 
												DialogCommand.dispatchAnEvent(TutorialEvent.UNLOCK_DOUBLE_CLICK), DialogCommand.hideNPC], [DialogPath.SUCCESS]),
					
					new DialogHelper(DialogHelper.EMPTY, [DialogCommand.previousTutorial()], [DialogPath.FAILED]),
					
					new DialogHelper("stage1_1.waitForIt", [DialogCommand.hideNPC, 
									DialogCommand.promptSuccessFailed(TutorialEvent.TUTORIAL_CLEAR, TutorialEvent.TUTORIAL_FAILED)], [DialogPath.SUCCESS])
									,
					
					new DialogHelper("stage1_1.gotTheStars", null, [DialogPath.SUCCESS]),
					
					new DialogHelper("stage1_1.didnotGetStars", null, [DialogPath.FAILED]),
					
					new DialogHelper("stage1_1.noTutorial", [DialogCommand.turnOffTutorial], [DialogPath.SKIP_TUTORIAL]),
					
					new DialogHelper(DialogHelper.EMPTY, [DialogCommand.stop], [DialogPath.ALL_PATHS]) 
				];
				
//=====================================================================================================================================================================

		public function get dialogList1_2():Array { return _dialogList1_2; }
		private var _dialogList1_2:Array = 
			[
				new DialogHelper(DialogHelper.EMPTY, [DialogCommand.hideAll, DialogCommand.waitingForEvent(TutorialEvent.HANDS_ARE_FULL)]),
				
				new DialogHelper("stage1_2.askNeedHelp", [DialogCommand.promptYesNo, DialogCommand.dispatchAnEvent(TutorialEvent.LOCK_STAGE)]),
				
				new DialogHelper("stage1_2.beginTutorial", [DialogCommand.dispatchAnEvent(TutorialEvent.UNLOCK_STAGE), 
								DialogCommand.startTutorial, DialogCommand.dispatchAnEvent(TutorialEvent.LOCK_DOUBLE_CLICK)]),
				
				new DialogHelper("stage1_2.dropInItemBox", [DialogCommand.moveDialogBoxUp, 
								DialogCommand.waitingForEvent(TutorialEvent.GET_OUT_ITEMBOX)], [DialogPath.CATCH_RETURN]),		
				
				new DialogHelper("stage1_2.explainFoundation", [DialogCommand.hideNPC, DialogCommand.moveToItemBox,
								DialogCommand.dispatchAnEvent(TutorialEvent.CHECK_BALANCE_LINE), 
								DialogCommand.promptSuccessFailed(TutorialEvent.ON_BALANCE_POSITION, TutorialEvent.BACK_TO_ITEMBOX)]),
			
		//Success - Fail pair start-----------------------						
				new DialogHelper("stage1_2.readyToDrop", [DialogCommand.promptSuccessFailed(TutorialEvent.BOOKS_RELEASED, TutorialEvent.OUT_FROM_BALANCE_ZONE), 
									DialogCommand.dispatchAnEvent(TutorialEvent.UNLOCK_DOUBLE_CLICK)], [DialogPath.SUCCESS]),				
								
				new DialogHelper(DialogHelper.EMPTY, [DialogCommand.previousTutorial()], [DialogPath.FAILED]),
		//End-----------------------------------------------
	
		//Success - Fail pair start----------------------------																										
		//new DialogHelper("stage1_2.waitForIt", [DialogCommand.promptSuccessFailed(TutorialEvent.TUTORIAL_CLEAR, TutorialEvent.TUTORIAL_FAILED)
				new DialogHelper("stage1_2.outOfZone", [DialogCommand.promptSuccessFailed(TutorialEvent.ON_BALANCE_POSITION, TutorialEvent.BACK_TO_ITEMBOX), 
													DialogCommand.dispatchAnEvent(TutorialEvent.LOCK_DOUBLE_CLICK)], [DialogPath.FAILED])
				
				
			]
	}

}

class SingletonEnforcer { }