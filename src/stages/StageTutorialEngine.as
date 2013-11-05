package stages 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import gameEvents.GameEvent;
	import gameEvents.GrabObjectEvent;
	import gameEvents.TutorialEvent;
	import general.MousePhysic;
	import general.StageRecord;
	import org.flashdevelop.utils.FlashConnect;
	import general.dialogs.DialogEvent;
	import resources.DashedLine;
	import stages.Tutorials.Tutorial;
	import general.dialogs.DialogEventHandler;
	
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class StageTutorialEngine extends StageEngine
	{
		private var tutorialHandler:DialogEventHandler = DialogEventHandler.getInstance();
	
		public function StageTutorialEngine() 
		{
			super();
		}
		
		public function createTutorialDialog(id:String):void {
			var tutorial:Tutorial = new Tutorial(id);
			addChildAt(tutorial, numChildren - 1);
			
			tutorialHandler.addEventListener(TutorialEvent.DRAW_STAR_LINE, drawStarLine);
			tutorialHandler.addEventListener(TutorialEvent.LOCK_STAGE, lockStage);
			tutorialHandler.addEventListener(TutorialEvent.UNLOCK_STAGE, unlockStage);
			tutorialHandler.addEventListener(TutorialEvent.LOCK_DROP, lockDoubleClick);
			tutorialHandler.addEventListener(TutorialEvent.UNLOCK_DROP, unlockDoubleClick);
			tutorialHandler.addEventListener(TutorialEvent.RESTART_TUTORIAL, restartTutorial);
		}
		
		override public function destroyMe():void 
		{
			super.destroyMe();
			
			tutorialHandler.removeEventListener(TutorialEvent.DRAW_STAR_LINE, drawStarLine);
			tutorialHandler.removeEventListener(TutorialEvent.LOCK_STAGE, lockStage);
			tutorialHandler.removeEventListener(TutorialEvent.UNLOCK_STAGE, unlockStage);
			tutorialHandler.removeEventListener(TutorialEvent.LOCK_DROP, lockDoubleClick);
			tutorialHandler.removeEventListener(TutorialEvent.UNLOCK_DROP, unlockDoubleClick);
			tutorialHandler.removeEventListener(TutorialEvent.RESTART_TUTORIAL, restartTutorial);
		}
		
		private function restartTutorial(e:TutorialEvent):void 
		{
			dispatchEvent(new GameEvent(GameEvent.RESTART_LEVEL)); 
		}
		
		private function unlockDoubleClick(e:TutorialEvent):void 
		{
			MousePhysic.allowDrop = true;
		}
		
		private function lockDoubleClick(e:TutorialEvent):void 
		{	
			MousePhysic.allowDrop = false;
		}
		
		private function unlockStage(e:TutorialEvent):void 
		{
			MousePhysic.unlockStage(this);
			mouseEnabled = true;
		}
		
		private function lockStage(e:TutorialEvent):void 
		{
			MousePhysic.lockStage();
			mouseEnabled = false;
		}
		
		private var starLine:DashedLine;
		private function drawStarLine(e:TutorialEvent):void 
		{
			var lineLength:Number = 200;
			starLine = new DashedLine(3, 0xAA3300, [8, 5, 3, 5]);
			
			for each(var star:Sprite in stars) {
				starLine.moveTo(star.x, star.y);
				starLine.lineTo(star.x, star.y - lineLength);
			}
			
			addChild(starLine);
			
			addEventListener(Event.ENTER_FRAME, checkStarTutorial);
			tutorialHandler.removeEventListener(TutorialEvent.DRAW_STAR_LINE, drawStarLine);
		}
		
		private function checkStarTutorial(e:Event):void 
		{
			var willGetAllStars:Boolean = true;
		
			for each(var item:Sprite in record.itemList) {
				if (!willGetTheStar(item)) willGetAllStars = false;
			}
			
			if (willGetAllStars) {
				MousePhysic.allowDrop = true;
				removeEventListener(Event.ENTER_FRAME, checkStarTutorial);
				clearStarLine();
				tutorialHandler.dispatchEvent(new TutorialEvent(TutorialEvent.READY_TO_DROP));
			}
		}
		
		private function clearStarLine():void 
		{
			starLine.graphics.clear();
			removeChild(starLine);
		}
		
		private function willGetTheStar(obj:Sprite):Boolean
		{
			for each(var star:Sprite in stars) {
				if (obj.y < star.y && obj.x > star.x - star.width / 2 && obj.x < star.x + star.width / 2) {
					return true;
				}
			}
			
			return false;
		}
		
		override protected function dropAll(e:GrabObjectEvent):void 
		{
			super.dropAll(e);
			tutorialHandler.dispatchEvent(new TutorialEvent(TutorialEvent.BOOKS_RELEASED));
		}
		
		override protected function checkStarCollision(item:Sprite):void 
		{
			super.checkStarCollision(item);
			
			if (stars.length == 0) {
				tutorialHandler.dispatchEvent(new TutorialEvent(TutorialEvent.TUTORIAL_CLEAR));
			}
		}
		
		override protected function displayScore(e:GrabObjectEvent):void 
		{
			super.displayScore(e);
			if (record.allItemsDropped() && stars.length > 0) {
				tutorialHandler.dispatchEvent(new TutorialEvent(TutorialEvent.TUTORIAL_FAILED));
			}
		}
	
		override protected function levelClear():void 
		{
			if (Tutorial.tutorialOn) {
				tutorialHandler.addEventListener(DialogEvent.CLOSE_DIALOG, 
					function closeTutorial(e:Event):void {
						Tutorial.tutorialOn = false;
						tutorialHandler.removeEventListener(e.type, closeTutorial);
						levelClear();
					}
				);
			}
			else super.levelClear();
			
			
		}
		
		override protected function grabAnObject(e:GrabObjectEvent):String
		{
			var whatHand:String = super.grabAnObject(e);
			if (objectsOnHand.length == 2) delayAction(1000, tutorial_HandFull);
			return whatHand;
		}
		
		private function tutorial_HandFull():void {
			tutorialHandler.dispatchEvent(new TutorialEvent(TutorialEvent.HANDS_ARE_FULL));
		}
	}

}