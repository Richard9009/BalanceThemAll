package stages.Tutorials 
{
	import flash.errors.IllegalOperationError;
	import gameEvents.TutorialEvent;
	import org.flashdevelop.utils.FlashConnect;
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class TutorialDialogHandler 
	{
		private static const SINGLETON_PASS:String = "uwhd8e2HYUA27476297JSN";
		private static const INVALID:DialogHelper = new DialogHelper("INVALID DIALOG");
		
		private var dialogCol:DialogListCollection = DialogListCollection.getInstance();
		private var currentDialogID:int = 0;
		private var currentStageID:String = "1_1";
		
		private static var instance:TutorialDialogHandler;
										
		public function TutorialDialogHandler(pass:String) 
		{
			if (pass != SINGLETON_PASS) throw new IllegalOperationError("This class is a singleton. Use getInstance method to access it");
		}
		
		private function getDialogCode(stageID:String, dialogIndex:int):DialogHelper
		{
			var dialogArr:Array;
			
			switch(stageID) {
				case "1_1": dialogArr = dialogCol.dialogList1_1; break;
				default: return INVALID;
			}
		
			if (dialogArr[dialogIndex]) {
				currentDialogID = dialogIndex;
				currentStageID = stageID;
				return dialogArr[dialogIndex];
			}
			
			return INVALID;
		}
		
		public function getFirstDialog(stageID:String):DialogHelper
		{
			return getDialogCode(stageID, 0);
		}
		
		public function getNextDialog(heSaidYes:Boolean = true):DialogHelper
		{
			var dialog:DialogHelper = getDialogCode(currentStageID, currentDialogID + 1);
			
			if (dialog == INVALID) return dialog;
			
			if (heSaidYes && dialog.isForNoAnswer) {
				dialog = getNextDialog();
			} else if (!heSaidYes && !dialog.isForNoAnswer) {
				 dialog = getNextDialog(false);
			}
			
			return dialog;
		}
		
		public static function getInstance():TutorialDialogHandler
		{
			if (instance == null) instance = new TutorialDialogHandler(SINGLETON_PASS);
			return instance;
		}
	}
}

