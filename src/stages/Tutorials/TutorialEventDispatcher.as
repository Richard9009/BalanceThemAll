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
		
		private var eventWeAreWaitingFor:String;
		
		public function TutorialEventDispatcher(target:IEventDispatcher=null, pass:String = "secret") 
		{
			super(target);
			if (pass != SINGLETON_PASSCODE) throw new Error("Unable to create this object outside the class");
		}
		
		public static function getInstance():TutorialEventDispatcher
		{
			return instance;
		}
		
		override public function dispatchEvent(event:Event):Boolean 
		{
			if (thisIsTheEventWeAreWaitingFor(event.type) == false) return false;
			
			return super.dispatchEvent(event);
		}
		
		public function startWaitingForAnEvent(type:String):void
		{
			eventWeAreWaitingFor = type;
		}
		
		public function forgetThisEvent():void
		{
			eventWeAreWaitingFor = "";
		}
		
		public function thisIsTheEventWeAreWaitingFor(type:String):Boolean
		{
			return type == eventWeAreWaitingFor;
		}
	}

}