package builders 
{
	import assets.AssetCollection;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2Fixture;
	import flash.display.Shape;
	import flash.display.Sprite;
	import gameObjects.rigidObjects.CompoundObject;
	import gameObjects.rigidObjects.GravityBall;
	import gameObjects.rigidObjects.GravityBlock;
	import gameObjects.rigidObjects.NormalBoxObject;
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
		
		public function createMicrowave(xx:Number, yy:Number, tall:Boolean):RigidObjectBase
		{ 
			var microwave:RigidObjectBase = new RigidObjectBase();
			microwave.getBody().SetType(b2Body.b2_staticBody);
			microwave.createDisplayBody(collection.foundationAsset);
			microwave.setSize(40, 80, 0);
			var whGap:Number = (microwave.height - microwave.width) / 2;
			microwave.setPosition(xx, yy - ((tall) ? whGap : 0));
			microwave.getBody().SetAngle(tall ? 0 : -Math.PI/2);
			microwave.setFixtureProperties(0, 0, 1);
			
			return microwave;
		}
		
		public function createBaseballBat(xx:Number, yy:Number):RigidObjectBase
		{
			var size:b2Vec2 = new b2Vec2(550, 45);
			var bbBat:RigidObjectBase = new RigidObjectBase();
			bbBat.createDisplayBody(collection.baseballAsset);
			bbBat.setSize(size.x, size.y);
			bbBat.setFixtureProperties(0.2, 0.2, 0.8);
			bbBat.changeShape(new ShapeBuilder().baseballBatShape(bbBat));
			bbBat.setPosition(xx-70, yy);
			bbBat.isBalanceBoard = true;
			
			return bbBat;
		}
		
		public function createBookStack(xx:Number, yy:Number):RigidObjectBase
		{
			var bookStack:RigidObjectBase = new RigidObjectBase();
			bookStack.getBody().SetType(b2Body.b2_staticBody);
			bookStack.createDisplayBody(collection.foundation2Asset);
			bookStack.setSize(40, 60, 0);
			bookStack.setPosition(xx, yy);
			bookStack.setFixtureProperties(0, 0, 1);
			
			return bookStack;
		}
		
		public function createSnowPile(xx:Number, yy:Number, tall:Boolean = false):RigidObjectBase
		{
			var snowPile:RigidObjectBase = new RigidObjectBase();
			snowPile.getBody().SetType(b2Body.b2_staticBody);
			snowPile.createDisplayBody(collection.snowPileAsset);
			snowPile.setSize(108, tall ? 180 : 60, 0);
			snowPile.changeShape(new ShapeBuilder().snowPileShape(snowPile));
			snowPile.setPosition(xx, yy);
			snowPile.setFixtureProperties(0, 0, 100);
			
			return snowPile;
		}
		
		public function createIceBeam(xx:Number, yy:Number, short:Boolean = false):RigidObjectBase
		{
			var iceBeam:RigidObjectBase = new RigidObjectBase();
			iceBeam.createDisplayBody(collection.iceBeamAsset);
			iceBeam.setSize(short ? 400 : 600, 15, 0);
			iceBeam.setPosition(xx, yy);
			iceBeam.setFixtureProperties(0.5, 0, 0.01);
			iceBeam.isBalanceBoard = true;
			
			return iceBeam;
		}
		
		public function createGravityBlock(xx:Number, yy:Number):GravityBlock
		{
			var gravBlock:GravityBlock = new GravityBlock();
			gravBlock.createDisplayBody(collection.gravBoxAsset);
			gravBlock.setSize(55, 60);
			gravBlock.setPosition(xx, yy);
			gravBlock.changeShape(new ShapeBuilder().gravityBoxShape(gravBlock));
			gravBlock.setFixtureProperties(0, 0, 0.5);
			
			return gravBlock;
			
		}
		
		public function createGravityBall(xx:Number, yy:Number):GravityBall
		{
			var gravBall:GravityBall = new GravityBall();
			gravBall.createDisplayBody(collection.gravBallAsset);
			gravBall.setSize(60, 60);
			gravBall.setPosition(xx, yy);
			gravBall.setRoundSize(30, 0.5);
			gravBall.setFixtureProperties(0, 0, 0.5);
			
			return gravBall;
		}
		
		public function createShoeOutline(xx:Number, yy:Number):Sprite
		{
			var outline:Sprite = new collection.shoeOutlineAsset();
			outline.width = 90;
			outline.height = 50;
			outline.x = xx;
			outline.y = yy;
			return outline;
		}
		
		public function createGoldenStar(xx:Number, yy:Number):StarObject
		{
			return createStar(StarObject.GOLDEN, xx, yy);
		}
		
		public function createSilverStar(xx:Number, yy:Number):StarObject
		{
			return createStar(StarObject.SILVER, xx, yy);
		}
		
		public function createBronzeStar(xx:Number, yy:Number):StarObject
		{
			return createStar(StarObject.BRONZE, xx, yy);
		}
		
		private function createStar(type:String, xx:Number, yy:Number):StarObject
		{
			var star:StarObject = new StarObject(type);
			star.x = xx;
			star.y = yy;
			star.width = defaultStarWidth;
			star.height = defaultStarHeight;
			return star;
		}
	}

}