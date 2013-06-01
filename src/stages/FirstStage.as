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
	import gameEvents.GrabObjectEvent;
	import gameEvents.TutorialEvent;
	import gameObjects.rigidObjects.BalanceBoard;
	import gameObjects.rigidObjects.DraggableObject;
	import gameObjects.rigidObjects.Foundation;
	import gameObjects.IAudibleObject;
	import general.MusicManager;
	import general.ObjectCollection;
	import gameObjects.StarObject;
	import general.StageRecord;
	import org.flashdevelop.utils.FlashConnect;
	import stages.Tutorials.Tutorial;
	import stages.Tutorials.TutorialEventDispatcher;
	
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class FirstStage extends StageBaseClass implements IPlayableStage
	{
		private static var isFirstTime:Boolean = true;
		private var collection:AssetCollection;
		private var asset:Class;
		
		public function FirstStage() 
		{
			collection = new AssetCollection();
			asset = collection.stageAsset;
			
			var assetData:Sprite = new asset() as Sprite;
			assetData.x = STAGE_WIDTH / 2;
			assetData.y = STAGE_HEIGHT / 2;
			this.addChild(assetData);
			
			super();
			
			//createStage1_1();
		}
		
		public function createTutorialDialog():void {
			var tutorial:Tutorial = new Tutorial();
			addChildAt(tutorial, numChildren - 1);
			TutorialEventDispatcher.getInstance().addEventListener(TutorialEvent.DRAW_STAR_LINE, drawStarLine);
			isFirstTime = false;
		}
		
		private var starLine:Sprite;
		private function drawStarLine(e:TutorialEvent):void 
		{
			FlashConnect.trace("draw");
			var lineLength:Number = 100;
			starLine = new Sprite();
			
			for each(var star:StarObject in stars) {
				starLine.graphics.lineStyle(2, 0xFF9999, 1);
				starLine.graphics.moveTo(star.x, star.y);
				starLine.graphics.lineTo(star.x, star.y - lineLength);
			}
			
			addChild(starLine);
			
			addEventListener(Event.ENTER_FRAME, checkStarTutorial);
			TutorialEventDispatcher.getInstance().startWaitingForAnEvent(TutorialEvent.READY_TO_DROP);
			TutorialEventDispatcher.getInstance().removeEventListener(TutorialEvent.DRAW_STAR_LINE, drawStarLine);
		}
		
		private function checkStarTutorial(e:Event):void 
		{
			var willGetAllStars:Boolean = true;
		
			for each(var item:Sprite in record.itemList) {
				if (!willGetTheStar(item)) willGetAllStars = false;
			}
			
			if (willGetAllStars) {
				removeEventListener(Event.ENTER_FRAME, checkStarTutorial);
				clearStarLine();
				TutorialEventDispatcher.getInstance().dispatchEvent(new TutorialEvent(TutorialEvent.READY_TO_DROP));
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
			TutorialEventDispatcher.getInstance().dispatchEvent(new TutorialEvent(TutorialEvent.BOOKS_RELEASED));
		}
		
		override protected function checkStarCollision(item:Sprite):void 
		{
			super.checkStarCollision(item);
			
			if (stars.length == 0) {
				TutorialEventDispatcher.getInstance().dispatchEvent(new TutorialEvent(TutorialEvent.TUTORIAL_CLEAR));
			}
		}
	
		public function createLevelBySubStageID(subStageIndex:int):void {
			
			initiateStage("1_"+subStageIndex.toString());
			
			switch(subStageIndex) {
				case 1: createStage1_1(); break;
				case 2: createStage1_2(); break;
				case 3: createStage1_3(); break;
				case 4: createStage1_4(); break;
				case 5: createStage1_5(); break;
			}
			
			if (subStageIndex < 4) MusicManager.getInstance().playStage1FirstHalfBGM();
			else MusicManager.getInstance().playStage1SecondHalfBGM();
		}
		
		public function createStage1_1():void
		{
			var itemArray:Array = new Array();
			var items:ObjectCollection = new ObjectCollection();
			
			itemArray.push(items.createEncyclopedia(2));
			
			for each(var iArray:Array in itemArray)
			{
				for each(var item:DraggableObject in iArray)
				{
					record.registerItem(item);
					addChild(item);
				}
			}
			
			createFoundation(380, 420, 40, 80, -Math.PI / 2);
			createBalanceBoard(380, 385, 500, 15);
			stars = new Array();
			stars.push(items.createGoldenStar(150, 350));
			stars.push(items.createSilverStar(600, 350));
			for each(var star:StarObject in stars)
			{
				addChild(star);
			}
			
			if (isFirstTime) createTutorialDialog();
		}
		
		public function createStage1_2():void {
			var itemArray:Array = new Array();
			var items:ObjectCollection = new ObjectCollection();
			
			itemArray.push(items.createGlassVase(3));
			itemArray.push(items.createMug(2));
			itemArray.push(items.createBlueBook(1));
			itemArray.push(items.createPhoto(2));
			itemArray.push(items.createEncyclopedia(2));
			
			for each(var iArray:Array in itemArray)
			{
				for each(var item:DraggableObject in iArray)
				{
					record.registerItem(item);
					addChild(item);
				}
			}
			
			createFoundation(380, 420, 40, 80, -Math.PI / 2);
			createBalanceBoard(380, 385, 500, 15);
			stars = new Array();
			stars.push(items.createGoldenStar(200, 100));
			stars.push(items.createSilverStar(600, 200));
			for each(var star:StarObject in stars)
			{
				addChild(star);
			}
		}
		
		public function createStage1_3():void {
			var itemArray:Array = new Array();
			var items:ObjectCollection = new ObjectCollection();
			
			itemArray.push(items.createGlassVase(3));
			itemArray.push(items.createMug(2));
			itemArray.push(items.createBlueBook(3));
			itemArray.push(items.createPhoto(2));
			itemArray.push(items.createEncyclopedia(1));
			itemArray.push(items.createBasketBall(2));
			
			for each(var iArray:Array in itemArray)
			{
				for each(var item:DraggableObject in iArray)
				{
					record.registerItem(item);
					addChild(item);
				}
			}
			
			createFoundation(380, 400, 40, 80, 0);
			createBalanceBoard(380, 365, 500, 15);
			stars = new Array();
			stars.push(items.createGoldenStar(160, 100));
			stars.push(items.createSilverStar(540, 200));
			for each(var star:StarObject in stars)
			{
				addChild(star);
			}
		}
		
		public function createStage1_4():void {
			var itemArray:Array = new Array();
			var items:ObjectCollection = new ObjectCollection();
			
			itemArray.push(items.createGlassVase(2));
			itemArray.push(items.createPillow(1));
			itemArray.push(items.createBlueBook(1));
			itemArray.push(items.createShoes(3));
			itemArray.push(items.createEncyclopedia(3));
			itemArray.push(items.createBasketBall(1));
			itemArray.push(items.createTennisBall(4));
			
			for each(var iArray:Array in itemArray)
			{
				for each(var item:DraggableObject in iArray)
				{
					record.registerItem(item);
					addChild(item);
				}
			}
			
			createFoundation(380, 400, 40, 80, 0);
			createBalanceBoard(380, 365, 500, 15);
			stars = new Array();
			stars.push(items.createGoldenStar(160, 100));
			stars.push(items.createSilverStar(540, 200));
			stars.push(items.createBronzeStar(600, 225));
			for each(var star:StarObject in stars)
			{
				addChild(star);
			}
		}
		
		public function createStage1_5():void {
			var itemArray:Array = new Array();
			var items:ObjectCollection = new ObjectCollection();
			
			itemArray.push(items.createGlassVase(5));
			itemArray.push(items.createPillow(1));
			itemArray.push(items.createBlueBook(1));
			itemArray.push(items.createMug(3));
			itemArray.push(items.createEncyclopedia(3));
			itemArray.push(items.createBasketBall(2));
			itemArray.push(items.createTennisBall(2));
			
			for each(var iArray:Array in itemArray)
			{
				for each(var item:DraggableObject in iArray)
				{
					record.registerItem(item);
					addChild(item);
				}
			}
			
			createFoundation(380, 400, 40, 80, 0);
			createBalanceBoard(380, 365, 600, 15);
			stars = new Array();
			stars.push(items.createGoldenStar(160, 100));
			stars.push(items.createSilverStar(540, 200));
			stars.push(items.createBronzeStar(600, 225));
			for each(var star:StarObject in stars)
			{
				addChild(star);
			}
		}
		
		private function createFoundation(xx:Number, yy:Number, ww:Number, hh:Number, rot:Number = 0):void
		{
			var fdn1:Foundation = new Foundation();
			fdn1.getBody().SetType(b2Body.b2_staticBody);
			fdn1.createDisplayBody(collection.foundationAsset);
			fdn1.setSize(ww, hh, 0);
			fdn1.setPosition(xx, yy);
			fdn1.getBody().SetAngle(rot);
			fdn1.setFixtureProperties(0, 0, 1);
			addChild(fdn1);
		}
		
		private function createBalanceBoard(xx:Number, yy:Number, ww:Number, hh:Number):void
		{
			balanceBoard = new BalanceBoard();
			balanceBoard.createDisplayBody(collection.balanceBoardAsset);
			balanceBoard.setSize(ww, hh, 0.5);
			balanceBoard.setPosition(xx, yy);
			balanceBoard.setFixtureProperties(0.5, 0.1, 0.8);
			addChild(balanceBoard);
			
		}
		
	}

}