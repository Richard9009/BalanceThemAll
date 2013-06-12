package stages.Tutorials 
{
	import flash.errors.IllegalOperationError;
	import gameEvents.TutorialEvent;
	import general.dialogs.*;
	import general.dialogs.commands.*;
	import stages.Tutorials.TutorialCommand;
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
		
		public static function getDialogListByID(stageID:String):Array
		{
			if (instance == null) instance = new DialogListCollection(new SingletonEnforcer());
			switch(stageID) {
				case "1_1": return instance.dialogList1_1;
				case "1_2": return instance.dialogList1_2;
				case "1_3": return instance.dialogList1_3;
				case "1_4": return instance.dialogList1_4;
				default: return new Array();
			}
		}
		
// =======================================================================================================================================================================		
	
		public function get dialogList1_1():Array { return _dialogList1_1; } 
		private var _dialogList1_1:Array = 	
				[	
					new DialogHelper("stage1_1.greeting", [DialogCommand.promptYesNo]),
					
					new DialogHelper("stage1_1.beginTutorial", [EventCommand.dispatchAnEvent(new TutorialEvent(TutorialEvent.LOCK_DOUBLE_CLICK)), DialogCommand.allowSkip]),
					
					new DialogHelper("stage1_1.dragBook", [TutorialCommand.moveDialogBoxUp, 
															EventCommand.waitingForEvent(TutorialEvent.DRAG_THE_BOOK)]), 
					
			/*3*/	new DialogHelper("stage1_1.dragItToMe", [TutorialCommand.moveDialogBoxUp, EventCommand.waitingForEvent(TutorialEvent.GET_OUT_ITEMBOX)]),
					
					new DialogHelper("stage1_1.releaseDrag", [TutorialCommand.hideNPC, TutorialCommand.moveToItemBox, 
											EventCommand.promptSuccessFailed(TutorialEvent.STOP_DRAG_BOOK, TutorialEvent.BACK_TO_ITEMBOX)]),
					
					new DialogHelper(DialogHelper.EMPTY, [DialogCommand.jumpToDialog(3)], [DialogPath.FAILED]),										
															
					new DialogHelper("stage1_1.getAnotherBook", [TutorialCommand.moveDialogBoxUp, EventCommand.waitingForEvent(TutorialEvent.DRAG_THE_BOOK)],
																[DialogPath.SUCCESS]),
					
			/*7*/	new DialogHelper("stage1_1.getAnotherBook", [TutorialCommand.moveDialogBoxUp, EventCommand.waitingForEvent(TutorialEvent.GET_OUT_ITEMBOX)]),
					
					new DialogHelper("stage1_1.getAnotherBook", [TutorialCommand.hideNPC, TutorialCommand.moveToItemBox, 
												EventCommand.promptSuccessFailed(TutorialEvent.STOP_DRAG_BOOK, TutorialEvent.BACK_TO_ITEMBOX)]),
																									
					
					new DialogHelper("stage1_1.moveBookToStar", [TutorialCommand.hideNPC, EventCommand.dispatchAnEvent(new TutorialEvent(TutorialEvent.DRAW_STAR_LINE)) , 
											EventCommand.promptSuccessFailed(TutorialEvent.READY_TO_DROP, TutorialEvent.BACK_TO_ITEMBOX)], [DialogPath.SUCCESS]),
					
					new DialogHelper("stage1_1.releaseBooks", [EventCommand.promptSuccessFailed(TutorialEvent.BOOKS_RELEASED, TutorialEvent.BACK_TO_ITEMBOX), 
												EventCommand.dispatchAnEvent(new TutorialEvent(TutorialEvent.UNLOCK_DOUBLE_CLICK)), TutorialCommand.hideNPC], [DialogPath.SUCCESS]),
					
					new DialogHelper(DialogHelper.EMPTY, [DialogCommand.jumpToDialog(7)], [DialogPath.FAILED]),
					
					new DialogHelper("stage1_1.waitForIt", [TutorialCommand.hideNPC, 
									EventCommand.promptSuccessFailed(TutorialEvent.TUTORIAL_CLEAR, TutorialEvent.TUTORIAL_FAILED)], [DialogPath.SUCCESS])
									,
					
					new DialogHelper("stage1_1.gotTheStars", [DialogCommand.allowSkip], [DialogPath.SUCCESS]),
					
					new DialogHelper("stage1_1.didnotGetStars", [DialogCommand.allowSkip], [DialogPath.FAILED]),
					
					new DialogHelper("stage1_1.noTutorial", [TutorialCommand.turnOffTutorial, DialogCommand.allowSkip], [DialogPath.ANSWER_NO]),
					
					new DialogHelper(DialogHelper.EMPTY, [EventCommand.stop], [DialogPath.ALL_PATHS]) 
				];
				
//=====================================================================================================================================================================

		public function get dialogList1_2():Array { return _dialogList1_2; }
		private var _dialogList1_2:Array = 
			[
				new DialogHelper(DialogHelper.EMPTY, [TutorialCommand.hideAll, EventCommand.waitingForEvent(TutorialEvent.HANDS_ARE_FULL)]),
				
				new DialogHelper("stage1_2.askNeedHelp", [DialogCommand.promptYesNo, EventCommand.dispatchAnEvent(new TutorialEvent(TutorialEvent.LOCK_STAGE))]),
				
				new DialogHelper("stage1_2.beginTutorial", [EventCommand.dispatchAnEvent(new TutorialEvent(TutorialEvent.UNLOCK_STAGE)), 
								EventCommand.dispatchAnEvent(new TutorialEvent(TutorialEvent.LOCK_DOUBLE_CLICK)), DialogCommand.allowSkip]),
				
		/*3*/	new DialogHelper("stage1_2.dropInItemBox", [TutorialCommand.moveDialogBoxUp, 
								EventCommand.waitingForEvent(TutorialEvent.GET_OUT_ITEMBOX)], [DialogPath.SKIP_ME]),		
				
				new DialogHelper("stage1_2.explainFoundation", [TutorialCommand.hideNPC, TutorialCommand.moveToItemBox,
								EventCommand.dispatchAnEvent(new TutorialEvent(TutorialEvent.CHECK_BALANCE_LINE)), 
								EventCommand.promptSuccessFailed(TutorialEvent.ON_BALANCE_POSITION, TutorialEvent.BACK_TO_ITEMBOX)]),
								
				new DialogHelper(DialogHelper.EMPTY, [DialogCommand.jumpToDialog(3)], [DialogPath.FAILED]),				
								
		/*6*/	new DialogHelper("stage1_2.readyToDrop", [EventCommand.promptSuccessFailed(TutorialEvent.BOOKS_RELEASED, TutorialEvent.OUT_FROM_BALANCE_ZONE), 
								EventCommand.dispatchAnEvent(new TutorialEvent(TutorialEvent.UNLOCK_DOUBLE_CLICK))], [DialogPath.SUCCESS]),				
								
				new DialogHelper(DialogHelper.EMPTY, [DialogCommand.jumpToDialog(11)], [DialogPath.FAILED]),
				
				new DialogHelper("stage1_2.waitForIt", [EventCommand.promptSuccessFailed(TutorialEvent.TUTORIAL_CLEAR, TutorialEvent.TUTORIAL_FAILED)
														,TutorialCommand.hideNPC], [DialogPath.SUCCESS]),
				
				new DialogHelper("stage1_2.gotTheStars", [DialogCommand.allowSkip], [DialogPath.SUCCESS]),
				new DialogHelper("stage1_2.didnotGetStars", [DialogCommand.allowSkip], [DialogPath.FAILED]),
		
		/*11*/	new DialogHelper("stage1_2.outOfZone", [EventCommand.promptSuccessFailed(TutorialEvent.ON_BALANCE_POSITION, TutorialEvent.BACK_TO_ITEMBOX), 
														TutorialCommand.hideNPC, EventCommand.dispatchAnEvent(new TutorialEvent(TutorialEvent.LOCK_DOUBLE_CLICK))], 
														[DialogPath.SKIP_ME]),
				
				new DialogHelper(DialogHelper.EMPTY, [DialogCommand.jumpToDialog(6)], [DialogPath.SUCCESS]),
				new DialogHelper(DialogHelper.EMPTY, [DialogCommand.jumpToDialog(3)], [DialogPath.FAILED]),
				new DialogHelper("stage1_2.skipTutorial", [EventCommand.dispatchAnEvent(new TutorialEvent(TutorialEvent.UNLOCK_STAGE)), 
															DialogCommand.allowSkip, TutorialCommand.turnOffTutorial], [DialogPath.ANSWER_NO]),
				new DialogHelper(DialogHelper.EMPTY, [EventCommand.stop], [DialogPath.ALL_PATHS])
			]
			
//============================================================================================================================================================================	

		public function get dialogList1_3():Array { return _dialogList1_3; }
		private var _dialogList1_3:Array = 
			[
				new DialogHelper(DialogHelper.EMPTY, [TutorialCommand.hideAll, EventCommand.waitingForEvent(TutorialEvent.HANDS_ARE_FULL)]),
				new DialogHelper("stage1_3.askNeedHelp", [DialogCommand.promptYesNo, EventCommand.dispatchAnEvent(new TutorialEvent(TutorialEvent.LOCK_STAGE))]),
				new DialogHelper("stage1_3.beginTutorial", [EventCommand.dispatchAnEvent(new TutorialEvent(TutorialEvent.UNLOCK_STAGE)), 
															EventCommand.dispatchAnEvent(new TutorialEvent(TutorialEvent.LOCK_DOUBLE_CLICK)),
															EventCommand.waitingForEvent(TutorialEvent.OBJECT_POINTED)]),
				new DialogHelper("stage1_3.rotateIt", [EventCommand.waitingForEvent(TutorialEvent.OBJECT_ROTATED), TutorialCommand.hideNPC]),
				new DialogHelper("stage1_3.rotateSuccess", [DialogCommand.allowSkip, EventCommand.dispatchAnEvent(new TutorialEvent(TutorialEvent.UNLOCK_DOUBLE_CLICK)),
															TutorialCommand.turnOffTutorial]),
				new DialogHelper("stage1_3.skipTutorial", [EventCommand.dispatchAnEvent(new TutorialEvent(TutorialEvent.UNLOCK_STAGE)), DialogCommand.allowSkip,
															EventCommand.dispatchAnEvent(new TutorialEvent(TutorialEvent.UNLOCK_DOUBLE_CLICK)),
															TutorialCommand.turnOffTutorial], [DialogPath.ANSWER_NO]),
				new DialogHelper(DialogHelper.EMPTY, [EventCommand.stop], [DialogPath.ALL_PATHS])
			];
			
//============================================================================================================================================================================
		public function get dialogList1_4():Array { return _dialogList1_4; }
		private var _dialogList1_4:Array = 
			[
				new DialogHelper("stage1_4.lastDialog", [DialogCommand.allowSkip]),
				new DialogHelper(DialogHelper.EMPTY, [EventCommand.stop])
			];
	}

}

class SingletonEnforcer { }