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
	import stages.Tutorials.commands.BaseCommandClass;
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
		private var dialogHandler:DialogHandler;
		private var eventHandler:TutorialEventDispatcher = TutorialEventDispatcher.getInstance();
		private var id:String;
		
		protected var dialogBoxHeight:Number = 0;
		protected var collection:AssetCollection = new AssetCollection();
		
		public function Dialog(stageID:String) 
		{
			dialogHandler = DialogHandler.getInstance();
			addEventListener(Event.ADDED_TO_STAGE, creationComplete);
			
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
				addEventListener(MouseEvent.MOUSE_DOWN, skipDialog);
			}
		}
		
		private function handleNo(e:MouseEvent):void 
		{
			displayDialog(dialogHandler.getNextDialog(DialogPath.SKIP_TUTORIAL));
		}
		
		private function displayDialog(dialog:DialogHelper):void
		{
			setDefaultCondition();
			
			for each(var command:BaseCommandClass in dialog.commands) 
			{	
				handleDialogCommand(command);
			}

			if(!dialog.isEmpty) tField.setLocaleText(dialog.code);
		}
		
		private function handleDialogCommand(command:BaseCommandClass):void
		{
			
			command.executeAllActions();
			
			switch(command.commandType) {		
													
				case DialogCommand.jumpToDialog().commandType: 	displayDialog(dialogHandler.jumpTo(DialogCommand(command).dialogIndex)); break;
		
				case DialogCommand.stop.commandType: 	eventHandler.dispatchEvent(new TutorialEvent(TutorialEvent.CLOSE_TUTORIAL));
														eventHandler.forgetAllEvents();
														parent.removeChild(this); break;
														
				case DialogCommand.allowSkip.commandType: allowSkipDialog(); break;
				
				default: return;
			}
		}
		
		public function nextDialog(path:DialogPath):void 
		{
			displayDialog(dialogHandler.getNextDialog(path));
		}
		
		private function skipDialog(e:Event):void {
			nextDialog(DialogPath.TUTORIAL);
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
			
			DialogCommand.setDialog(this);
			
			initiateDialog();
		}
		
	}

}