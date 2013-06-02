package general.animations 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class LinearAnimation extends AnimationBaseClass 
	{
		
		public function LinearAnimation() 
		{
			super(getEnforcer());
		}
		
		private var totalDistance:Number = 0;
		public function constantMove(movingObject:Sprite, start:Point, end:Point, timeInMiliSec:Number = 1000):void
		{
			object = movingObject;
			startPosition = start;
			endPosition = end;
			acceleration = 0;
			
			totalDistance = distanceOfTwoPoints(start, end);
			if (totalDistance == 0) return;
			
			speed = totalDistance / (timeInMiliSec/FRAME_RATE);
			angle = Math.atan2(start.y - end.y, start.x - end.x);
			
			object.addEventListener(Event.ENTER_FRAME, moving);
		}
		
		private function moving(e:Event):void 
		{
			speed += acceleration;
			speedVec = new Point(speed * Math.cos(angle), speed * Math.sin(angle));
			
			object.x += speedVec.x;
			object.y -= speedVec.y;
			var travelledDist:Number = distanceOfTwoPoints(new Point(object.x, object.y), startPosition);
			
			if (travelledDist >= totalDistance) {
				object.removeEventListener(Event.ENTER_FRAME, moving);
				object.x = endPosition.x;
				object.y = endPosition.y;
			}
		}
		
	}

}