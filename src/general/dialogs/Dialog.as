package general.dialogs 
{
	import assets.AssetCollection;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import gameEvents.TutorialEvent;
	import stages.StageBaseClass;
	import general.dialogs.commands.BaseCommandClass;

	import locales.LocalesTextField;
	import org.flashdevelop.utils.FlashConnect;
	
	import general.dialogs.commands.DialogCommand;
	import general.dialogs.commands.EventCommand;
	
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class Dialog extends DialogBox 
	{
		private static const TFIELD_GAP:int = 35;
		
		private var tField:LocalesTextField;
		private var dialogHandler:DialogHandler;
		private var eventHandler:DialogEventHandler = DialogEventHandler.getInstance();
		
		protected var dialogBoxHeight:Number = 0;
		protected var collection:AssetCollection = new AssetCollection();
		public var uniqueID:Number = Math.random();
		public function Dialog(dialogArray:Array) 
		{
			dialogHandler = new DialogHandler(dialogArray);
			addEventListener(Event.ADDED_TO_STAGE, creationComplete);
		}
		
		public function lockSkipDialog():void {
			if(hasEventListener(MouseEvent.MOUSE_DOWN)) {
				removeEventListener(MouseEvent.MOUSE_DOWN, skipDialog);
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
			displayDialog(dialogHandler.getNextDialog(DialogPath.ANSWER_NO));
		}
		
		private function displayDialog(dialog:DialogHelper):void
		{
			setDefaultCondition();
			
			dialog.runCommands();
			if(!dialog.isEmpty) tField.setLocaleText(dialog.code);
		}
		
		public function nextDialog(path:DialogPath):void 
		{
			displayDialog(dialogHandler.getNextDialog(path));
		}
		
		public function jumpToDialog(dialogIndex:int):void
		{
			displayDialog(dialogHandler.jumpTo(dialogIndex));
		}
		
		private function skipDialog(e:Event):void {
			nextDialog(DialogPath.DEFAULT);
		}
	
		protected function setDefaultCondition():void
		{
			FlashConnect.trace(uniqueID);
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
											displayDialog(dialogHandler.getFirstDialog());
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
			EventCommand.setDialog(this);
			
			initiateDialog();
		}
		
		public function destroyMe():void
		{
			parent.removeChild(this);
		}
		
	}

}