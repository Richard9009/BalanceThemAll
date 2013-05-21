package general.collisions 
{
	import flash.display.Sprite;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class BoxToCircleCollision extends Collision implements ICollisionTest
	{
		
		public function BoxToCircleCollision() 
		{
			
		}
		
		public function hitTest(box:Sprite, circle:Sprite):Boolean
		{
			setLocalWorld(box);
			
			var boxSizeVec:Point = getOriginalSize(box);
			var localCirclePos:Point = convToLocal(new Point(circle.x, circle.y));
			return checkCollision(boxSizeVec, localCirclePos, circle.width / 2);
		}
		
		private function convToLocal(point:Point):Point
		{
			var transVec:Point = new Point()
			var newPoint:Point = new Point();
			var rad:Number = worldRotation * Math.PI / 180;

			transVec.x = point.x + worldTranslation.x;
			transVec.y = point.y + worldTranslation.y;
				
			newPoint.x = Math.round(transVec.x * Math.cos(rad) - transVec.y * Math.sin(rad));
			newPoint.y = Math.round(transVec.x * Math.sin(rad) + transVec.y * Math.cos(rad));
			
			return newPoint;
		}
		
		private function checkCollision(boxSize:Point, circleCenter:Point, radius:Number):Boolean
		{
			if (Math.abs(circleCenter.x) < boxSize.x/2 + radius) {
				if (Math.abs(circleCenter.y) < boxSize.y/2 + radius) {
					var boxDia:Number = Math.sqrt(Math.pow(boxSize.x / 2, 2) + Math.pow(boxSize.y / 2 , 2));
					var dist:Number = Math.sqrt(circleCenter.x * circleCenter.x + circleCenter.y * circleCenter.y);
					if (dist < boxDia + radius) return true;
				}
			}
			
			return false;
		}
		
		
	}

}