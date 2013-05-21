package general.collisions 
{
	import flash.display.Sprite;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class CollisionCache 
	{
		public var wasColliding:Boolean;
		public var hostCorners:Array;
		public var guestCorners:Array;
		
		private var hostPosition:Point;
		private var guestPosition:Point;
		private var hostRotation:Number;
		private var guestRotation:Number;
		private var cacheIsEmpty:Boolean = true;
		
		public function CollisionCache() 
		{
			
		}
		
		public function setNewCache(host:Sprite, guest:Sprite):void
		{
			hostPosition = new Point(host.x, host.y);
			hostRotation = host.rotation;
			
			guestPosition = new Point(guest.x, guest.y);
			guestRotation = guest.rotation;
			
			cacheIsEmpty = false;
		}
		
		public function saveCornerList(hCorner:Array, gCorner:Array):void
		{
			hostCorners = hCorner;
			guestCorners = gCorner;
		}
		
		public function bothAreStill(hSprite:Sprite, gSprite:Sprite):Boolean
		{
			return (hostIsStill(hSprite) && guestIsStill(gSprite));
		}
		
		public function hostIsStill(hSprite:Sprite):Boolean
		{
			if (cacheIsEmpty) return false;
			
			if (!(hostPosition.x == hSprite.x)) return false;
			if (!(hostPosition.y == hSprite.y)) return false;
			if (!(hostRotation == hSprite.rotation)) return false;
			
			return true;
		}
		
		public function guestIsStill(gSprite:Sprite):Boolean
		{
			if (cacheIsEmpty) return false;
			
			if (!(guestPosition.x == gSprite.x)) return false;
			if (!(guestPosition.y == gSprite.y)) return false;
			if (!(guestRotation == gSprite.rotation)) return false;
			
			return true;
		}
		
		public function cleanCache():void
		{
			wasColliding = false;
			hostCorners = null;
			guestCorners = null;
			
			hostPosition = null;
			guestPosition = null;
			hostRotation = 0;
			guestRotation = 0;
			cacheIsEmpty = true;
		
		}
		
		
	}

}