package general.dialogs.commands 
{
	import flash.events.Event;
	import general.dialogs.Dialog;
	import general.dialogs.DialogEvent;
	import general.dialogs.DialogEventHandler;
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class EventCommand extends DialogCommand 
	{
		private static var eventHandler:DialogEventHandler = DialogEventHandler.getInstance();
		private static var actionHandler:ActionHandler;
		
		private static const NO_EVENT_ASSIGNED:String = "NO EVENT ASSIGNED";
		
		public function EventCommand(pass:String, cmdType:String) 
		{
			super(pass, cmdType);
		}
		
		public static function setDialog(_dialog:Dialog):void { 
			dialog = _dialog; 
			actionHandler = new ActionHandler(dialog, eventHandler);
		}
	
		//===========================================================================================================
		
		public static function waitingForEvent(type:String = NO_EVENT_ASSIGNED):EventCommand { 
			var cmd:EventCommand = new EventCommand(ENUM_PASS, "it needs setEvent function from dialogHelper");
			cmd.addAction(function waitingForEvent_action():void {
								dialog.lockSkipDialog();
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
								dialog.lockSkipDialog();
								eventHandler.addEventListener(success, actionHandler.handleSuccess);
								eventHandler.addEventListener(failed, actionHandler.handleFailed);
							});
			return cmd;
		}
		
		public static function get stop():EventCommand { 
			var cmd:EventCommand =  dispatchAnEvent(new DialogEvent(DialogEvent.CLOSE_DIALOG));
			cmd.addAction( function stop_action():void {
								dialog.destroyMe();
								eventHandler.forgetAllEvents();
							});
			return cmd;
		}
	}
}
import flash.events.Event;
import general.dialogs.Dialog;
import general.dialogs.DialogPath;
import general.dialogs.DialogEventHandler;
import general.dialogs.commands.*;

class ActionHandler 
{	
	private var dialog:Dialog;
	private var eventHandler:DialogEventHandler;
	
	public function ActionHandler(d:Dialog, eHandler:DialogEventHandler) {
		dialog = d;
		eventHandler = eHandler;
	}
	
	public function handleWaiting(e:Event):void
	{
		dialog.nextDialog(DialogPath.DEFAULT);
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