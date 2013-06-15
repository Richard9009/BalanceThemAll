package stages 
{
	import assets.AssetCollection;
	import assets.SoundCollection;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	import flash.display.Sprite;
	import flash.events.Event;
	import gameEvents.GameEvent;
	import gameEvents.GrabObjectEvent;
	import gameEvents.TutorialEvent;
	import gameObjects.rigidObjects.BalanceBoard;
	import gameObjects.rigidObjects.DraggableObject;
	import gameObjects.rigidObjects.Foundation;
	import gameObjects.IAudibleObject;
	import gameObjects.rigidObjects.RigidObjectBase;
	import general.MousePhysic;
	import general.MusicManager;
	import general.ObjectCollection;
	import gameObjects.StarObject;
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
	public class FirstStage extends StageBaseClass implements IPlayableStage
	{
		private var tutorialHandler:DialogEventHandler = DialogEventHandler.getInstance();
		private var collection:AssetCollection;
		private var asset:Class;
		private var itemArray:Array = new Array();
		private var items:ObjectCollection = new ObjectCollection();
		
		public function FirstStage() 
		{
			collection = new AssetCollection();
			asset = collection.stageAsset;
			
			var assetData:Sprite = new asset() as Sprite;
			assetData.x = STAGE_WIDTH / 2;
			assetData.y = STAGE_HEIGHT / 2;
			this.addChild(assetData);
			
			super();
		}
		
		public function createTutorialDialog(id:String):void {
			var tutorial:Tutorial = new Tutorial(id);
			addChildAt(tutorial, numChildren - 1);
			
			tutorialHandler.addEventListener(TutorialEvent.DRAW_STAR_LINE, drawStarLine);
			tutorialHandler.addEventListener(TutorialEvent.LOCK_STAGE, lockStage);
			tutorialHandler.addEventListener(TutorialEvent.UNLOCK_STAGE, unlockStage);
			tutorialHandler.addEventListener(TutorialEvent.LOCK_DOUBLE_CLICK, lockDoubleClick);
			tutorialHandler.addEventListener(TutorialEvent.UNLOCK_DOUBLE_CLICK, unlockDoubleClick);
			tutorialHandler.addEventListener(TutorialEvent.RESTART_TUTORIAL, restartTutorial);
		}
		
		private function restartTutorial(e:TutorialEvent):void 
		{
			parent.dispatchEvent(new GameEvent(GameEvent.RESTART_LEVEL)); 
		}
		
		private function unlockDoubleClick(e:TutorialEvent):void 
		{
			MousePhysic.allowDoubleClick = true;
		}
		
		private function lockDoubleClick(e:TutorialEvent):void 
		{	
			MousePhysic.allowDoubleClick = false;
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
			
			for each(var star:StarObject in stars) {
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
				MousePhysic.allowDoubleClick = true;
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
			for each(var star:StarObject in stars) {
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
					function closeTutorial(e:DialogEvent):void {
						Tutorial.tutorialOn = false;
						tutorialHandler.removeEventListener(e.type, closeTutorial);
						levelClear();
					}
				);
			}
			else super.levelClear();
		}
		
		override protected function grabAnObject(e:GrabObjectEvent):void 
		{
			super.grabAnObject(e);
			if (objectsOnHand.length == 2) delayAction(1000, tutorial_HandFull);
		}
		
		private function tutorial_HandFull():void {
			tutorialHandler.dispatchEvent(new TutorialEvent(TutorialEvent.HANDS_ARE_FULL));
		}
	
		public function createLevelBySubStageID(subStageIndex:int):void {
			
			var stgID:String = "1_" + subStageIndex.toString();
			initiateStage(stgID);
			
			switch(subStageIndex) {
				case 1: createStage1_1(); break;
				case 2: createStage1_2(); break;
				case 3: createStage1_3(); break;
				case 4: createStage1_4(); break;
				case 5: createStage1_5(); break;
			}
			
			if (subStageIndex < 4) MusicManager.getInstance().playStage1FirstHalfBGM();
			else MusicManager.getInstance().playStage1SecondHalfBGM();
			
			createItems(itemArray);
			createStars();
			createTutorialDialog(stgID);
		}
		
		public function createStage1_1():void
		{
			itemArray.push(items.createEncyclopedia(2));
			
			createFoundation(380, 420, 40, 80, -Math.PI / 2);
			createBalanceBoard(380, 385, 500, 15);
			
			stars.push(items.createGoldenStar(150, 350));
			stars.push(items.createSilverStar(600, 350));
			
			showBalanceLine = false;
		}
		
		public function createStage1_2():void {
			itemArray.push(items.createBlueBook(1));
			itemArray.push(items.createEncyclopedia(1));
			
			var foundation:Foundation = createFoundation(380, 420, 40, 80, -Math.PI / 2);
			createBalanceBoard(380, 385, 500, 15);
			
			stars.push(items.createGoldenStar(300, 350));
			stars.push(items.createSilverStar(600, 350));
			
			foundation.setBalanceLine(bLine);
		}
		
		public function createStage1_3():void {
			itemArray.push(items.createPillow(1));
			itemArray.push(items.createEncyclopedia(1));
			var book:RigidObjectBase = RigidObjectBase(itemArray[1][0]);
			book.getBody().SetAngle(90);
			
			createFoundation(380, 420, 40, 80, -Math.PI / 2);
			createBalanceBoard(380, 385, 500, 15);
			
			stars.push(items.createGoldenStar(150, 290));
			stars.push(items.createSilverStar(450, 290));
		}
		
		public function createStage1_4():void {
			itemArray.push(items.createPillow(1));
			itemArray.push(items.createBlueBook(1));
			itemArray.push(items.createShoes(1));
			itemArray.push(items.createEncyclopedia(1));
			
			createFoundation(380, 420, 40, 80, -Math.PI / 2);
			createBalanceBoard(380, 385, 500, 15);
			
			stars.push(items.createGoldenStar(150, 250));
			stars.push(items.createSilverStar(550, 250));
		}
		
		public function createStage1_5():void {
			itemArray.push(items.createPhoto(3));
			itemArray.push(items.createPillow(1));
			itemArray.push(items.createShoes(1));
			
			createFoundation(380, 400, 40, 80, 0);
			createBalanceBoard(380, 365, 500, 15);
			
			stars.push(items.createGoldenStar(150, 170));
			stars.push(items.createSilverStar(550, 220));
		}
		
		private function createFoundation(xx:Number, yy:Number, ww:Number, hh:Number, rot:Number = 0):Foundation
		{
			var fdn1:Foundation = new Foundation();
			fdn1.getBody().SetType(b2Body.b2_staticBody);
			fdn1.createDisplayBody(collection.foundationAsset);
			fdn1.setSize(ww, hh, 0);
			fdn1.setPosition(xx, yy);
			fdn1.getBody().SetAngle(rot);
			fdn1.setFixtureProperties(0, 0, 1);
			addChild(fdn1);
			
			return fdn1;
		}
		
		private function createBalanceBoard(xx:Number, yy:Number, ww:Number, hh:Number):void
		{
			balanceBoard = new BalanceBoard();
			balanceBoard.createDisplayBody(collection.balanceBoardAsset);
			balanceBoard.setAssetSize(ww, hh);
			balanceBoard.addBoxFixture(ww, hh, 0.3);
			balanceBoard.setPosition(xx, yy);
			balanceBoard.setFixtureProperties(0.5, 0.1, 0.8);
			addChild(balanceBoard);
			
		}
		
	}

}