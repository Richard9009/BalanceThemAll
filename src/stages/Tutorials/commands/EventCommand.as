package stages.Tutorials.commands 
{
	import stages.Tutorials.TutorialEventDispatcher;
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class EventCommand extends DialogCommand 
	{
		private static var eventHandler:TutorialEventDispatcher = TutorialEventDispatcher.getInstance();
		private static const NO_EVENT_ASSIGNED:String = "NO EVENT ASSIGNED";
		private static var _actionHandler:ActionHandler;
		
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
	}
	
	public function handleFailed(e:Event):void
	{
		eventHandler.dispatchEvent(new EventCommandEvent(EventCommandEvent.FAILED));
	}
}