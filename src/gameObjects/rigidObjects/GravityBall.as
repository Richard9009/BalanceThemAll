package gameObjects.rigidObjects 
{
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.Contacts.b2Contact;
	import Box2D.Dynamics.Contacts.b2ContactEdge;
	import flash.display.Sprite;
	import flash.events.Event;
	import gameEvents.CollisionEvent;
	import stages.StageConfig;
	/**
	 * ...
	 * @author ...
	 */
	public class GravityBall extends RigidObjectBase 
	{
		private static const MOVE_SPEED:Number = 3;
		public static const HORIZONTAL:uint = 112233;
		public static const VERTICAL:uint = 223344;
		public static const ANGLED:uint = 334455;
		
		private var lastTurningTime:Number = 0;
		private var turningThreshold:Number = 100;
		
		public function GravityBall() 
		{
			super();
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
		
		override public function createRigidBody():void 
		{
			super.createRigidBody();
			rigidBody.SetType(b2Body.b2_kinematicBody);
			setMovement();
			
			addEventListener(Event.ENTER_FRAME, checkContact);
		}
		
		public function setMovement(spd:Number = MOVE_SPEED, direction:uint = HORIZONTAL, angle:Number = 0):void 
		{
			switch(direction) {
				case HORIZONTAL: angle = 0; break;
				case VERTICAL: angle = 90; break;
			}
			
			var radian:Number = angle * Math.PI / 180;
			var movVec:b2Vec2 = new b2Vec2(spd * Math.cos(radian), spd * Math.sin(radian));
			rigidBody.SetLinearVelocity(movVec);
		}
		
		private function turning():void 
		{
			if (!allowTurning()) return;
			var spdVec:b2Vec2 = rigidBody.GetLinearVelocity();
			rigidBody.SetLinearVelocity( new b2Vec2( -spdVec.x, -spdVec.y));
		}
		
		private function allowTurning():Boolean
		{
			var allowTurn:Boolean = (new Date().getTime() - lastTurningTime) > turningThreshold;
			lastTurningTime = new Date().getTime();
			return allowTurn;
		}
		
		protected function checkContact(e:Event):void 
		{
			if (Main.getWorld() == null) return;
			for (var bb:b2Body = Main.getWorld().GetBodyList(); bb; bb = bb.GetNext())
			{
				
				if (bb.GetUserData() is Sprite && bb.GetUserData() != this && 
					bb.GetType() != b2Body.b2_dynamicBody && this.hitTestObject(bb.GetUserData())) {
						turning();
				} 
			}
			
			if (wentOutStage()) turning();
			
		}
		
		private function wentOutStage():Boolean
		{
			if (x - width / 2 <= StageConfig.WALL_THICKNESS || x + width/2 >= StageConfig.STAGE_WIDTH - StageConfig.WALL_THICKNESS) {
				return true;
			}
				
			if ( y - height / 2 <= StageConfig.HEADER_HEIGHT + StageConfig.WALL_THICKNESS ||
					y + height / 2 >= StageConfig.ITEMBOX_Y - StageConfig.WALL_THICKNESS) {
						return true;
			}
						
			return false;
		}
		
		override public function destroyMe():void 
		{
			super.destroyMe();
			removeEventListener(Event.ENTER_FRAME, checkContact);
		}
		
		
		
	}

}