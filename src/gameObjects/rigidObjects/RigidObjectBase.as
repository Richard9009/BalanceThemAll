package gameObjects.rigidObjects 
{
	import Box2D.Collision.b2Collision;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Collision.Shapes.b2Shape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2ContactListener;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.Contacts.b2Contact;
	import flash.events.Event;
	import general.collisions.BoxToBoxCollision;
	import general.collisions.CollisionGenerator;
	import general.collisions.ICollisionObject;
	import org.flashdevelop.utils.FlashConnect;
	
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class RigidObjectBase extends Sprite implements ICollisionObject
	{
		
		/**************DEFAULT PHYSICS PARAMETERS*****************************/
		
		protected static const DEF_DENSITY:Number = 0.3;
		protected static const DEF_RESTITUTION:Number = 0.2;
		protected static const DEF_FRICTION:Number = 0.5;
		protected static const DEF_HEIGHT:Number = 50;
		protected static const DEF_WIDTH:Number = 80;
		protected static const DEF_X:Number = 400;
		protected static const DEF_Y:Number = 500;
		protected static const DEF_SHAPE:b2PolygonShape = new b2PolygonShape();
		
		/*********************************************************************/
		
		protected static var nextID:int = 0;
		public var id:int;
		public var isBalanceBoard:Boolean = false;
		
		protected var bDef:b2BodyDef;
		protected var fDef:b2FixtureDef;
		protected var rigidBody:b2Body;
		protected var shape:b2Shape;
		protected var asset:Class;
		
		protected var checkCollision:Boolean = false;
		protected var isColliding:Boolean = false;
		protected var collidingBodyList:Array = new Array();
		
		private var collision:BoxToBoxCollision = new BoxToBoxCollision();
		
		public function RigidObjectBase() 
		{
			super();
			bDef = new b2BodyDef();
			fDef = new b2FixtureDef();
			nextID++;
			id = nextID;
			
			createRigidBody();
		}
		
		protected function onEnterFrame(e:Event):void 
		{
			isColliding = false;
			collidingBodyList = new Array();
			
			if (checkCollision && !isColliding)
			{	
				for (var bb:b2Body = Main.getWorld().GetBodyList(); bb; bb = bb.GetNext())
				{	
					if(bb.GetUserData() is Sprite && bb.GetUserData() != this) {
						
						isColliding = CollisionGenerator.getCollisionStatus(this, bb.GetUserData());
						
						if(isColliding) return;
					}
				}
			}
		}
		
		public function getType():String {
			return CollisionGenerator.BOX;
		}
		
		/* INTERFACE gameObjects.IRigidObject */
		
		public function createRigidBody():void 
		{		
			DEF_SHAPE.SetAsBox(DEF_WIDTH / Main._physScale, DEF_HEIGHT / Main._physScale);
			
			bDef.position.Set(DEF_X / Main._physScale, DEF_Y / Main._physScale);
			bDef.type = b2Body.b2_dynamicBody;
			bDef.userData = this;
			bDef.userData.width = DEF_WIDTH;
			bDef.userData.height = DEF_HEIGHT;
			bDef.userData.x = DEF_X;
			bDef.userData.y = DEF_Y;
			
			rigidBody = Main.getWorld().CreateBody(bDef);
			rigidBody.CreateFixture2(DEF_SHAPE, DEF_DENSITY);
						
			setFixtureProperties(DEF_DENSITY, DEF_RESTITUTION, DEF_FRICTION);
		}
		
		public function createDisplayBody(assetClass:Class):void 
		{
			asset = assetClass;
			addChild(new asset());
		}
		
		public function setSize(w:Number, h:Number, density:Number = 0.3):void
		{
			var newShape:b2PolygonShape = new b2PolygonShape();
			newShape.SetAsBox(w / Main._physScale / 2, h / Main._physScale / 2);
			var oldFixture:b2Fixture = rigidBody.GetFixtureList();
			
			rigidBody.DestroyFixture(rigidBody.GetFixtureList());
			rigidBody.CreateFixture2(newShape, oldFixture.GetDensity());
			bDef.userData.width = w;
			bDef.userData.height = h;
			
			copyFixtureProperties(oldFixture);
		}
		
		public function changeShape(shape:b2Shape):void
		{
			var oldFixture:b2Fixture = rigidBody.GetFixtureList();
			rigidBody.DestroyFixture(oldFixture);
			
			rigidBody.CreateFixture2(shape, 1);
			copyFixtureProperties(oldFixture);
		}
		
		public function setFixtureProperties(density:Number, restitution:Number, friction:Number, fixture:b2Fixture = null):void
		{			
			fixture = (fixture) ? fixture : FirstFixture;
			
			if (density >= 0) fixture.SetDensity(density);
			if (restitution >= 0) fixture.SetRestitution(restitution);
			if (friction >= 0) fixture.SetFriction(friction);
		}
		
		public function copyFixtureProperties(original:b2Fixture, copy:b2Fixture = null):void
		{
			copy = (copy) ? copy : FirstFixture;
			
			copy.SetDensity(original.GetDensity());
			copy.SetFriction(original.GetFriction());
			copy.SetRestitution(original.GetRestitution());
		}
		
		public function setPosition(xx:Number, yy:Number):void
		{
			rigidBody.SetPosition(new b2Vec2(xx / Main._physScale, yy / Main._physScale));
		}
		
		public function stopCollisionDetection():void
		{
			checkCollision = false;
			isColliding = false;
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		public function startCollisionDetection():void
		{
			checkCollision = true;
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		public function getBody():b2Body
		{
			return rigidBody;
		}
		
		public function destroyRigidBody():void
		{
			Main.getWorld().Step(0, 10, 10);
			Main.getWorld().DestroyBody(rigidBody);
			Main.getWorld().Step(1 / 30, 10, 10);
		}
		
		public function destroyDisplayObject(fadeSpeed:Number = 0.03):void
		{
			fadeSpd = fadeSpeed;
			addEventListener(Event.ENTER_FRAME, fadingAway);
		}
		
		public function destroyMe():void
		{
			destroyRigidBody();
			destroyDisplayObject();
		}
		
		private var fadeSpd:Number = 0.03;
		private function fadingAway(e:Event):void
		{
			alpha -= fadeSpd;
			if (alpha <= 0) {
				removeEventListener(Event.ENTER_FRAME, fadingAway);
				if(parent) parent.removeChild(this);
			}
		}
		
		protected function getCollisionList():Array
		{
			return collidingBodyList;
		}
		
		private function get FirstFixture():b2Fixture 
		{
			return rigidBody.GetFixtureList();
		}
	}

}