package gameEvents 
{
	import Box2D.Dynamics.b2Body;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class GrabObjectEvent extends Event 
	{
		public static const GRAB_AN_OBJECT:String = "grab an object";
		public static const DROP_AN_OBJECT:String = "drop an object";
		public static const DROP_ALL_OBJECTS:String = "drop all objects";
		public static const OBJECT_STOPS:String = "object stops";
		public static const OBJECT_RELOCATED:String = "object relocated";
		
		public var object:b2Body;
	
		public function GrabObjectEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			
		}
		
	}

}