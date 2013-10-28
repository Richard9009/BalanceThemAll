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
		private var width:Number;
		private var height:Number;
		
		public function ShapeBuilder() 
		{
			
		}
		
		public function boxShape(userData:Sprite):b2PolygonShape
		{
			matchSize(userData);
			
			var shape:b2PolygonShape = new b2PolygonShape();
			shape.SetAsBox(width / 2, height / 2);
			return shape;
		}
		
		public function shoeShape(userData:Sprite):b2PolygonShape
		{
			matchSize(userData);
			
			var shape:b2PolygonShape = new b2PolygonShape();
			var verArray:Vector.<b2Vec2> = new Vector.<b2Vec2>;
			verArray.push(new b2Vec2( -width / 2, height / 6));
			verArray.push(new b2Vec2(0, -height / 2));
			verArray.push(new b2Vec2(width / 2, -height / 2));
			verArray.push(new b2Vec2(width / 2, height / 2));
			verArray.push(new b2Vec2( -width / 2, height / 2));
				   
			shape.SetAsVector(verArray, 5);
			return shape;
		}
		
		public function pillowShape(userData:Sprite):b2PolygonShape
		{
			matchSize(userData);
			
			var shape:b2PolygonShape = new b2PolygonShape();
			var verArray:Vector.<b2Vec2> = new Vector.<b2Vec2>;
			verArray.push(new b2Vec2( -width / 2, 0));
			verArray.push(new b2Vec2(-width * 3/8, -height / 2));
			verArray.push(new b2Vec2(width * 3/8, -height / 2));
			verArray.push(new b2Vec2(width / 2, 0));
			verArray.push(new b2Vec2(width * 3 / 8, height / 2));
			verArray.push(new b2Vec2(-width * 3/8, height / 2));
				   
			shape.SetAsVector(verArray, 6);
			return shape;
		}
		
		public function barbelShape(userData:Sprite):b2PolygonShape
		{
			matchSize(userData);
			
			var shape:b2PolygonShape = new b2PolygonShape();
			var verArray:Vector.<b2Vec2> = new Vector.<b2Vec2>;
			verArray.push(new b2Vec2( -width / 2, height / 4));
			verArray.push(new b2Vec2( -width / 2, -height / 4));
			verArray.push(new b2Vec2(-width * 3/10, -height / 2));
			verArray.push(new b2Vec2(width * 3/10, -height / 2));
			verArray.push(new b2Vec2(width / 2, -height / 4));
			verArray.push(new b2Vec2(width / 2, height / 4));
			verArray.push(new b2Vec2(width * 3/10, height / 2));
			verArray.push(new b2Vec2(-width * 3/10, height / 2));
				   
			shape.SetAsVector(verArray, 8);
			return shape;
		}
		
		public function baseballBatShape(userData:Sprite):b2PolygonShape
		{
			matchSize(userData);
			
			var shape:b2PolygonShape = new b2PolygonShape();
			var verArray:Vector.<b2Vec2> = new Vector.<b2Vec2>;
			
			verArray.push(new b2Vec2( -width / 2, 0));
			verArray.push(new b2Vec2( -width / 2 + width/50, -height / 2));
			verArray.push(new b2Vec2(width / 2, -height / 4));
			verArray.push(new b2Vec2(width / 2, height / 4));
			verArray.push(new b2Vec2( -width / 2 + width / 50, height / 2));
			
			shape.SetAsVector(verArray, 5);
			return shape;
		}
		
		public function snowPileShape(userData:Sprite):b2PolygonShape
		{
			matchSize(userData);
			
			var shape:b2PolygonShape = new b2PolygonShape();
			var verArray:Vector.<b2Vec2> = new Vector.<b2Vec2>;
			
			verArray.push(new b2Vec2( -width / 2, height / 2));
			verArray.push(new b2Vec2( -width / 6, -height / 2 + height / 10));
			verArray.push(new b2Vec2(width / 6, -height / 2 + height / 10));
			verArray.push(new b2Vec2(width / 2, height / 2));
			
			shape.SetAsVector(verArray, 4);
			return shape;
		}
		
		public function penguinShape(userData:Sprite):b2PolygonShape
		{
			matchSize(userData);
			
			var shape:b2PolygonShape = new b2PolygonShape();
			var verArray:Vector.<b2Vec2> = new Vector.<b2Vec2>;
			
			verArray.push(new b2Vec2( -width * (1/2 - 1/10), height / 2));
			verArray.push(new b2Vec2( -width / 2, -height * (1/2 - 1/7)));
			verArray.push(new b2Vec2( -width / 5, -height / 2));
			verArray.push(new b2Vec2(width * 3/10, 0));
			verArray.push(new b2Vec2( width / 2, height / 2));
			
			shape.SetAsVector(verArray, 5);
			return shape;
		}
		
		public function gravityBoxShape(userData:Sprite):b2PolygonShape
		{
			matchSize(userData);
			var shape:b2PolygonShape = new b2PolygonShape();
			var verArray:Vector.<b2Vec2> = new Vector.<b2Vec2>;
			
			verArray.push(new b2Vec2( -width/2, height / 2));
			verArray.push(new b2Vec2( -width / 2, -height * 2/5));
			verArray.push(new b2Vec2( width / 2, -height * 2/5));
			verArray.push(new b2Vec2(width / 2, height / 2));
			
			shape.SetAsVector(verArray, 4);
			return shape;
		}
		
		public function triangleShape(userData:Sprite):b2PolygonShape
		{
			matchSize(userData);
			var shape:b2PolygonShape = new b2PolygonShape();
			var verArray:Vector.<b2Vec2> = new Vector.<b2Vec2>;
			
			verArray.push(new b2Vec2( -width/2, height / 2));
			verArray.push(new b2Vec2( 0, -height / 2));
			verArray.push(new b2Vec2(width / 2, height / 2));
			
			shape.SetAsVector(verArray, 3);
			return shape;
		}
		
		public function lightHolderShape(userData:Sprite):b2PolygonShape
		{
			matchSize(userData);
			var shape:b2PolygonShape = new b2PolygonShape();
			var verArray:Vector.<b2Vec2> = new Vector.<b2Vec2>;
			
			
			verArray.push(new b2Vec2( -width/2, height / 2));
			verArray.push(new b2Vec2( -width/2, -height * 3/11));
			verArray.push(new b2Vec2( 0, -height /2));
			verArray.push(new b2Vec2(width / 2, -height * 3/11));
			verArray.push(new b2Vec2( width/2, height / 2));
			
			shape.SetAsVector(verArray, 5);
			return shape;
		}
		private function matchSize(userData:Sprite):void
		{
			width = userData.width / Main._physScale;
			height = userData.height / Main._physScale;
		}
		
	}

}