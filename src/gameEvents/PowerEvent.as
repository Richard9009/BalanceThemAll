package gameEvents 
{
	import flash.events.Event;
	import general.Power;
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class PowerEvent extends Event
	{
		public static const USE_SPECIAL_POWER:String = "use special power";
		public static const POWER_COMPLETE:String = "power complete";
		
		private var _power:Power;
		
		public function PowerEvent(type:String, __power:Power = null) 
		{
			_power = __power;
			super(type, true, false);
		}
		
		public function get power():Power { return _power; }
		
	}

}