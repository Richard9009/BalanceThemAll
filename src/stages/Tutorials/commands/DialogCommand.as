package stages.Tutorials.commands 
{
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */

	import flash.events.MouseEvent;
	import stages.Tutorials.*;
	
	public class DialogCommand extends BaseCommandClass {
		
		private static var eventHandler:TutorialEventDispatcher = TutorialEventDispatcher.getInstance();
		private static var actionHandler:ActionHandler;
		protected static var dialog:Dialog;
		
		public var dialogIndex:int;
		
		public function DialogCommand(pass:String, cmdType:String)
		{
			super(pass, cmdType);
		}
		
		public function addAction(action:Function):void { actionList.push(action); }
		
		public static function setDialog(_dialog:Dialog):void { 
			dialog = _dialog; 
			actionHandler = new ActionHandler(dialog);
			
			dialog.yesButton.addEventListener(MouseEvent.CLICK, actionHandler.handleYes);
			dialog.noButton.addEventListener(MouseEvent.CLICK, actionHandler.handleNo); 
		}
		
		public static function get stop():DialogCommand { return new DialogCommand(ENUM_PASS, "stop"); }
		
		public static function jumpToDialog(index:int = 0):DialogCommand {
			var cmd:DialogCommand = new DialogCommand(ENUM_PASS, "jump to a specific dialog");
			cmd.dialogIndex = index;
			return cmd;
		}
		
		public static function get promptYesNo():DialogCommand { 
			var cmd:DialogCommand =  new DialogCommand(ENUM_PASS, "ask yes no question");
			cmd.addAction( function promptYesNo_action():void {
								dialog.yesButton.visible = true;
								dialog.noButton.visible = true;
								dialog.lockSkipDialog();
							});
			return cmd;
		}
		
		public static function get allowSkip():DialogCommand { return new DialogCommand(ENUM_PASS, "allow skip"); }
	}

}

import flash.events.MouseEvent;
import stages.Tutorials.*;

class ActionHandler {
	private var dialog:Dialog;
	
	public function ActionHandler(d:Dialog) {
		dialog = d;
	}
	
	public function handleYes(e:MouseEvent):void {
		dialog.nextDialog(DialogPath.TUTORIAL);
	}
	
	public function handleNo(e:MouseEvent):void {
		dialog.nextDialog(DialogPath.SKIP_TUTORIAL);
	}
	
	public function handleJump():void {
		
	}
}