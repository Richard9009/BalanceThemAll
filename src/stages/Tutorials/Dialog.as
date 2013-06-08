package stages.Tutorials 
{
	import assets.AssetCollection;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import gameEvents.TutorialEvent;
	import stages.StageBaseClass;
	import stages.Tutorials.commands.TutorialCommand;

	import locales.LocalesTextField;
	import org.flashdevelop.utils.FlashConnect;
	
	import stages.Tutorials.commands.DialogCommand;
	import stages.Tutorials.commands.EventCommand;
	import stages.Tutorials.commands.EventCommandEvent;
	
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class Dialog extends DialogBox 
	{
		private static const TFIELD_GAP:int = 35;
		
		private var tField:LocalesTextField;
		private var dialogHandler:TutorialDialogHandler;
		private var eventHandler:TutorialEventDispatcher = TutorialEventDispatcher.getInstance();
		private var id:String;
		
		protected var dialogBoxHeight:Number = 0;
		protected var collection:AssetCollection = new AssetCollection();
		
		public function Dialog(stageID:String) 
		{
			dialogHandler = TutorialDialogHandler.getInstance();
			addEventListener(Event.ADDED_TO_STAGE, creationComplete);
			
			yesButton.addEventListener(MouseEvent.CLICK, nextDialog);
			noButton.addEventListener(MouseEvent.CLICK, handleNo);
			
			eventHandler.addEventListener(EventCommandEvent.WAITING_COMPLETE, nextDialog);
			eventHandler.addEventListener(EventCommandEvent.SUCCESS, nextSuccessDialog);
			eventHandler.addEventListener(EventCommandEvent.FAILED, nextFailedDialog);
			
			id = stageID;
		}
		
		public function lockSkipDialog():void {
			if(hasEventListener(MouseEvent.MOUSE_DOWN)) {
				removeEventListener(MouseEvent.MOUSE_DOWN, nextDialog);
				clickClue.visible = false;
			}
			else if (clickClue.visible) clickClue.visible = false;
		}
		
		public function allowSkipDialog():void {
			if (!hasEventListener(MouseEvent.MOUSE_DOWN)) {
				clickClue.visible = true;
				addEventListener(MouseEvent.MOUSE_DOWN, nextDialog);
			}
		}
		
		private function handleNo(e:MouseEvent):void 
		{
			displayDialog(dialogHandler.getNextDialog(DialogPath.SKIP_TUTORIAL));
		}
		
		private function displayDialog(dialog:DialogHelper):void
		{
			setDefaultCondition();
			
			for each(var command:DialogCommand in dialog.commands) 
			{	
				handleDialogCommand(command);
			}

			if(!dialog.isEmpty) tField.setLocaleText(dialog.code);
		}
		
		private function handleDialogCommand(command:DialogCommand):void
		{
			if (command is TutorialCommand || command is EventCommand) 
			{
				command.executeAllActions();
			}
			
			switch(command.commandType) {		
													
				case DialogCommand.jumpToDialog().commandType: 	displayDialog(dialogHandler.jumpTo(command.dialogIndex)); break;
		
				case DialogCommand.stop.commandType: 	eventHandler.dispatchEvent(new TutorialEvent(TutorialEvent.CLOSE_TUTORIAL));
														eventHandler.forgetAllEvents();
														parent.removeChild(this); break;
														
				case DialogCommand.allowSkip.commandType: allowSkipDialog(); break;
				
				default: return;
			}
		}
		
		private function nextDialog(e:Event):void 
		{
			displayDialog(dialogHandler.getNextDialog(DialogPath.TUTORIAL));
		}
		
		private function nextFailedDialog(e:EventCommandEvent):void 
		{
			displayDialog(dialogHandler.getNextDialog(DialogPath.FAILED));
		}
		
		private function nextSuccessDialog(e:EventCommandEvent):void 
		{
			displayDialog(dialogHandler.getNextDialog(DialogPath.SUCCESS));
		}
	
		protected function setDefaultCondition():void
		{
			visible = true;
			yesButton.visible = false;
			noButton.visible = false; 
			clickClue.visible = true;
			
			parent.setChildIndex(this, parent.numChildren - 1);
			lockSkipDialog();
		}
		
		
		protected function initiateDialog():void
		{
			var preparation:Timer = new Timer(25, 1);
			preparation.addEventListener(TimerEvent.TIMER, function complete(e:TimerEvent):void {
											preparation.stop();
											preparation.removeEventListener(TimerEvent.TIMER_COMPLETE, complete);
											displayDialog(dialogHandler.getFirstDialog(id));
										});
			preparation.start();
		}
		
		protected function creationComplete(e:Event):void 
		{
			dialogBoxHeight = height;
			x = StageBaseClass.STAGE_WIDTH / 2;
			y = StageBaseClass.STAGE_HEIGHT - dialogBoxHeight / 2;
			
			tField = new LocalesTextField("");
			addChild(tField);
			tField.x = -width / 2 + TFIELD_GAP;
			tField.y = -height / 2 + TFIELD_GAP;
			tField.width = width - TFIELD_GAP * 2;
			tField.height = height - TFIELD_GAP * 2;
			
			initiateDialog();
		}
		
	}

}