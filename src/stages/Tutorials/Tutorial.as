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
	
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class Tutorial extends DialogBox 
	{
		public static var tutorialOn:Boolean = true;
		private static const ABOVE_ITEM_BOX:String = "above item box";
		private static const ON_ITEM_BOX:String = "in the middle of item box";
		
		private static const TFIELD_GAP:int = 35;
		
		private var dialogBoxHeight:Number = 0;
		private var tField:LocalesTextField;
		private var collection:AssetCollection = new AssetCollection();
		private var dialogHandler:TutorialDialogHandler;
		private var eventHandler:TutorialEventDispatcher = TutorialEventDispatcher.getInstance();
		private var npc:Sprite;
		
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
			setDefaultCondition();
			
			for each(var command:DialogCommand in dialog.commands) 
			{	
				handleDialogCommand(command, dialog);
			}
			
			tField.setLocaleText(dialog.code);
		}
		
		private function handleDialogCommand(command:DialogCommand, helper:DialogHelper):void
		{
			switch(command) {
				case DialogCommand.promptYesNo: yesButton.visible = true;
												noButton.visible = true;
												removeEventListener(MouseEvent.MOUSE_DOWN, nextDialog);
												break;
												
				case DialogCommand.moveToItemBox: moveTo(ON_ITEM_BOX); break;
				
				case DialogCommand.moveDialogBoxUp: moveTo(ABOVE_ITEM_BOX); break;
				
				case DialogCommand.hideNPC: npc.visible = false; break;
				
				case DialogCommand.waitingForEvent: eventHandler.addEventListener(helper.event, handleCommandEvent);
													removeEventListener(MouseEvent.MOUSE_DOWN, nextDialog); 
													break;
													
				case DialogCommand.drawStarLines: 	var evtType:String = TutorialEvent.DRAW_STAR_LINE;
													eventHandler.dispatchEvent(new TutorialEvent(evtType)); break;
				
				case DialogCommand.promptSuccessFailed: eventHandler.addEventListener(helper.successEvent, handleSuccess);
														eventHandler.addEventListener(helper.failedEvent, handleFailed);
														break;
													
				case DialogCommand.turnOffTutorial: tutorialOn = false; break;									
		
				case DialogCommand.stop: 	eventHandler.dispatchEvent(new TutorialEvent(TutorialEvent.CLOSE_TUTORIAL));
											parent.removeChild(this); break;
				
				default: return;
			}
		}
		
		private function handleFailed(e:Event):void 
		{
			eventHandler.forgetAllEvents();
			handleNo(null);
		}
		
		private function handleSuccess(e:Event):void 
		{
			eventHandler.forgetAllEvents();
			nextDialog(null);
		}
		
		private function handleCommandEvent(e:Event):void 
		{
			eventHandler.removeEventListener(e.type, handleCommandEvent);
			nextDialog(null);
		}
		
		private function setDefaultCondition():void
		{
			npc.visible = true;
			yesButton.visible = false;
			noButton.visible = false; 
			parent.setChildIndex(this, parent.numChildren - 1);
			if (!hasEventListener(MouseEvent.MOUSE_DOWN)) 
				addEventListener(MouseEvent.MOUSE_DOWN, nextDialog);
		}
		
		private function moveTo(position:String):void
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
			
			displayDialog(dialogHandler.getFirstDialog("1_1"));
		}
		
	}

}