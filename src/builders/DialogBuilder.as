package builders 
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
	public class DialogBuilder 
	{
		private static var instance:DialogBuilder;
		
		public function DialogBuilder(pass:SingletonEnforcer) 
		{
			if (pass == null) throw new IllegalOperationError("This class is a singleton. Use getInstance method to access it");
		}
		
		public static function getDialogListByID(stageID:String):Array
		{
			if (instance == null) instance = new DialogBuilder(new SingletonEnforcer());
			return instance["dialogList" + stageID];
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
				
				new DialogHelper("stage1_2.beginTutorial", [TutorialCommand.moveToItemBox,
													EventCommand.waitingForEvent(TutorialEvent.POWER_USED)]),	
				
				new DialogHelper("stage1_2.explainBalanceLine", [EventCommand.dispatchAnEvent(new TutorialEvent(TutorialEvent.UNLOCK_STAGE)), 
								EventCommand.dispatchAnEvent(new TutorialEvent(TutorialEvent.LOCK_DOUBLE_CLICK)), DialogCommand.allowSkip]),
				
		/*4*/	new DialogHelper("stage1_2.dropInItemBox", [TutorialCommand.moveDialogBoxUp, 
								EventCommand.waitingForEvent(TutorialEvent.GET_OUT_ITEMBOX)], [DialogPath.SKIP_ME]),					
								
				new DialogHelper("stage1_2.explainFoundation", [TutorialCommand.hideNPC, TutorialCommand.moveToItemBox,
								EventCommand.dispatchAnEvent(new TutorialEvent(TutorialEvent.CHECK_BALANCE_LINE)), 
								EventCommand.promptSuccessFailed(TutorialEvent.ON_BALANCE_POSITION, TutorialEvent.BACK_TO_ITEMBOX)]),
								
				new DialogHelper(DialogHelper.EMPTY, [DialogCommand.jumpToDialog(4)], [DialogPath.FAILED]),				
								
		/*7*/	new DialogHelper("stage1_2.readyToDrop", [EventCommand.promptSuccessFailed(TutorialEvent.BOOKS_RELEASED, TutorialEvent.OUT_FROM_BALANCE_ZONE), 
								EventCommand.dispatchAnEvent(new TutorialEvent(TutorialEvent.UNLOCK_DOUBLE_CLICK))], [DialogPath.SUCCESS]),				
								
				new DialogHelper(DialogHelper.EMPTY, [DialogCommand.jumpToDialog(12)], [DialogPath.FAILED]),
				
				new DialogHelper("stage1_2.waitForIt", [EventCommand.promptSuccessFailed(TutorialEvent.TUTORIAL_CLEAR, TutorialEvent.TUTORIAL_FAILED)
														,TutorialCommand.hideNPC], [DialogPath.SUCCESS]),
				
				new DialogHelper("stage1_2.gotTheStars", [DialogCommand.allowSkip], [DialogPath.SUCCESS]),
				new DialogHelper("stage1_2.didnotGetStars", [DialogCommand.allowSkip], [DialogPath.FAILED]),
		
		/*12*/	new DialogHelper("stage1_2.outOfZone", [EventCommand.promptSuccessFailed(TutorialEvent.ON_BALANCE_POSITION, TutorialEvent.BACK_TO_ITEMBOX), 
														TutorialCommand.hideNPC, EventCommand.dispatchAnEvent(new TutorialEvent(TutorialEvent.LOCK_DOUBLE_CLICK))], 
														[DialogPath.SKIP_ME]),
				
				new DialogHelper(DialogHelper.EMPTY, [DialogCommand.jumpToDialog(7)], [DialogPath.SUCCESS]),
				new DialogHelper(DialogHelper.EMPTY, [DialogCommand.jumpToDialog(4)], [DialogPath.FAILED]),
				
				new DialogHelper("stage1_2.limitedPower", [DialogCommand.allowSkip]),
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
				new DialogHelper("stage1_4.challenge", [DialogCommand.allowSkip]),
				new DialogHelper(DialogHelper.EMPTY, [EventCommand.promptSuccessFailed(TutorialEvent.TUTORIAL_CLEAR, TutorialEvent.TUTORIAL_FAILED),
														TutorialCommand.hideAll]),
				new DialogHelper("stage1_4.failed", [DialogCommand.allowSkip, DialogCommand.changePath(DialogPath.FAILED)], [DialogPath.FAILED]),
				new DialogHelper(DialogHelper.EMPTY, [EventCommand.dispatchAnEvent(new TutorialEvent(TutorialEvent.RESTART_TUTORIAL))], [DialogPath.FAILED]),
				new DialogHelper("stage1_4.success", [DialogCommand.allowSkip], [DialogPath.SUCCESS]),
				new DialogHelper(DialogHelper.EMPTY, [EventCommand.stop], [DialogPath.ALL_PATHS])
			];
	
//=============================================================================================================================================================================
		
		public function get dialogList1_5():Array { return _dialogList1_5; }
		private var _dialogList1_5:Array = 
			[
				new DialogHelper(DialogHelper.EMPTY, [TutorialCommand.hideAll, EventCommand.promptSuccessFailed(TutorialEvent.TUTORIAL_CLEAR, 
																				TutorialEvent.TUTORIAL_FAILED)]),
				
				new DialogHelper("stage1_5.failed", [DialogCommand.allowSkip, DialogCommand.changePath(DialogPath.FAILED)], [DialogPath.FAILED]),
				new DialogHelper(DialogHelper.EMPTY, [EventCommand.dispatchAnEvent(new TutorialEvent(TutorialEvent.RESTART_TUTORIAL))], [DialogPath.FAILED]),
				
				new DialogHelper("stage1_5.thatsIt", [DialogCommand.allowSkip], [DialogPath.SUCCESS]),
				new DialogHelper("stage1_5.meetAvia", [DialogCommand.allowSkip]),
				new DialogHelper("stage1_5.moreStars", [DialogCommand.allowSkip]),
				new DialogHelper("stage1_5.aviaPlace", [DialogCommand.allowSkip]),
				new DialogHelper("stage1_5.goodbye", [DialogCommand.allowSkip]),
				new DialogHelper(DialogHelper.EMPTY, [EventCommand.stop])
			];



//=======================================================================================================================================
//=======================================================================================================================================
		
		private var dialogList2_1:Array =
		[
			new DialogHelper("stage2_1.start", [DialogCommand.allowSkip, EventCommand.dispatchAnEvent(new TutorialEvent(TutorialEvent.LOCK_STAGE))]),
			new DialogHelper("stage2_1.second", [DialogCommand.allowSkip]),
			new DialogHelper(DialogHelper.EMPTY, [TutorialCommand.hideAll, EventCommand.promptSuccessFailed(TutorialEvent.TUTORIAL_CLEAR,
								TutorialEvent.TUTORIAL_FAILED), EventCommand.dispatchAnEvent(new TutorialEvent(TutorialEvent.UNLOCK_STAGE))]),
			new DialogHelper("stage2_1.fail", [DialogCommand.promptYesNo], [DialogPath.FAILED]),
			new DialogHelper(DialogHelper.EMPTY, [EventCommand.dispatchAnEvent(new TutorialEvent(TutorialEvent.RESTART_TUTORIAL))]),
			new DialogHelper("stage2_1.success", [DialogCommand.allowSkip], [DialogPath.SUCCESS]),
			new DialogHelper(DialogHelper.EMPTY, [EventCommand.stop], [DialogPath.ALL_PATHS])
		];
			
		private var dialogList2_2:Array =
		[
			new DialogHelper("stage2_2.start", [DialogCommand.allowSkip, EventCommand.dispatchAnEvent(new TutorialEvent(TutorialEvent.LOCK_STAGE))]),
			new DialogHelper("stage2_2.warning", [DialogCommand.allowSkip]),
			new DialogHelper(DialogHelper.EMPTY, [TutorialCommand.hideAll, EventCommand.promptSuccessFailed(TutorialEvent.TUTORIAL_CLEAR,
								TutorialEvent.TUTORIAL_FAILED), EventCommand.dispatchAnEvent(new TutorialEvent(TutorialEvent.UNLOCK_STAGE))]),
			new DialogHelper("stage2_2.fail", [DialogCommand.promptYesNo], [DialogPath.FAILED]),
			new DialogHelper(DialogHelper.EMPTY, [EventCommand.dispatchAnEvent(new TutorialEvent(TutorialEvent.RESTART_TUTORIAL))]),
			new DialogHelper("stage2_2.success", [DialogCommand.allowSkip], [DialogPath.SUCCESS]),
			new DialogHelper(DialogHelper.EMPTY, [EventCommand.stop], [DialogPath.ALL_PATHS])
		];
		
		private var dialogList2_3:Array =
		[
			new DialogHelper("stage2_3.start", [DialogCommand.allowSkip, EventCommand.dispatchAnEvent(new TutorialEvent(TutorialEvent.LOCK_STAGE))]),
			new DialogHelper("stage2_3.needClue", [DialogCommand.promptYesNo]),
			new DialogHelper("stage2_3.clue", [DialogCommand.allowSkip]),
			new DialogHelper("stage2_3.noClue", [DialogCommand.allowSkip], [DialogPath.ANSWER_NO]),
			new DialogHelper(DialogHelper.EMPTY, [TutorialCommand.hideAll, EventCommand.promptSuccessFailed(TutorialEvent.TUTORIAL_CLEAR,
								TutorialEvent.TUTORIAL_FAILED), EventCommand.dispatchAnEvent(new TutorialEvent(TutorialEvent.UNLOCK_STAGE))]
								[DialogPath.ALL_PATHS]),
			new DialogHelper("stage2_3.fail", [DialogCommand.promptYesNo], [DialogPath.FAILED]),
			new DialogHelper(DialogHelper.EMPTY, [EventCommand.dispatchAnEvent(new TutorialEvent(TutorialEvent.RESTART_TUTORIAL))]),
			new DialogHelper("stage2_3.success", [DialogCommand.allowSkip], [DialogPath.SUCCESS]),
			new DialogHelper(DialogHelper.EMPTY, [EventCommand.stop], [DialogPath.ALL_PATHS])
		]
				
	}
}
class SingletonEnforcer { }