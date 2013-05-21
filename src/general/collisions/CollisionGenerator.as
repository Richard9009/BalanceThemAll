package general.collisions 
{
	import flash.display.Sprite;
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
		
	}

}