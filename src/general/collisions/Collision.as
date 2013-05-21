package general.collisions 
{
	import flash.display.Sprite;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class Collision 
	{
		public static const BOX_TO_BOX:String =  "box2box";
		public static const ANGLE_TOLERERANCE:Number = 2;
		
		protected var cache:CollisionCache;
		protected var cacheOn:Boolean = true;
		
		protected var worldTranslation:Point = new Point;
		protected var worldRotation:Number;
		protected var worldHost:Sprite;
	
		public function Collision(useCache:Boolean = true) 
		{
			if (useCache) cache = new CollisionCache();
			cacheOn = useCache;
		}
		
		protected function setLocalWorld(host:Sprite):void
		{
			worldTranslation.x = -host.x;
			worldTranslation.y = -host.y;
			worldRotation = -host.rotation;
			worldHost = host;
		}
		
		protected function getOriginalSize(s:Sprite):Point
		{
			var currentRot:Number = s.rotation;
			s.rotation = 0;
			var sizeV:Point = new Point(s.width, s.height);
			s.rotation = currentRot;
			
			return sizeV;
		}
		
		
	}

}