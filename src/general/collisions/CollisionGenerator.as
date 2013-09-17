package general.collisions 
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import org.flashdevelop.utils.FlashConnect;
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class CollisionGenerator 
	{
		public static const BOX:String = "box";
		public static const CIRCLE:String = "circle";
		
		public function CollisionGenerator() 
		{
			
		}
		
		public static function getCollisionStatus(spriteA:ICollisionObject, spriteB:ICollisionObject):Boolean
		{
			var collision:ICollisionTest;
			var host:Sprite = spriteA as Sprite;
			var guest:Sprite = spriteB as Sprite;
		
			switch(spriteA.getType()) {
				case BOX: if (spriteB.getType() == CIRCLE) collision = new BoxToCircleCollision();
						  else if (spriteB.getType() == BOX) collision = new BoxToBoxCollision(false);
						  break;
				case CIRCLE: if (spriteB.getType() == CIRCLE) collision = new CircleToCircleCollision();
							else if (spriteB.getType() == BOX) {
								host = spriteB as Sprite;
								guest = spriteA as Sprite;
								collision = new BoxToCircleCollision();
							}
							break;
				default: return(host.hitTestObject(guest));
			}
			
			return collision.hitTest(host, guest);
		}
		
		public static function isAbelowB(objA:Sprite, objB:Sprite):Boolean
		{
			
			var counterRotA:Number = -(objA.rotation%90) * Math.PI / 180;
			//limit rotation value from -45 to 45
			if (counterRotA > Math.PI / 4) counterRotA -= Math.PI / 2;
			if (counterRotA < -Math.PI / 4) counterRotA += Math.PI / 2;
			
			var posA:Point = new Point(objA.x, objA.y);
			var posB:Point = new Point(objB.x, objB.y);
			
			var sizeA:Point = new Point(objA.width, objA.height);
			var sizeB:Point = new Point(objB.width, objB.height);
			
			//======SET A AS HOST=================================================
			posB.x -= posA.x;
			posB.y -= posA.y;
			posA = new Point();
			
			//=======ROTATE B ACCORDING TO A======================================
			var posB_noRot:Point = posB.clone();
			posB.x = posB_noRot.x * Math.cos(counterRotA) - posB_noRot.y * Math.sin(counterRotA);
			posB.y = posB_noRot.x * Math.sin(counterRotA) + posB_noRot.y * Math.cos(counterRotA);
			
			trace(posB.y);
			if (posB.y > 0) trace(counterRotA * 180 / Math.PI);
			
			return posB.y < 0;
		}
		
	}

}