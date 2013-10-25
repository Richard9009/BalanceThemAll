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
				new DialogHelper(DialogHelper.EMPTY, [TutorialCommand.hideAll, EventCommand.promptSuccessFailed
								(TutorialEvent.HANDS_ARE_FULL, TutorialEvent.TUTORIAL_FAILED)]),
				
				new DialogHelper("stage1_2.askNeedHelp", [DialogCommand.promptYesNo], [DialogPath.SUCCESS]),
			
				new DialogHelper("stage1_2.explainHand", [DialogCommand.allowSkip]),
				new DialogHelper("stage1_2.explainItemPanel", [DialogCommand.allowSkip]),
				new DialogHelper("stage1_2.explainWeight", [DialogCommand.allowSkip]),
				new DialogHelper("stage1_2.getStars", [DialogCommand.allowSkip, TutorialCommand.hideAll,
														EventCommand.promptSuccessFailed(TutorialEvent.TUTORIAL_CLEAR, TutorialEvent.TUTORIAL_FAILED)]),
				new DialogHelper("stage1_2.gotTheStars", [DialogCommand.allowSkip], [DialogPath.SUCCESS]),
				new DialogHelper("stage1_2.didnotGetStars", [DialogCommand.allowSkip], [DialogPath.FAILED]),
		
				new DialogHelper("stage1_2.skipTutorial", [EventCommand.dispatchAnEvent(new TutorialEvent(TutorialEvent.UNLOCK_STAGE)), 
															DialogCommand.allowSkip, TutorialCommand.turnOffTutorial], [DialogPath.ANSWER_NO]),
				new DialogHelper(DialogHelper.EMPTY, [EventCommand.stop], [DialogPath.ALL_PATHS])
			]
			
//============================================================================================================================================================================	

		public function get dialogList1_3():Array { return _dialogList1_3; }
		private var _dialogList1_3:Array = 
			[
				new DialogHelper(DialogHelper.EMPTY, [TutorialCommand.hideAll, EventCommand.promptSuccessFailed
												(TutorialEvent.HANDS_ARE_FULL, TutorialEvent.TUTORIAL_FAILED)]),
												
				new DialogHelper("stage1_3.askNeedHelp", [DialogCommand.promptYesNo, EventCommand.dispatchAnEvent(new TutorialEvent(TutorialEvent.LOCK_STAGE))],
											[DialogPath.SUCCESS]),
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
								TutorialEvent.TUTORIAL_FAILED), EventCommand.dispatchAnEvent(new TutorialEvent(TutorialEvent.UNLOCK_STAGE))]),
			new DialogHelper("stage2_3.fail", [DialogCommand.promptYesNo], [DialogPath.FAILED]),
			new DialogHelper(DialogHelper.EMPTY, [EventCommand.dispatchAnEvent(new TutorialEvent(TutorialEvent.RESTART_TUTORIAL))]),
			new DialogHelper("stage2_3.success", [DialogCommand.allowSkip], [DialogPath.SUCCESS]),
			new DialogHelper(DialogHelper.EMPTY, [EventCommand.stop], [DialogPath.ALL_PATHS])
		];
		
		private var dialogList2_4:Array =
		[
			new DialogHelper("stage2_4.start", [DialogCommand.allowSkip, EventCommand.dispatchAnEvent(new TutorialEvent(TutorialEvent.LOCK_STAGE))]),
			new DialogHelper(DialogHelper.EMPTY, [TutorialCommand.hideAll, EventCommand.promptSuccessFailed(TutorialEvent.TUTORIAL_CLEAR,
								TutorialEvent.TUTORIAL_FAILED), EventCommand.dispatchAnEvent(new TutorialEvent(TutorialEvent.UNLOCK_STAGE))]),
			new DialogHelper("stage2_4.fail", [DialogCommand.promptYesNo], [DialogPath.FAILED]),
			new DialogHelper(DialogHelper.EMPTY, [EventCommand.dispatchAnEvent(new TutorialEvent(TutorialEvent.RESTART_TUTORIAL))]),
			new DialogHelper("stage2_4.success", [DialogCommand.allowSkip], [DialogPath.SUCCESS]),
			new DialogHelper(DialogHelper.EMPTY, [EventCommand.stop], [DialogPath.ALL_PATHS])
		];
		
		private var dialogList2_5:Array =
		[
			new DialogHelper("stage2_5.start", [DialogCommand.allowSkip, EventCommand.dispatchAnEvent(new TutorialEvent(TutorialEvent.LOCK_STAGE))]),
			new DialogHelper("stage2_5.second", [DialogCommand.allowSkip]),
			new DialogHelper(DialogHelper.EMPTY, [TutorialCommand.hideAll, EventCommand.promptSuccessFailed(TutorialEvent.TUTORIAL_CLEAR,
								TutorialEvent.TUTORIAL_FAILED), EventCommand.dispatchAnEvent(new TutorialEvent(TutorialEvent.UNLOCK_STAGE))]),
			new DialogHelper("stage2_5.fail", [DialogCommand.promptYesNo], [DialogPath.FAILED]),
			new DialogHelper(DialogHelper.EMPTY, [EventCommand.dispatchAnEvent(new TutorialEvent(TutorialEvent.RESTART_TUTORIAL))]),
			new DialogHelper("stage2_5.success", [DialogCommand.allowSkip, DialogCommand.changePath(DialogPath.SUCCESS)], [DialogPath.SUCCESS]),
			new DialogHelper("stage2_5.emmi", [DialogCommand.allowSkip], [DialogPath.SUCCESS]),
			new DialogHelper("stage2_5.emmiLocation", [DialogCommand.allowSkip], [DialogPath.SUCCESS]),
			new DialogHelper("stage2_5.goodbye", [DialogCommand.allowSkip], [DialogPath.SUCCESS]),
			new DialogHelper(DialogHelper.EMPTY, [EventCommand.stop], [DialogPath.ALL_PATHS])
		];
	
	
	//===============================================================================================================================================
	//===============================================================================================================================================
	
		private var dialogList3_1:Array =
		[
			new DialogHelper("stage3_1.start", [DialogCommand.allowSkip, EventCommand.dispatchAnEvent(new TutorialEvent(TutorialEvent.LOCK_STAGE))]),
			new DialogHelper("stage3_1.second", [DialogCommand.allowSkip]),
			new DialogHelper("stage3_1.third", [DialogCommand.allowSkip]),
			new DialogHelper("stage3_1.fourth", [DialogCommand.allowSkip]),
			new DialogHelper(DialogHelper.EMPTY, [TutorialCommand.hideAll, EventCommand.promptSuccessFailed(TutorialEvent.TUTORIAL_CLEAR,
								TutorialEvent.TUTORIAL_FAILED), EventCommand.dispatchAnEvent(new TutorialEvent(TutorialEvent.UNLOCK_STAGE))]),
			new DialogHelper("stage3_1.fail", [DialogCommand.promptYesNo], [DialogPath.FAILED]),
			new DialogHelper(DialogHelper.EMPTY, [EventCommand.dispatchAnEvent(new TutorialEvent(TutorialEvent.RESTART_TUTORIAL))]),
			new DialogHelper("stage3_1.success", [DialogCommand.allowSkip], [DialogPath.SUCCESS]),
			new DialogHelper(DialogHelper.EMPTY, [EventCommand.stop], [DialogPath.ALL_PATHS])
		];
		
		private var dialogList3_2:Array = 
		[
			new DialogHelper("stage3_2.start", [DialogCommand.allowSkip, EventCommand.dispatchAnEvent(new TutorialEvent(TutorialEvent.LOCK_STAGE))]),
			new DialogHelper("stage3_2.second", [DialogCommand.allowSkip]),
			new DialogHelper(DialogHelper.EMPTY, [TutorialCommand.hideAll, EventCommand.promptSuccessFailed(TutorialEvent.TUTORIAL_CLEAR,
								TutorialEvent.TUTORIAL_FAILED), EventCommand.dispatchAnEvent(new TutorialEvent(TutorialEvent.UNLOCK_STAGE))]),
			new DialogHelper("stage3.fail", [DialogCommand.promptYesNo, TutorialCommand.hideNPC], [DialogPath.FAILED]),
			new DialogHelper(DialogHelper.EMPTY, [EventCommand.dispatchAnEvent(new TutorialEvent(TutorialEvent.RESTART_TUTORIAL))]),
			new DialogHelper("stage3_2.success", [DialogCommand.allowSkip], [DialogPath.SUCCESS]),
			new DialogHelper(DialogHelper.EMPTY, [EventCommand.stop], [DialogPath.ALL_PATHS])
		];
		
		private var dialogList3_3:Array = 
		[
			new DialogHelper("stage3_3.start", [DialogCommand.allowSkip, EventCommand.dispatchAnEvent(new TutorialEvent(TutorialEvent.LOCK_STAGE))]),
			new DialogHelper("stage3_3.second", [DialogCommand.allowSkip]),
			new DialogHelper(DialogHelper.EMPTY, [TutorialCommand.hideAll, EventCommand.promptSuccessFailed(TutorialEvent.TUTORIAL_CLEAR,
								TutorialEvent.TUTORIAL_FAILED), EventCommand.dispatchAnEvent(new TutorialEvent(TutorialEvent.UNLOCK_STAGE))]),
			new DialogHelper("stage3.fail", [DialogCommand.promptYesNo, TutorialCommand.hideNPC], [DialogPath.FAILED]),
			new DialogHelper(DialogHelper.EMPTY, [EventCommand.dispatchAnEvent(new TutorialEvent(TutorialEvent.RESTART_TUTORIAL))]),
			new DialogHelper("stage3_3.success", [DialogCommand.allowSkip], [DialogPath.SUCCESS]),
			new DialogHelper(DialogHelper.EMPTY, [EventCommand.stop], [DialogPath.ALL_PATHS])
		];
		
		private var dialogList3_4:Array = 
		[
			new DialogHelper("stage3_4.start", [DialogCommand.allowSkip, EventCommand.dispatchAnEvent(new TutorialEvent(TutorialEvent.LOCK_STAGE))]),
			new DialogHelper("stage3_4.second", [DialogCommand.allowSkip]),
			new DialogHelper(DialogHelper.EMPTY, [TutorialCommand.hideAll, EventCommand.promptSuccessFailed(TutorialEvent.TUTORIAL_CLEAR,
								TutorialEvent.TUTORIAL_FAILED), EventCommand.dispatchAnEvent(new TutorialEvent(TutorialEvent.UNLOCK_STAGE))]),
			new DialogHelper("stage3.fail", [DialogCommand.promptYesNo, TutorialCommand.hideNPC], [DialogPath.FAILED]),
			new DialogHelper(DialogHelper.EMPTY, [EventCommand.dispatchAnEvent(new TutorialEvent(TutorialEvent.RESTART_TUTORIAL))]),
			new DialogHelper("stage3_4.success", [DialogCommand.allowSkip], [DialogPath.SUCCESS]),
			new DialogHelper(DialogHelper.EMPTY, [EventCommand.stop], [DialogPath.ALL_PATHS])
		];
		
		private var dialogList3_5:Array = 
		[
			new DialogHelper("stage3_5.start", [DialogCommand.allowSkip, EventCommand.dispatchAnEvent(new TutorialEvent(TutorialEvent.LOCK_STAGE))]),
			new DialogHelper("stage3_5.second", [DialogCommand.allowSkip]),
			new DialogHelper("stage3_5.third", [DialogCommand.allowSkip]),
			new DialogHelper(DialogHelper.EMPTY, [TutorialCommand.hideAll, EventCommand.promptSuccessFailed(TutorialEvent.TUTORIAL_CLEAR,
								TutorialEvent.TUTORIAL_FAILED), EventCommand.dispatchAnEvent(new TutorialEvent(TutorialEvent.UNLOCK_STAGE))]),
			new DialogHelper("stage3.fail", [DialogCommand.promptYesNo, TutorialCommand.hideNPC], [DialogPath.FAILED]),
			new DialogHelper(DialogHelper.EMPTY, [EventCommand.dispatchAnEvent(new TutorialEvent(TutorialEvent.RESTART_TUTORIAL))]),
			new DialogHelper("stage3_5.success", [DialogCommand.allowSkip, DialogCommand.changePath(DialogPath.SUCCESS)], [DialogPath.SUCCESS]),
			new DialogHelper("stage3_5.brock", [DialogCommand.allowSkip], [DialogPath.SUCCESS]),
			new DialogHelper("stage3_5.brockLocation", [DialogCommand.allowSkip], [DialogPath.SUCCESS]),
			new DialogHelper("stage3_5.last", [DialogCommand.allowSkip], [DialogPath.SUCCESS]),
			new DialogHelper(DialogHelper.EMPTY, [EventCommand.stop], [DialogPath.ALL_PATHS])
		];
	}
}
class SingletonEnforcer { }