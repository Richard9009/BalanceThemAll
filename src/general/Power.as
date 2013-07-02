package general 
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class Power extends EventDispatcher 
	{
		public static var ALL_TYPE:String = "ALL TYPE";
		public static var BALANCE:String = "BALANCE";
		
		protected static const PASS_CODE:String = "AUHUYG823724bUAAYGS";
		
		private var _type:String;
		private var _duration:Number;
		private var _isRunning:Boolean = false;
		
		private var timer:Timer;
		
		private static var balance:Power;
		
		public function Power(pass:String, __type:String, __duration:Number) 
		{
			if (pass != PASS_CODE) throw new Error("Can't externally instantiate this class");
			_type = __type;
			_duration = __duration;
		}
		
		public function start():void
		{
			_isRunning = true;
			
			timer = new Timer(_duration);
			timer.start();
			timer.addEventListener(TimerEvent.TIMER, function timerFunction(e:TimerEvent):void {
				timer.stop();
				timer.removeEventListener(TimerEvent.TIMER, timerFunction);
				
				_isRunning = false;
			});
		}
		
		public function get type():String { return _type; }
		public function get duration():Number { return _duration; }
		public function get isRunning():Boolean { return _isRunning; }
		
		public static function getPower_balance():Power {
			if (balance == null) balance = new Power(PASS_CODE, BALANCE, 30000);
			return balance;
		}
		
	}

}