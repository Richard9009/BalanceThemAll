package general 
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class Power extends EventDispatcher 
	{
		
		public function Power() 
		{
		
		}
		
		public function usePower(type:String):void
		{
			switch(type) {
				case PowerType.BALANCE: useBalance(); break;
			}
		}
		
		private function useBalance():void
		{
			
		}
		
	}

}