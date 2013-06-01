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
					new DialogHelper("stage1_1.greeting", false, [DialogCommand.promptYesNo, DialogCommand.moveToItemBox]),
					new DialogHelper("stage1_1.beginTutorial"),
					new DialogHelper("stage1_1.dragBook", false, [	DialogCommand.moveDialogBoxUp, 
																	DialogCommand.waitingForEvent]).setEvent(TutorialEvent.DRAG_THE_BOOK), 
					new DialogHelper("stage1_1.dragItToMe", false, [DialogCommand.waitingForEvent]).setEvent(TutorialEvent.GET_OUT_ITEMBOX),
					new DialogHelper("stage1_1.noTutorial", true),
					new DialogHelper("", false, [DialogCommand.stop]) 
				];
	}

}

class SingletonEnforcer { }