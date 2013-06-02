package stages.Tutorials 
{
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import gameEvents.TutorialEvent;
	import org.flashdevelop.utils.FlashConnect;
	
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class TutorialEventDispatcher extends EventDispatcher 
	{
		private static const SINGLETON_PASSCODE:String = "udhsy8723gddgey83746gdy92su4d";
		private static const instance:TutorialEventDispatcher = new TutorialEventDispatcher(null, SINGLETON_PASSCODE);
		
		private var eventsWeAreWaitingFor:Array = new Array();
		private var listeners:Array = new Array();
		
		public function TutorialEventDispatcher(target:IEventDispatcher=null, pass:String = "secret") 
		{
			super(target);
			if (pass != SINGLETON_PASSCODE) throw new Error("Unable to create this object outside the class");
		}
		
		public static function getInstance():TutorialEventDispatcher
		{
			return instance;
		}
		
		override public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void 
		{
			super.addEventListener(type, listener, useCapture, priority, useWeakReference);
			startWaitingForAnEvent(type);
			
			var lHelper:ListenerHelper = new ListenerHelper();
			lHelper.type = type;
			lHelper.method = listener;
			listeners.push(lHelper);
		}
		
		override public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void 
		{
			super.removeEventListener(type, listener, useCapture);
			forgetThisEvent(type);
		}
		
		override public function dispatchEvent(event:Event):Boolean 
		{
			if (event is TutorialEvent == false) throw new IllegalOperationError("This dispatcher can only dispatch TutorialEvent objects");
			if (!thisIsTheEventWeAreWaitingFor(event.type) || !Tutorial.tutorialOn) return false;
			
			return super.dispatchEvent(event);
		}
		
		public function startWaitingForAnEvent(type:String):void
		{
			eventsWeAreWaitingFor.push(type);
		}
		
		public function forgetThisEvent(type:String):void
		{
			var num:int = 0;
			for each(var evt:String in eventsWeAreWaitingFor) {
				if (evt == type) {
					eventsWeAreWaitingFor.splice(num, 1);
					return;
				}
				num++;
			}
		}
		
		public function forgetAllEvents():void
		{
			eventsWeAreWaitingFor = new Array();
			removeAllListeners();
		}
		
		public function thisIsTheEventWeAreWaitingFor(type:String):Boolean
		{
			for each(var evt:String in eventsWeAreWaitingFor) {
				if (evt == type) return true;
			}
			
			return false;
		}
		
		private function removeAllListeners():void {
			while (listeners.length > 0) {
				removeEventListener(listeners[0].type, listeners[0].method);
				listeners.splice(0, 1);
			}
		}
	}

}

class ListenerHelper {
	public var type:String;
	public var method:Function;
	
	public function thatIsMe(evtType:String, evtMethod:Function):Boolean
	{
		return (type == evtType && method == evtMethod);
	}
}