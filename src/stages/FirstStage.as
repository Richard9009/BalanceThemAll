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
	import gameObjects.rigidObjects.BalanceBoard;
	import gameObjects.rigidObjects.DraggableObject;
	import gameObjects.rigidObjects.Foundation;
	import gameObjects.IAudibleObject;
	import general.MusicManager;
	import general.ObjectCollection;
	import gameObjects.StarObject;
	import general.StageRecord;
	import org.flashdevelop.utils.FlashConnect;
	
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class FirstStage extends StageBaseClass implements IPlayableStage
	{
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
		}
		
		public function createLevelBySubStageID(subStageIndex:int):void {
			switch(subStageIndex) {
				case 1: createStage1_1(); break;
				//case 1: createTutorialDialog(); break;
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
			record = StageRecord.getStageRecordByID("1_1");
			record.stageStarted();
			
			var itemArray:Array = new Array();
			var items:ObjectCollection = new ObjectCollection();
			
			itemArray.push(items.createBlueBook(2));
			itemArray.push(items.createPhoto(4));
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
			stars.push(items.createGoldenStar(200, 175));
			stars.push(items.createSilverStar(600, 225));
			for each(var star:StarObject in stars)
			{
				addChild(star);
			}
		}
		
		public function createStage1_2():void {
			record = StageRecord.getStageRecordByID("1_2");
			record.stageStarted();
			
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
			record = StageRecord.getStageRecordByID("1_3");
			record.stageStarted();
			
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
			record = StageRecord.getStageRecordByID("1_4");
			record.stageStarted();
			
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
			record = StageRecord.getStageRecordByID("1_5");
			record.stageStarted();
			
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