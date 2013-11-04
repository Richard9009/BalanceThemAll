package general 
{
	import assets.SoundCollection;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2ContactImpulse;
	import Box2D.Dynamics.b2ContactListener;
	import Box2D.Dynamics.Contacts.b2Contact;
	import gameEvents.CollisionEvent;
	import gameEvents.ObjectBreakEvent;
	import flash.display.Sprite;
	import flash.media.Sound;
	import gameObjects.IAudibleObject;
	import gameObjects.rigidObjects.NormalBoxObject;
	import org.flashdevelop.utils.FlashConnect;
	
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class BreakContactListener extends b2ContactListener 
	{
		private var body:b2Body;
		private var maxDurability:Number = 10;
		private var maxDurableImpulse:Number = 20;
		private var alreadyBroke:Boolean = false;
		
		public function BreakContactListener()
		{
		}
		
		override public function BeginContact(contact:b2Contact):void 
		{
			super.BeginContact(contact);
			
			var objA:Sprite = contact.GetFixtureA().GetBody().GetUserData();
			var objB:Sprite = contact.GetFixtureB().GetBody().GetUserData();
			if(objA && objB) sendCollisionEvent(objA, objB, CollisionEvent.COLLISION_START);
		}
		
		override public function PostSolve(contact:b2Contact, impulse:b2ContactImpulse):void 
		{
			super.PostSolve(contact, impulse);
			var objA:Sprite = contact.GetFixtureA().GetBody().GetUserData();
			var objB:Sprite = contact.GetFixtureB().GetBody().GetUserData();
			
			if(objA is NormalBoxObject) checkBreak(objA as NormalBoxObject, impulse);
			if (objB is NormalBoxObject) checkBreak(objB as NormalBoxObject, impulse);
			
			if (objA is IAudibleObject) generateSound(objA as IAudibleObject, impulse);
			if (objB is IAudibleObject) generateSound(objB as IAudibleObject, impulse);
			
			if(objA && objB) sendCollisionEvent(objA, objB, CollisionEvent.COLLISION_END);
			
			if (contact.IsContinuous() && objA && objB) {
				sendCollisionEvent(objA, objB, CollisionEvent.CONTINUOUS_COLLISION);
			}
		}
		
		private function checkBreak(obj:NormalBoxObject, impulse:b2ContactImpulse):void
		{
			if (obj.isBreakable == false) return;
			
			var impulseLimit:Number = obj.durability / maxDurability * maxDurableImpulse;
			var maxImpulse:Number = getMaxImpulse(impulse);
			
			if (maxImpulse > impulseLimit) {
				var evt:ObjectBreakEvent = new ObjectBreakEvent(ObjectBreakEvent.OBJECT_BREAK);
				obj.dispatchEvent(evt);	
			}
		}
		
		private function generateSound(obj:IAudibleObject, impulse:b2ContactImpulse):void
		{
			var imp:Number = getMaxImpulse(impulse);
			obj.getSound().playImpactSound(imp);
		}
		
		private function getMaxImpulse(impulse:b2ContactImpulse):Number
		{
			var maxImpulse:Number = 0;
	
			for (var a:int = 0; a < impulse.normalImpulses.length; a++)
			{
				if (impulse.normalImpulses[a] > maxImpulse) maxImpulse = impulse.normalImpulses[a];
			}
			
			return maxImpulse;
		}
		
		private function sendCollisionEvent(obj1:Sprite, obj2:Sprite, evtType:String):void {
			var evt:CollisionEvent = new CollisionEvent(evtType, true);
			evt.theOtherObject = obj2;
			obj1.dispatchEvent(evt);
			
			var evt2:CollisionEvent = new CollisionEvent(evtType, true);
			evt2.theOtherObject = obj1;
			obj2.dispatchEvent(evt2);
		}
	}

}