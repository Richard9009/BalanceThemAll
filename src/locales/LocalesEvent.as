package locales 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	internal class LocalesEvent extends Event 
	{
		public static const ON_LOCALE_CHANGE:String = "ON LOCALE CHANGE";
		public static const ON_LANGUAGE_SELECT:String = "ON LANGUAGE SELECT";
		
		public function LocalesEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			
		}
		
	}

}