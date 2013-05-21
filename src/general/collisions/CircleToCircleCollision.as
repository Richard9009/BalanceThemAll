package general.collisions 
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import org.flashdevelop.utils.FlashConnect;
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class CircleToCircleCollision extends Collision implements ICollisionTest
	{
		
		public function CircleToCircleCollision() 
		{
			
		}
		
		public function hitTest(circleA:Sprite, circleB:Sprite):Boolean
		{
			var radiusA:Number = circleA.width / 2;
			var radiusB:Number = circleB.width / 2;
			var maxDist:Number = radiusA + radiusB;

			return (distOf2Circles(new Point(circleA.x, circleA.y), new Point(circleB.x, circleB.y)) <= maxDist);
		}
		
		public function distOf2Circles(positionA:Point, positionB:Point):Number
		{
			var xDist:Number = positionA.x - positionB.x;
			var yDist:Number = positionA.y - positionB.y;
			return (Math.sqrt(xDist * xDist + yDist * yDist));
		}
		
	}

}