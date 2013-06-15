package gameObjects.rigidObjects 
{
	import Box2D.Collision.b2AABB;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Collision.Shapes.b2Shape;
	import Box2D.Common.Math.b2Mat22;
	import Box2D.Common.Math.b2Transform;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Fixture;
	import org.flashdevelop.utils.FlashConnect;
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class CompoundObject extends RigidObjectBase 
	{
		
		private var trans:b2Transform;
		
		public function CompoundObject() 
		{
			super();	
		}
		
		public function addBoxFixture(w:Number, h:Number, density:Number = 0.3):void
		{
			var shape:CustomPolygonShape = new CustomPolygonShape();
			var bodyPos:b2Vec2 = rigidBody.GetPosition();
			shape.SetAsBox((w / 2) / Main._physScale, (h / 2) / Main._physScale);
			shape.CalculateBoundingBox(trans);
			rigidBody.CreateFixture2(shape, density);
		}
		
		public function arrangeFixture(alignment:String = "horizontal"):void
		{
			if (alignment == "horizontal") arrangeFixturesSideBySide();
		}
		
		private function arrangeFixturesSideBySide():void 
		{
			var nextX:Number = -(width/2)/Main._physScale;
			for (var fix:b2Fixture = rigidBody.GetFixtureList(); fix; fix = fix.GetNext()) {
				var shape:CustomPolygonShape = fix.GetShape() as CustomPolygonShape;
				if (shape) {
					var xyVector:b2Vec2 = new b2Vec2(nextX + shape.width / 2, 0);
					shape.SetAsOrientedBox(shape.width / 2, shape.height / 2, xyVector);
					nextX += shape.width;
				}
			}
		}
		
		private function destroyDefaultFixture():void
		{
			rigidBody.DestroyFixture(rigidBody.GetFixtureList());
		}
		
		public function setAssetSize(w:Number, h:Number):void
		{
			width = w;
			height = h;
		}
		
		override public function createRigidBody():void 
		{
			super.createRigidBody();
			
			trans = new b2Transform();
			trans.Initialize(rigidBody.GetPosition(), new b2Mat22());
			destroyDefaultFixture();
		}
	}
}
import Box2D.Collision.b2AABB;
import Box2D.Collision.Shapes.b2PolygonShape;
import Box2D.Collision.Shapes.b2Shape;
import Box2D.Common.Math.b2Transform;
import Box2D.Common.Math.b2Vec2;

class CustomPolygonShape extends b2PolygonShape 
{
	private var aabb:b2AABB = new b2AABB();
	private var whVector:b2Vec2 = new b2Vec2();
	
	public function CustomPolygonShape():void { }
	
	public function CalculateBoundingBox(transform:b2Transform):void 
	{
		ComputeAABB(aabb, transform);
		whVector = new b2Vec2(aabb.upperBound.x - aabb.lowerBound.x,
							 aabb.upperBound.y - aabb.lowerBound.y);
	}
	
	override public function Copy():b2Shape 
	{
		var copy:CustomPolygonShape = new CustomPolygonShape();
		var superCopy:b2Shape = super.Copy();
		copy.Set(superCopy);
		copy.aabb = aabb;
		copy.whVector = whVector;
		return copy;
	}
	
	public function get width():Number { return whVector.x; }
	public function get height():Number { return whVector.y; }
}