package gameEvents 
{
	import flash.events.Event;
	import general.PowerType;
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class PowerEvent extends Event
	{
		public static const USE_SPECIAL_POWER:String = "use special power";
		public static const POWER_COMPLETE:String = "power complete";
		
		private var _powerType:String;
		
		public function PowerEvent(type:String, power:String = "ALL TYPE") 
		{
			_powerType = power;
			super(type, true, false);
		}
		
		public function get powerType():String { return _powerType; }
		
	}

}