package gameObjects.rigidObjects 
{
	import assets.AssetCollection;
	import assets.SoundCollection;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2ContactImpulse;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.Contacts.b2Contact;
	import gameEvents.ObjectBreakEvent;
	import flash.events.Event;
	import flash.media.Sound;
	import gameObjects.IAudibleObject;
	import general.PhysicSound;
	import stages.StageBaseClass;

	import flash.events.MouseEvent;
	import org.flashdevelop.utils.FlashConnect;
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class NormalBoxObject extends DraggableObject implements IAudibleObject
	{
		
		private var collection:AssetCollection = new AssetCollection();
		private var soundCol:SoundCollection = new SoundCollection();
		public var durability:Number = 1;
		public var isBreakable:Boolean = false;
		private var willBreak:Boolean = false;
		private var impactSound:PhysicSound = new PhysicSound();
		
		public function NormalBoxObject(minimumLimit:b2Vec2 = null, maximumLimit:b2Vec2 = null, breakable:Boolean = false) 
		{
			super(minimumLimit, maximumLimit);
			willBreak = breakable; 
			
			addEventListener(ObjectBreakEvent.OBJECT_BREAK, objectBreak);
		}
		
		private function objectBreak(e:ObjectBreakEvent):void 
		{
			impactSound.playBreakingSound();
			
			Main.getWorld().Step(0, 0, 0);
			Main.getWorld().DestroyBody(rigidBody);
			Main.getWorld().Step(1 / 30, 10, 10);
		
			var evt:ObjectBreakEvent = new ObjectBreakEvent(ObjectBreakEvent.GENERATE_PARTICLE);
			evt.brokenObject = this;
			parent.dispatchEvent(evt);
			removeEventListener(ObjectBreakEvent.OBJECT_BREAK, objectBreak);
		}
		
		override protected function checkActivity(e:Event):void 
		{
			super.checkActivity(e);
			if (rigidBody.GetLinearVelocity().Length() == 0) isBreakable = willBreak;
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
		
		override public function destroyMe():void 
		{
			super.destroyMe();
			
			removeEventListener(ObjectBreakEvent.OBJECT_BREAK, objectBreak);
		}
	}
}