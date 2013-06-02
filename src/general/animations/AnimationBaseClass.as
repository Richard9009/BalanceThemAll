package general.animations 
{
	import flash.display.Sprite;
	import flash.errors.IllegalOperationError;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class AnimationBaseClass 
	{
		protected static const FRAME_RATE:Number = 30;
		
		protected var object:Sprite;
		protected var startPosition:Point;
		protected var endPosition:Point;
		protected var startSize:Point;
		protected var endSize:Point;
		protected var speedVec:Point;
		protected var speed:Number = 5;
		protected var acceleration:Number = 0;
		protected var angle:Number = 0;
		
		public function AnimationBaseClass(enforcer:AbstractClassEnforcer) 
		{
			if (enforcer == null) throw new IllegalOperationError("This class in an abstract class, it can't be instantiated");
		}
		
		protected function distanceOfTwoPoints(pointA:Point, pointB:Point):Number
		{
			return Math.sqrt(Math.pow(pointA.x - pointB.x, 2) + Math.pow(pointA.y - pointB.y, 2));
		}
		
		protected function getEnforcer():AbstractClassEnforcer
		{
			return new AbstractClassEnforcer();
		}
	}

}

class AbstractClassEnforcer { 
	
	public function AbstractClassEnforcer(){ }
}