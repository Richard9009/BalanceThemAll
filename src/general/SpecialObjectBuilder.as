package general 
{
	import assets.AssetCollection;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2Fixture;
	import gameObjects.rigidObjects.CompoundObject;
	import gameObjects.rigidObjects.Foundation;
	import gameObjects.rigidObjects.RigidObjectBase;
	import gameObjects.StarObject;
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class SpecialObjectBuilder 
	{
		private var collection:AssetCollection = new AssetCollection();
		private var scale:Number;
		
		public function SpecialObjectBuilder(scaling:Number = 0.5) 
		{
			scale = scaling;
		}
		
		private var defaultStarWidth:Number = 50;
		private var defaultStarHeight:Number = 50;
		
		public function createBroom(xx:Number, yy:Number, length:Number = 500):RigidObjectBase
		{
			var broom:RigidObjectBase = new RigidObjectBase();
			broom.createDisplayBody(collection.balanceBoardAsset);
			broom.setSize(length, 15);
			broom.setPosition(xx, yy);
			broom.setFixtureProperties(0.5, 0.1, 0.8);
			broom.isBalanceBoard = true;
			
			return broom;
		}
		
		public function createMicrowave(xx:Number, yy:Number, tall:Boolean):Foundation
		{ 
			var microwave:Foundation = new Foundation();
			microwave.getBody().SetType(b2Body.b2_staticBody);
			microwave.createDisplayBody(collection.foundationAsset);
			microwave.setSize(40, 80, 0);
			microwave.setPosition(xx, yy);
			microwave.getBody().SetAngle(tall ? 0 : -Math.PI/2);
			microwave.setFixtureProperties(0, 0, 1);
			
			return microwave;
		}
		
		public function createBaseballBat(xx:Number, yy:Number):CompoundObject
		{
			var size:b2Vec2 = new b2Vec2(550, 45);
			var bbBat:CompoundObject = new CompoundObject();
			bbBat.createDisplayBody(collection.baseballAsset);
			bbBat.setAssetSize(size.x, size.y);
			bbBat.setPosition(xx-70, yy);
			bbBat.addBoxFixture(size.x * 2/5, size.y / 2, 0.2);
			bbBat.addBoxFixture(size.x * 3/5, size.y, 0.2);
			bbBat.isBalanceBoard = true;
			var fixt:b2Fixture = bbBat.getBody().GetFixtureList();
			bbBat.setFixtureProperties(0.2, 0.1, 0.8, fixt);
			fixt = fixt.GetNext();
			bbBat.setFixtureProperties(0.2, 0.1, 0.8, fixt);
			
			bbBat.arrangeFixture();
			
			return bbBat;
		}
		
		public function createBookStack(xx:Number, yy:Number):Foundation
		{
			var bookStack:Foundation = new Foundation();
			bookStack.getBody().SetType(b2Body.b2_staticBody);
			bookStack.createDisplayBody(collection.foundation2Asset);
			bookStack.setSize(40, 60, 0);
			bookStack.setPosition(xx, yy);
			bookStack.setFixtureProperties(0, 0, 1);
			
			return bookStack;
		}
		
		public function createGoldenStar(xx:Number, yy:Number):StarObject
		{
			return createStar(collection.goldenStarAsset, StarObject.GOLDEN, xx, yy);
		}
		
		public function createSilverStar(xx:Number, yy:Number):StarObject
		{
			return createStar(collection.silverStarAsset, StarObject.SILVER, xx, yy);
		}
		
		public function createBronzeStar(xx:Number, yy:Number):StarObject
		{
			return createStar(collection.bronzeStarAsset, StarObject.BRONZE, xx, yy);
		}
		
		private function createStar(starClass:Class, type:String, xx:Number, yy:Number):StarObject
		{
			var star:StarObject = new StarObject(starClass, type);
			star.x = xx;
			star.y = yy;
			star.width = defaultStarWidth;
			star.height = defaultStarHeight;
			return star;
		}
	}

}