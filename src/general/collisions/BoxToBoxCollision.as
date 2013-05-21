package general.collisions 
{
	import flash.display.Sprite;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class BoxToBoxCollision extends Collision implements ICollisionTest
	{
		
		public function BoxToBoxCollision(useCache:Boolean = true) 
		{
			super(useCache);	
		}
		
		public function hitTest(boxA:Sprite, boxB:Sprite):Boolean
		{
			if (cacheOn && cache.bothAreStill(boxA, boxB)) return cache.wasColliding;
			
			if (boxA.hitTestObject(boxB) == false) return false;
			
			var rotAngleA:Number = Math.ceil(boxA.rotation);
			var rotAngleB:Number = Math.ceil(boxB.rotation);
			
			if (Math.abs(rotAngleA % 90) < ANGLE_TOLERERANCE && Math.abs(rotAngleB % 90) < ANGLE_TOLERERANCE) {
				return boxA.hitTestObject(boxB);
			}
		
			var cornerListA:Array = getCorners(boxA, true);
			var cornerListB:Array = getCorners(boxB, false);
			
			if (cacheOn) cache.saveCornerList(cornerListA, cornerListB);
			
			/* CORNER POINT ARRAY MAP
			 * 
			 * 0 _ _ _ _ _ _ _ _ 1
			 *  |			    |
			 *  |			    |
			 *  |			    |
			 *  |_ _ _ _ _ _ _ _|
			 * 2				 3
			 * 
			 */
			 var collided:Boolean = false;
			 var localCornersA:Array;
			 var localCornersB:Array;
			 
			 setLocalWorld(boxA);
			 localCornersA = convToLocal(cornerListA);
			 localCornersB = convToLocal(cornerListB);
			
			 collided = checkCollision(localCornersA, localCornersB);
			 
			 if (collided) {
				 return collided;
			 }
			 
			 setLocalWorld(boxB);
			 localCornersA = convToLocal(cornerListA);
			 localCornersB = convToLocal(cornerListB);
			 
			 collided = checkCollision(localCornersB, localCornersA );
			 
			 if (cacheOn) {
				 cache.wasColliding = collided;
				 cache.setNewCache(boxA, boxB);
			 }
			 
			 return collided; 
		}
		
		private function getCorners(obj:Sprite, isHost:Boolean):Array
		{
			var sizeVec:Point;
			var cornerList:Array;
			var recalculate:Boolean = true;
			
			if (cacheOn) {
				if(isHost) {
					if (cache.hostIsStill(obj)) {
						cornerList = cache.hostCorners;
						recalculate = false;
					}
				}
				else {
					if (cache.guestIsStill(obj)) {
						cornerList = cache.guestCorners;
						recalculate = false;
					}
				}
			}
			
			if (recalculate) {
				sizeVec = getOriginalSize(obj);
				cornerList = getOriginalCornerPoints(new Point(obj.x, obj.y), sizeVec);
				cornerList = getRotatedCornerPoints(new Point(obj.x, obj.y), cornerList, obj.rotation);
			}
			
			return cornerList; 
		}
		
		private function getOriginalCornerPoints(center:Point, sizeVec:Point):Array
		{
			var corners:Array = new Array();
			
			var upLVec:Point = new Point(center.x - sizeVec.x / 2, center.y - sizeVec.y / 2);
			corners.push(upLVec); // upleft
			var upRVec:Point = new Point(center.x + sizeVec.x / 2, center.y - sizeVec.y / 2);
			corners.push(upRVec); //upRight
			var lowLVec:Point = new Point(center.x - sizeVec.x / 2, center.y + sizeVec.y / 2);
			corners.push(lowLVec); //lowLeft
			var lowRVec:Point = new Point(center.x + sizeVec.x / 2, center.y + sizeVec.y / 2);
			corners.push(lowRVec); //lowRight
			
			return corners;
		}
		
		private function getRotatedCornerPoints(rotationCenter:Point, originalCorners:Array, rotation:Number):Array 
		{
			var rad:Number = rotation * Math.PI / 180;
			
			var newCorners:Array = new Array();
			
			for each(var v:Point in originalCorners) {
				
				var transV:Point = new Point();
				var rotV:Point = new Point();
				var newV:Point = new Point();
				
				transV.x = v.x - rotationCenter.x;
				transV.y = v.y - rotationCenter.y;
				
				rotV.x = transV.x * Math.cos(rad) - transV.y * Math.sin(rad);
				rotV.y = transV.x * Math.sin(rad) + transV.y * Math.cos(rad);
				
				newV.x = rotV.x + rotationCenter.x;
				newV.y = rotV.y + rotationCenter.y;
				
				newCorners.push(newV);
			}
			
			return newCorners;
		}
		
		private function convToLocal(corners:Array):Array
		{
			var newCorners:Array = new Array();
			var rad:Number = worldRotation * Math.PI / 180;
			
			for each(var v:Point in corners) {
				
				var newV:Point = new Point();
				var transVec:Point = new Point();
				
				transVec.x = v.x + worldTranslation.x;
				transVec.y = v.y + worldTranslation.y;
				
				newV.x = Math.round(transVec.x * Math.cos(rad) - transVec.y * Math.sin(rad));
				newV.y = Math.round(transVec.x * Math.sin(rad) + transVec.y * Math.cos(rad));
				
				newCorners.push(newV);
			}
			
			return newCorners;
		}
		
		private function checkCollision(hostCorners:Array, guestCorners:Array):Boolean
		{
			for each(var gCorner:Point in guestCorners)
			{
				
				if (gCorner.x > hostCorners[0].x && gCorner.x < hostCorners[1].x)
				{
					if (gCorner.y > hostCorners[0].y && gCorner.y < hostCorners[2].y)
					{
						return true;
					}
				}
			}
			
			return false;
		}
		
	}

}