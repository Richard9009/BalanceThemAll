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
			
			createFoundation(380, 410, 40, 60, 0);
			createBalanceBoard(380, 365, 550, 45);
			
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
		
		private function createFoundation(xx:Number, yy:Number, ww:Number, hh:Number, rot:Number = 0):Foundation
		{
			var fdn1:Foundation = new Foundation();
			fdn1.getBody().SetType(b2Body.b2_staticBody);
			fdn1.createDisplayBody(collection.foundation2Asset);
			fdn1.setSize(ww, hh, 0);
			fdn1.setPosition(xx, yy);
			fdn1.getBody().SetAngle(rot); 
			fdn1.setFixtureProperties(0, 0, 1);
			addChild(fdn1);
			
			return fdn1;
		}
		
		private function createBalanceBoard(xx:Number, yy:Number, ww:Number, hh:Number):void
		{
			var balanceBoard:CompoundObject = new CompoundObject();
			balanceBoard.createDisplayBody(collection.baseballAsset);
			balanceBoard.setAssetSize(ww, hh);
			balanceBoard.setPosition(xx-70, yy);
			balanceBoard.addBoxFixture(ww * 2/5, hh / 2, 0.2);
			balanceBoard.addBoxFixture(ww * 3/5, hh, 0.2);
			balanceBoard.isBalanceBoard = true;
			var fixt:b2Fixture = balanceBoard.getBody().GetFixtureList();
			balanceBoard.setFixtureProperties(0.2, 0.1, 0.8, fixt);
			fixt = fixt.GetNext();
			balanceBoard.setFixtureProperties(0.2, 0.1, 0.8, fixt);
			
			balanceBoard.arrangeFixture();
			addChild(balanceBoard);
			
		}
		
	}

}