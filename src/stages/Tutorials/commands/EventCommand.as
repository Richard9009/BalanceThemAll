package stages.Tutorials.commands 
{
	import flash.events.Event;
	import gameEvents.TutorialEvent;
	import stages.Tutorials.TutorialEventDispatcher;
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class EventCommand extends DialogCommand 
	{
		private static var eventHandler:TutorialEventDispatcher = TutorialEventDispatcher.getInstance();
		private static var _actionHandler:ActionHandler;
		
		private static const NO_EVENT_ASSIGNED:String = "NO EVENT ASSIGNED";
		
		public function EventCommand(pass:String, cmdType:String) 
		{
			super(pass, cmdType);
		}
		
		public function addAction(action:Function):EventCommand
		{
			actionList.push(action);
			return this;
		}
		
		private static function get actionHandler():ActionHandler
		{
			if (_actionHandler == null) _actionHandler = new ActionHandler(eventHandler);
			return _actionHandler;
		}
		
		//===========================================================================================================
		
		public static function waitingForEvent(type:String = NO_EVENT_ASSIGNED):EventCommand { 
			return new EventCommand(ENUM_PASS, "it needs setEvent function from dialogHelper")
					.addAction(function waitingForEvent_action():void {
						eventHandler.addEventListener(type, actionHandler.handleWaiting);
					});
		}
		
		public static function dispatchAnEvent(event:ICommandEvent = null):EventCommand { 
			return new EventCommand(ENUM_PASS, "dispatch an event")
					.addAction(function dispatchAnEvent_action():void {
						eventHandler.dispatchEvent(event as Event);
					});
		}
		public static function promptSuccessFailed(success:String = NO_EVENT_ASSIGNED, failed:String = NO_EVENT_ASSIGNED):EventCommand { 
			return new EventCommand(ENUM_PASS, "handle branched dialog with success and failed condition")
					.addAction(function promptSuccessFailed_action():void {
						eventHandler.addEventListener(success, actionHandler.handleSuccess);
						eventHandler.addEventListener(failed, actionHandler.handleFailed);
					});
		}
	}
}
import flash.events.Event;
import stages.Tutorials.TutorialEventDispatcher;
import stages.Tutorials.commands.*;

class ActionHandler 
{	
	private var eventHandler:TutorialEventDispatcher;
	
	public function ActionHandler(evtHandler:TutorialEventDispatcher) {
		eventHandler = evtHandler;
	}
	
	public function handleWaiting(e:Event):void
	{
		eventHandler.dispatchEvent(new EventCommandEvent(EventCommandEvent.WAITING_COMPLETE));
		eventHandler.removeEventListener(e.type, handleWaiting);
	}
	
	public function handleSuccess(e:Event):void
	{
		eventHandler.dispatchEvent(new EventCommandEvent(EventCommandEvent.SUCCESS));
		eventHandler.removeEventListener(e.type, handleSuccess);
	}
	
	public function handleFailed(e:Event):void
	{
		eventHandler.dispatchEvent(new EventCommandEvent(EventCommandEvent.FAILED));
		eventHandler.removeEventListener(e.type, handleFailed);
	}
}