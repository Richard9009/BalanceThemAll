package gameEvents 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class ObjectBreakEvent extends Event 
	{
		public static const OBJECT_BREAK:String = "OBJECT BREAK";
		public static const GENERATE_PARTICLE:String = "GENERATE PARTICLE";
		
		public var brokenObject:Sprite;
		
		public function ObjectBreakEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			
		}
		
	}

}