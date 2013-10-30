package gameEvents 
{
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
		
		public function CollisionEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			
		}
		
	}

}