package gameEvents 
{
	import Box2D.Dynamics.b2Body;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author ...
	 */
	public class CollisionEvent extends Event 
	{
		public static const COLLISION_START:String = "collision start";
		public static const COLLISION_END:String = "collision end";
		public static const CONTINUOUS_COLLISION:String = "continuous collision";
		
		public var theOtherObject:Sprite;
		
		public function CollisionEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			
		}
		
		override public function clone():Event 
		{
			var newEvt:CollisionEvent = new CollisionEvent(type, bubbles, cancelable);
			newEvt.theOtherObject = theOtherObject;
			return newEvt;
		}
		
	}

}