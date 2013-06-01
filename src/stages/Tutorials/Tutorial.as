package stages.Tutorials 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import gameEvents.TutorialEvent;
	import locales.LocalesTextField;
	import org.flashdevelop.utils.FlashConnect;
	import stages.StageBaseClass;
	
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class Tutorial extends DialogBox 
	{
		private const TFIELD_GAP:int = 35;
		private var tField:LocalesTextField;
		private var dialogHandler:TutorialDialogHandler;
		
		public function Tutorial() 
		{
			dialogHandler = TutorialDialogHandler.getInstance();
			addEventListener(Event.ADDED_TO_STAGE, creationComplete);
			yesButton.addEventListener(MouseEvent.CLICK, nextDialog);
			noButton.addEventListener(MouseEvent.CLICK, handleNo);
		}
		
		private function handleNo(e:MouseEvent):void 
		{
			displayDialog(dialogHandler.getNextDialog(false));
		}
		
		private function nextDialog(e:MouseEvent):void 
		{
			displayDialog(dialogHandler.getNextDialog());
		}
		
		private function displayDialog(dialog:DialogHelper):void
		{
			handleDialogCommand(dialog.command);
			tField.setLocaleText(dialog.code);
		}
		
		private function handleDialogCommand(command:DialogCommand):void
		{
			setDefaultCondition();
			
			switch(command) {
				case DialogCommand.promptYesNo: yesButton.visible = true;
												noButton.visible = true;
												removeEventListener(MouseEvent.CLICK, nextDialog);
												break;
				
				case DialogCommand.stop: parent.removeChild(this); break;
			}
		}
		
		private function setDefaultCondition():void
		{
			yesButton.visible = false;
			noButton.visible = false;
			if (hasEventListener(MouseEvent.CLICK))
				addEventListener(MouseEvent.CLICK, nextDialog);
		}
		
		private function creationComplete(e:Event):void 
		{
			x = StageBaseClass.STAGE_WIDTH / 2;
			y = StageBaseClass.STAGE_HEIGHT - height / 2;

			tField = new LocalesTextField("");
			addChild(tField);
			tField.x = -width / 2 + TFIELD_GAP;
			tField.y = -height / 2 + TFIELD_GAP;
			tField.width = width - TFIELD_GAP * 2;
			tField.height = height - TFIELD_GAP * 2;
			
			displayDialog(dialogHandler.getFirstDialog("1_1"));
		}
		
	}

}