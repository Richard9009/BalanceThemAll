package stages 
{
	import assets.AssetCollection;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2Fixture;
	import flash.display.Sprite;
	import gameObjects.rigidObjects.CompoundObject;
	import gameObjects.rigidObjects.Foundation;
	import gameObjects.rigidObjects.RigidObjectBase;
	import general.ObjectBuilder;
	import general.SpecialObjectBuilder;
	import org.flashdevelop.utils.FlashConnect;
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class SecondStage extends StageBaseClass implements IPlayableStage 
	{
		
		private var collection:AssetCollection;
		private var asset:Class;
		private var itemArray:Array = new Array();
		private var itemBuilder:ObjectBuilder = new ObjectBuilder();
		private var specialBuilder:SpecialObjectBuilder = new SpecialObjectBuilder();
		
		public function SecondStage() 
		{
			collection = new AssetCollection();
			asset = collection.stage2BGAsset;
			
			var assetData:Sprite = new asset() as Sprite;
			assetData.x = STAGE_WIDTH / 2;
			assetData.y = STAGE_HEIGHT / 2;
			this.addChild(assetData);
			
			super();
			
		}
		
		/* INTERFACE stages.IPlayableStage */
		
		public function createLevelBySubStageID(subStageIndex:int):void 
		{
			initiateStage("2_"+subStageIndex.toString());
			
			switch(subStageIndex) {
				case 1: createStage2_1(); break;
				case 2: createStage2_2(); break;
				case 3: createStage2_3(); break;
			}
			
			createFoundation();
			createBalanceBoard();
			
			createItems(itemArray);
			createStars();
		}
		
		private function createStage2_1():void
		{
			itemArray.push(itemBuilder.createBasketBall(1));
			itemArray.push(itemBuilder.createEncyclopedia(1));
			itemArray.push(itemBuilder.createMug(1));
			itemArray.push(itemBuilder.createGlassVase(1));
			
			stars.push(specialBuilder.createGoldenStar(110, 225));
			stars.push(specialBuilder.createSilverStar(550, 265));
		}
		
		private function createStage2_2():void
		{
			itemArray.push(itemBuilder.createPhoto(1));
			itemArray.push(itemBuilder.createHeavyObject(1));
			itemArray.push(itemBuilder.createBlueBook(1));
			
			stars.push(specialBuilder.createGoldenStar(110, 210));
			stars.push(specialBuilder.createSilverStar(550, 268));
		}
		
		private function createStage2_3():void
		{
			itemArray.push(itemBuilder.createShoes(2));
			itemArray.push(itemBuilder.createBowlingBall(2));
			itemArray.push(itemBuilder.createHeavyObject(2));
			
			stars.push(specialBuilder.createGoldenStar(110, 210));
			stars.push(specialBuilder.createSilverStar(550, 268));
		}
		
		private function createFoundation():void
		{
			var bookStack:Foundation = specialBuilder.createBookStack(380, 410);
			addChild(bookStack);
		}
		
		private function createBalanceBoard():void
		{
			var baseballBat:CompoundObject = specialBuilder.createBaseballBat(380, 365);
			addChild(baseballBat);
			
		}
		
	}

}