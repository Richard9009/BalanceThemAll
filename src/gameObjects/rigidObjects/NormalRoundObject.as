package gameObjects.rigidObjects 
{
	import assets.AssetCollection;
	import assets.SoundCollection;
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Common.Math.b2Transform;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2Fixture;
	import flash.events.Event;
	import flash.media.Sound;
	import gameObjects.IAudibleObject;
	import general.collisions.CollisionGenerator;
	import general.collisions.ICollisionObject;
	import general.PhysicSound;
	
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class NormalRoundObject extends DraggableObject implements IAudibleObject
	{
		private static const DEF_RADIUS:Number = 40;
		
		private var collection:AssetCollection = new AssetCollection();
		private var impactSound:PhysicSound = new PhysicSound();
		
		public function NormalRoundObject(minimumLimit:b2Vec2=null, maximumLimit:b2Vec2=null) 
		{
			super(minimumLimit, maximumLimit);
			
			rigidBody.SetLinearDamping(1);
		}
		
		/* INTERFACE general.collisions.ICollisionObject */
		
		override public function getType():String 
		{
			return CollisionGenerator.CIRCLE
		}
		
		override public function createRigidBody():void 
		{
			var cShape:b2CircleShape = new b2CircleShape(DEF_RADIUS / Main._physScale / 2);
			
			bDef.position.Set(DEF_X / Main._physScale, DEF_Y / Main._physScale);
			bDef.type = b2Body.b2_dynamicBody; 
			bDef.userData = this;
			bDef.userData.width = DEF_RADIUS;
			bDef.userData.height = DEF_RADIUS;
			bDef.userData.x = DEF_X;
			bDef.userData.y = DEF_Y;
			
			rigidBody = Main.getWorld().CreateBody(bDef);
			rigidBody.CreateFixture2(cShape, DEF_DENSITY);
			setFixtureProperties(DEF_DENSITY, DEF_RESTITUTION, DEF_FRICTION);
		}
		
		public function setRoundSize(radius:Number, density:Number = 0.3):void 
		{
			var newShape:b2CircleShape = new b2CircleShape(radius / Main._physScale);
			var oldFixture:b2Fixture= rigidBody.GetFixtureList();
			
			rigidBody.DestroyFixture(rigidBody.GetFixtureList());
			rigidBody.CreateFixture2(newShape, density);
			bDef.userData.width = radius * 2;
			bDef.userData.height = radius * 2;
			
			this.setFixtureProperties(oldFixture.GetDensity(), oldFixture.GetRestitution(), oldFixture.GetFriction());
		}
		
		public function getSound():PhysicSound
		{
			return impactSound;
		}
		
		public function setSound(impactSnd:Sound, breakSnd:Sound = null, rollSnd:Sound = null):void
		{
			impactSound.setSound(impactSnd);
			impactSound.setBreakingSound(breakSnd);
			impactSound.setRollingSound(rollSnd);
			impactSound.setBody(rigidBody);
		}
		
		override protected function checkActivity(e:Event):void 
		{
			super.checkActivity(e);
			
			if (rigidBody.GetLinearVelocity().Length() < 0.1) {
				rigidBody.SetLinearVelocity(new b2Vec2());
			}
		}
		
	}

}