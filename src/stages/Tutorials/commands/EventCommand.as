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
		
		private static function get actionHandler():ActionHandler
		{
			if (_actionHandler == null) _actionHandler = new ActionHandler(dialog, eventHandler);
			return _actionHandler;
		}
		
		//===========================================================================================================
		
		public static function waitingForEvent(type:String = NO_EVENT_ASSIGNED):EventCommand { 
			var cmd:EventCommand = new EventCommand(ENUM_PASS, "it needs setEvent function from dialogHelper");
			cmd.addAction(function waitingForEvent_action():void {
								eventHandler.addEventListener(type, actionHandler.handleWaiting);
							});
			return cmd;
		}
		
		public static function dispatchAnEvent(event:ICommandEvent = null):EventCommand { 
			var cmd:EventCommand = new EventCommand(ENUM_PASS, "dispatch an event");
			cmd.addAction(function dispatchAnEvent_action():void {
								eventHandler.dispatchEvent(event as Event);
							});
			return cmd;
		}
		public static function promptSuccessFailed(success:String = NO_EVENT_ASSIGNED, failed:String = NO_EVENT_ASSIGNED):EventCommand { 
			var cmd:EventCommand = new EventCommand(ENUM_PASS, "handle branched dialog with success and failed condition");
			cmd.addAction(function promptSuccessFailed_action():void {
								eventHandler.addEventListener(success, actionHandler.handleSuccess);
								eventHandler.addEventListener(failed, actionHandler.handleFailed);
							});
			return cmd;
		}
	}
}
import flash.events.Event;
import stages.Tutorials.Dialog;
import stages.Tutorials.DialogPath;
import stages.Tutorials.TutorialEventDispatcher;
import stages.Tutorials.commands.*;

class ActionHandler 
{	
	private var dialog:Dialog;
	private var eventHandler:TutorialEventDispatcher;
	
	public function ActionHandler(d:Dialog, eHandler:TutorialEventDispatcher) {
		dialog = d;
		eventHandler = eHandler;
	}
	
	public function handleWaiting(e:Event):void
	{
		dialog.nextDialog(DialogPath.TUTORIAL);
		eventHandler.removeEventListener(e.type, handleWaiting);
	}
	
	public function handleSuccess(e:Event):void
	{
		dialog.nextDialog(DialogPath.SUCCESS);
		eventHandler.removeEventListener(e.type, handleSuccess);
	}
	
	public function handleFailed(e:Event):void
	{
		dialog.nextDialog(DialogPath.FAILED);
		eventHandler.removeEventListener(e.type, handleFailed);
	}
}