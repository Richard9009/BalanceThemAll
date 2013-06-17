package general 
{
	import assets.AssetCollection;
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