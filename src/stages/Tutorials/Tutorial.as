package stages.Tutorials 
{
	import assets.AssetCollection;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import gameEvents.TutorialEvent;
	import general.animations.LinearAnimation;
	import locales.LocalesTextField;
	import org.flashdevelop.utils.FlashConnect;
	import stages.StageBaseClass;
	import stages.Tutorials.commands.DialogCommand;
	import stages.Tutorials.commands.EventCommand;
	import stages.Tutorials.commands.EventCommandEvent;
	import stages.Tutorials.commands.TutorialCommand;
	
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class Tutorial extends DialogBox 
	{
		public static var tutorialOn:Boolean = true;
		public static const ABOVE_ITEM_BOX:String = "above item box";
		public static const ON_ITEM_BOX:String = "in the middle of item box";
		
		private static const TFIELD_GAP:int = 35;
		
		private var dialogBoxHeight:Number = 0;
		private var tField:LocalesTextField;
		private var collection:AssetCollection = new AssetCollection();
		private var dialogHandler:TutorialDialogHandler;
		private var eventHandler:TutorialEventDispatcher = TutorialEventDispatcher.getInstance();
		private var id:String;
		public var npc:Sprite;
		
		public function Tutorial(stageID:String) 
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
	
		private function setDefaultCondition():void
		{
			visible = true;
			npc.visible = true;
			yesButton.visible = false;
			noButton.visible = false; 
			clickClue.visible = true;
			
			parent.setChildIndex(this, parent.numChildren - 1);
			lockSkipDialog();
		}
		
		public function moveTo(position:String):void
		{
			var destination:Point = new Point();
			switch(position) {
				case ABOVE_ITEM_BOX: destination.x = StageBaseClass.STAGE_WIDTH / 2;
									 destination.y = StageBaseClass.STAGE_HEIGHT - StageBaseClass.ITEMBOX_HEIGHT - dialogBoxHeight / 2;
									 break;
									 
				case ON_ITEM_BOX: destination.x = StageBaseClass.STAGE_WIDTH / 2;
								  destination.y = StageBaseClass.STAGE_HEIGHT - dialogBoxHeight / 2;
								  break;
			}
			
			var anim:LinearAnimation = new LinearAnimation();
			anim.constantMove(this, new Point(x, y), destination, 500);
		}
		
		private function creationComplete(e:Event):void 
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
			
			var scaleRatio:Number = 0.8;
			npc = new collection.gavinAsset();
			npc.width *= scaleRatio;
			npc.height *= scaleRatio;
			npc.x = -width/2 + npc.width / 2 + 30;
			npc.y = - npc.height / 2 - height / 2;
			addChild(npc);
			
			tutorialOn = true;
			TutorialCommand.setTutorial(this);
		
			displayDialog(dialogHandler.getFirstDialog(id));
		}
		
	}

}