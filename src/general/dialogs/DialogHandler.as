package general.dialogs 
{
	import flash.errors.IllegalOperationError;
	import gameEvents.TutorialEvent;
	import org.flashdevelop.utils.FlashConnect;
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class DialogHandler 
	{
		private static const INVALID:DialogHelper = new DialogHelper("INVALID DIALOG");
		
		private var dialogArr:Array;
		private var currentDialogID:int = 0;
										
		public function DialogHandler(dialogArray:Array) 
		{
			dialogArr = dialogArray;
		}
		
		private function getDialogCode(dialogIndex:int):DialogHelper
		{
			if (dialogArr[dialogIndex]) {
				currentDialogID = dialogIndex;
				return dialogArr[dialogIndex];
			}
			
			return INVALID;
		}
		
		public function jumpTo(dialogIndex:int):DialogHelper
		{
			return getDialogCode(dialogIndex);
		}
		
		public function getFirstDialog():DialogHelper
		{
			return getDialogCode(0);
		}
		
		public function getNextDialog(path:DialogPath):DialogHelper
		{
			var dialog:DialogHelper = getDialogCode(currentDialogID + 1);
			
			if (dialog == INVALID) return dialog;
			
			if (!dialog.inThisPath(path)) {
				dialog = getNextDialog(path);
			} 
			return dialog;
		}
		
		public function getPrevDialog(path:DialogPath):DialogHelper
		{
			var dialog:DialogHelper = getDialogCode(currentDialogID - 1);
			
			if (dialog == INVALID) return dialog;
			
			if (!dialog.inThisPath(path)) {
				dialog = getPrevDialog(path);
			} 
			
			return dialog;
		}
	}
}

