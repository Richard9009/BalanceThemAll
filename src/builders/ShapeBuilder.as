package builders 
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class ShapeBuilder 
	{
		
		public function ShapeBuilder() 
		{
			
		}
		
		public function boxShape(userData:Sprite):b2PolygonShape
		{
			var width:Number = userData.width / Main._physScale;
			var height:Number = userData.height / Main._physScale;
			
			var shape:b2PolygonShape = new b2PolygonShape();
			shape.SetAsBox(width / 2, height / 2);
			return shape;
		}
		
		public function shoeShape(userData:Sprite):b2PolygonShape
		{
			var width:Number = userData.width / Main._physScale;
			var height:Number = userData.height / Main._physScale;
			
			var shape:b2PolygonShape = new b2PolygonShape();
			var verArray:Array = new Array();
			verArray = [ 
						 new b2Vec2(width/2, height/2),
						 new b2Vec2(width/2, -height/2),
						 new b2Vec2(0, -height / 2),
						 new b2Vec2( -width / 2, height / 6),
						 new b2Vec2( -width / 2, height / 2)
					   ];
					   
			shape.SetAsArray(verArray, 5);
			return shape;
		}
		
	}

}