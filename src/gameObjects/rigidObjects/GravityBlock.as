package gameObjects.rigidObjects 
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import flash.events.Event;
	import flash.geom.Point;
	import stages.StageConfig;
	/**
	 * ...
	 * @author ...
	 */
	public class GravityBlock extends RigidObjectBase 
	{
		private static const FALL_RATE:Number = 0.25;
		private static const MAXIMUM_FORCE:Number = 20;
		
		private static const DIRECTION_UP:Number = -1;
		private static const DIRECTION_DOWN:Number = 1;
		
		private var originalPos:Point;
		private var force:Number = 0;
		private var afterFallY:Number;
		private var startFallY:Number;
		private var fallingSpd:Number = 2;
		private var goingDown:Boolean;
		private var pair:GravityBlock;
		
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
			
			if (pair) pair.reactToPair(force);
			fallDown();
		}
		
		private function fallDown():void
		{
			var fallDistance:Number = force * FALL_RATE;
			afterFallY = rigidBody.GetPosition().y + fallDistance;
			validateAfterFallPosition();
			startFallY = rigidBody.GetPosition().y;
			goingDown = afterFallY > startFallY;
			
			if (goingDown) rigidBody.SetLinearVelocity(new b2Vec2(0, fallingSpd));
			else rigidBody.SetLinearVelocity(new b2Vec2(0, -fallingSpd));
			
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
		
		private function validateAfterFallPosition():void {
			if (afterFallY * Main._physScale > StageConfig.ITEMBOX_Y - height / 2 - 10) {
				afterFallY = (StageConfig.ITEMBOX_Y - height / 2 - 10) / Main._physScale;
			}
			
			if (afterFallY * Main._physScale < StageConfig.HEADER_HEIGHT + height / 2 + 10 ) {
				afterFallY = (StageConfig.HEADER_HEIGHT + height / 2 + 10) / Main._physScale;
			}
		}
		
		public function setPair(gBlock:GravityBlock):void
		{
			pair = gBlock;
			if (pair.pair == null) pair.setPair(this);
		}

		public function reactToPair(f:Number):void {
			force = -f; 
			rigidBody.SetAwake(true);
			fallDown();
		}
		
	}

}