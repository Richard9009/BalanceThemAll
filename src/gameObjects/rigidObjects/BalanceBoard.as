package gameObjects.rigidObjects 
{
	import gameEvents.GameEvent;
	import flash.events.Event;
	import org.flashdevelop.utils.FlashConnect;
	import stages.StageBaseClass;
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class BalanceBoard extends RigidObjectBase 
	{
		private var breakable:Boolean;
		private var maxTorque:Number;
		private var highFromGround:Number;
		private var maxRotation:Number;
		
		public function BalanceBoard() 
		{
			super();
			addEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		private function enterFrame(e:Event):void 
		{
			if (isTouchingGround()) {
				removeEventListener(e.type, enterFrame);
				parent.dispatchEvent(new GameEvent(GameEvent.GAME_OVER));
			}
		}
		
		override public function setPosition(xx:Number, yy:Number):void 
		{
			super.setPosition(xx, yy); 
			highFromGround = StageBaseClass.STAGE_HEIGHT - StageBaseClass.ITEMBOX_HEIGHT - yy - height;
			maxRotation = Math.floor(Math.asin(highFromGround / (width / 2)) * 180 / Math.PI);
		}
		
		private function isTouchingGround():Boolean
		{
			return (Math.abs(Math.floor(rotation)) >=  maxRotation);
		}
		

		
	}

}