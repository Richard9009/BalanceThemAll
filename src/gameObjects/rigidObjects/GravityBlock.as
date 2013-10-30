package gameObjects.rigidObjects 
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import flash.events.Event;
	import flash.geom.Point;
	/**
	 * ...
	 * @author ...
	 */
	public class GravityBlock extends RigidObjectBase 
	{
		private static const FALL_RATE:Number = 0.1;
		private static const MAXIMUM_FORCE:Number = 20;
		private var originalPos:Point;
		private var force:Number = 0;
		private var afterFallY:Number;
		private var startFallY:Number;
		private var fallingSpd:Number = 2;
		private var goingDown:Boolean;
		
		public function GravityBlock() 
		{
			super();
			isBalanceBoard = true; 
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}
		
		private function addedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			originalPos = new Point(rigidBody.GetPosition().x, rigidBody.GetPosition().y);
			addEventListener(Event.ENTER_FRAME, checkPosition);
		}
		
		override public function createRigidBody():void 
		{
			super.createRigidBody();
			rigidBody.SetType(b2Body.b2_kinematicBody);
			
		}
		
		override public function addMassOnMe(addedMass:Number):void 
		{
			super.addMassOnMe(addedMass);
			force += addedMass * Main._gravity.y;
			
			//this if statement is added to fix stack overflow problem, I need a better solution for this!
			if (Math.abs(force) > MAXIMUM_FORCE) force = MAXIMUM_FORCE * force / Math.abs(force);
			
			fallDown();
		}
		
		private function fallDown():void
		{
			rigidBody.SetType(b2Body.b2_kinematicBody);
			var fallDistance:Number = force * FALL_RATE;
			afterFallY = rigidBody.GetPosition().y + fallDistance;
			startFallY = rigidBody.GetPosition().y;
			goingDown = afterFallY > startFallY;
			
			if (goingDown) rigidBody.SetLinearVelocity(new b2Vec2(0, fallingSpd));
			else rigidBody.SetLinearVelocity(new b2Vec2(0, -fallingSpd));
			
			trace("FORCE: " + force);
			trace("startFall: " + startFallY);
			trace("afterFall: " + afterFallY);
			
			addEventListener(Event.ENTER_FRAME, checkPosition);
		}
		
		private function checkPosition(e:Event):void
		{
			if(goingDown) {			
				if (rigidBody.GetPosition().y >= afterFallY) {
					stopFalling();
				}
			}
			else {		
				if (rigidBody.GetPosition().y <= afterFallY) {
					stopFalling();
				}
			}
		}
		
		private function stopFalling():void 
		{
			force = 0;
			rigidBody.GetPosition().y = afterFallY;
			rigidBody.SetLinearVelocity(new b2Vec2());
			removeEventListener(Event.ENTER_FRAME, checkPosition);
		}
		
	}

}