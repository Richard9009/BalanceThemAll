package builders
{
	import Box2D.Dynamics.b2Body;
	import gameObjects.*;
	import gameObjects.rigidObjects.*;
	import assets.AssetCollection;
	import assets.SoundCollection;
	import Box2D.Common.Math.b2Vec2;
	import flash.display.Sprite;
	import org.flashdevelop.utils.FlashConnect;
	import stages.StageConfig;
	
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class ObjectBuilder
	{
		private var minStageLimit:b2Vec2;
		private var maxStageLimit:b2Vec2;
		private var collection:AssetCollection = new AssetCollection();
		private var soundCol:SoundCollection = new SoundCollection();
		private var scale:Number;
		private var shape:ShapeBuilder = new ShapeBuilder();
		
		public function ObjectBuilder(scaling:Number = 0.5)
		{
			scale = scaling;
			minStageLimit = new b2Vec2(StageConfig.BORDER_THICKNESS, StageConfig.HEADER_HEIGHT + StageConfig.BORDER_THICKNESS);
			maxStageLimit = new b2Vec2(StageConfig.STAGE_WIDTH - StageConfig.BORDER_THICKNESS, StageConfig.STAGE_HEIGHT - StageConfig.BORDER_THICKNESS);
		
		}
		
		public function createBasketBall(howMany:int):Array
		{
			var objArray:Array = new Array();
			var obj:NormalRoundObject;
			for (var i:int = 0; i < howMany; i++)
			{
				obj = new NormalRoundObject(minStageLimit, maxStageLimit);
				obj.createDisplayBody(collection.basketBallAsset);
				obj.setFixtureProperties(0.4, 0.8, 0.4);
				obj.setRoundSize(35 * scale);
				obj.setRandomPositionInsideItemBox();
				obj.setSound(new soundCol.ballImpactSound(), null, new soundCol.ballRollingSound());
				objArray.push(obj);
			}
			
			return objArray;
		}
		
		public function createTennisBall(howMany:int):Array
		{
			var objArray:Array = new Array();
			var obj:NormalRoundObject;
			for (var i:int = 0; i < howMany; i++)
			{
				obj = new NormalRoundObject(minStageLimit, maxStageLimit);
				obj.createDisplayBody(collection.tennisBallAsset);
				obj.setFixtureProperties(0.2, 0.7, 0.1);
				obj.setRoundSize(21 * scale);
				obj.setRandomPositionInsideItemBox();
				obj.setSound(new soundCol.ballImpactSound(), null, new soundCol.ballRollingSound());
				objArray.push(obj);
			}
			
			return objArray;
		}
		
		public function createBowlingBall(howMany:int):Array
		{
			var objArray:Array = new Array();
			var obj:NormalRoundObject;
			for (var i:int = 0; i < howMany; i++)
			{
				obj = new NormalRoundObject(minStageLimit, maxStageLimit);
				obj.createDisplayBody(collection.bowlingBallAsset);
				obj.setFixtureProperties(1, 0.8, 0.2);
				obj.setRoundSize(50 * scale);
				obj.setRandomPositionInsideItemBox();
				obj.setSound(new soundCol.heavyImpactSound());
				objArray.push(obj);
			}
			
			return objArray;
		}
		
		public function createShoes(howMany:int):Array
		{
			var objArray:Array = new Array();
			var obj:NormalBoxObject;
			for (var i:int = 0; i < howMany; i++)
			{
				obj = new NormalBoxObject(minStageLimit, maxStageLimit);
				obj.createDisplayBody(collection.shoeAsset);
				obj.setFixtureProperties(0.3, 0.2, 0.5);
				obj.setSize(180 * scale, 100 * scale);
				obj.changeShape(shape.shoeShape(obj));
				obj.setRandomPositionInsideItemBox();
				obj.setSound(new soundCol.mediumImpactSound());
				objArray.push(obj);
			}
			
			return objArray;
		}
		
		public function createGlassVase(howMany:int):Array
		{
			var objArray:Array = new Array();
			var obj:NormalBoxObject;
			for (var i:int = 0; i < howMany; i++)
			{
				obj = new NormalBoxObject(minStageLimit, maxStageLimit, true);
				obj.durability = 0.5;
				obj.createDisplayBody(collection.glassVaseAsset);
				obj.setFixtureProperties(0.1, 0.1, 0.1);
				obj.setSize(50 * scale, 100 * scale);
				obj.setRandomPositionInsideItemBox();
				obj.setSound(new soundCol.glassImpactSound(), new soundCol.glassBreakingSound());
				objArray.push(obj);
			}
			
			return objArray;
		}
		
		public function createMug(howMany:int):Array
		{
			var objArray:Array = new Array();
			var obj:NormalBoxObject;
			for (var i:int = 0; i < howMany; i++)
			{
				obj = new NormalBoxObject(minStageLimit, maxStageLimit);
				obj.createDisplayBody(collection.mugAsset);
				obj.setFixtureProperties(0.15, 0.1, 0.2);
				obj.setSize(56 * scale, 125 * scale);
				obj.setRandomPositionInsideItemBox();
				obj.setSound(new soundCol.glassImpactSound());
				objArray.push(obj);
			}
			
			return objArray;
		}
		
		public function createPhoto(howMany:int):Array
		{
			var objArray:Array = new Array();
			var obj:NormalBoxObject;
			for (var i:int = 0; i < howMany; i++)
			{
				obj = new NormalBoxObject(minStageLimit, maxStageLimit);
				obj.createDisplayBody(collection.photoAsset);
				obj.setFixtureProperties(0.1, 0.1, 0.5);
				obj.setSize(73 * scale, 91 * scale);
				obj.setRandomPositionInsideItemBox();
				obj.setSound(new soundCol.woodImpactSound());
				objArray.push(obj);
			}
			
			return objArray;
		}
		
		public function createBlueBook(howMany:int):Array
		{
			var objArray:Array = new Array();
			var obj:NormalBoxObject;
			for (var i:int = 0; i < howMany; i++)
			{
				obj = new NormalBoxObject(minStageLimit, maxStageLimit);
				obj.createDisplayBody(collection.blueBookAsset);
				obj.setFixtureProperties(0.5, 0.1, 0.2);
				obj.setSize(100 * scale, 40 * scale);
				obj.setRandomPositionInsideItemBox();
				obj.setSound(new soundCol.bookImpactSound());
				objArray.push(obj);
			}
			
			return objArray;
		}
		
		public function createEncyclopedia(howMany:int):Array
		{
			var objArray:Array = new Array();
			var obj:NormalBoxObject;
			for (var i:int = 0; i < howMany; i++)
			{
				obj = new NormalBoxObject(minStageLimit, maxStageLimit);
				obj.createDisplayBody(collection.encyclopediaAsset);
				obj.setFixtureProperties(0.6, 0.1, 0.5);
				obj.setSize(75 * scale, 150 * scale);
				obj.setRandomPositionInsideItemBox();
				obj.setSound(new soundCol.bookImpactSound());
				objArray.push(obj);
			}
			
			return objArray;
		}
		
		public function createPillow(howMany:int):Array
		{
			var objArray:Array = new Array();
			var obj:NormalBoxObject;
			for (var i:int = 0; i < howMany; i++)
			{
				obj = new NormalBoxObject(minStageLimit, maxStageLimit);
				obj.createDisplayBody(collection.pillowAsset);
				obj.setFixtureProperties(0.3, 0, 0.9);
				obj.setSize(200 * scale, 56 * scale);
				obj.changeShape(shape.pillowShape(obj));
				obj.setRandomPositionInsideItemBox();
				obj.setSound(new soundCol.pillowImpactSound());
				objArray.push(obj);
			}
			
			return objArray;
		}
		
		public function createHeavyObject(howMany:int):Array
		{
			var objArray:Array = new Array();
			var obj:NormalBoxObject;
			for (var i:int = 0; i < howMany; i++)
			{
				obj = new NormalBoxObject(minStageLimit, maxStageLimit);
				obj.createDisplayBody(collection.heavyObjectAsset);
				obj.setFixtureProperties(1, 0, 1);
				obj.setSize(150 * scale, 135 * scale);
				//obj.changeShape(shape.barbelShape(obj));
				obj.setRandomPositionInsideItemBox();
				obj.setSound(new soundCol.heavyImpactSound());
				objArray.push(obj);
			}
			
			return objArray;
		}
	}

}