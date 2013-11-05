package managers 
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import locales.LocalesTextField;
	/**
	 * ...
	 * @author Herichard
	 */
	public class MessageManager 
	{
		private static const DEFAULT_AUTO_HIDE_TIMER:Number = 2000;
		private var mBox:LocalesTextField;
		private var hideTimer:Timer = new Timer(DEFAULT_AUTO_HIDE_TIMER);
		private static var instance:MessageManager;
		
		public function MessageManager(pass:SingletonEnforcer) 
		{
			if (pass == null) throw new Error("instantiation failed");
		}
		
		public function setMsgBox(msgBox:LocalesTextField):void
		{
			mBox = msgBox;
			mBox.visible = false;
		}
		
		public function displayMessage(code:String, autoHide:Boolean = true, time:Number = DEFAULT_AUTO_HIDE_TIMER):void
		{
			mBox.visible = true;
			mBox.setLocaleText(code);
			
			if (!autoHide) return;
			
			if (hideTimer.running) {
				hideTimer.delay = time;
				hideTimer.reset();
			} else {
				hideTimer = new Timer(time, 1);
				hideTimer.addEventListener(TimerEvent.TIMER, function hide(e:TimerEvent):void {
					hideMessage();
					hideTimer.stop();
					hideTimer.removeEventListener(TimerEvent.TIMER, hide);
				});
				hideTimer.start();
			}
		}
		
		public function hideMessage():void
		{
			mBox.visible = false;
		}
		
		
		public static function getInstance():MessageManager
		{
			if (!instance) instance = new MessageManager(new SingletonEnforcer());
			return instance;
		}
		
	}

}

class SingletonEnforcer { }