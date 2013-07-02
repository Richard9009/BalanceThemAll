package gameObjects 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import gameEvents.PowerEvent;
	import general.Power;
	import stages.StageConfig;
	
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class BlueLayer extends Sprite 
	{
		private var power:Power;
		private var fadeSpd:Number;
		private var minAlpha:Number = 0.5;
		
		public function BlueLayer(pow:Power) 
		{
			mouseEnabled = false;
			power = pow;
			drawDisplay();
			startFading();
			
			addEventListener(Event.REMOVED_FROM_STAGE, onRemove);
		}
		
		private function onRemove(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemove);
			
			removeEventListener(Event.ENTER_FRAME, fading);
		}
		
		private function drawDisplay():void
		{
			graphics.beginFill(0x4444AA, 0.3);
			graphics.lineStyle(1, 0x000000, 1);
			graphics.moveTo(0, 0);
			graphics.lineTo(StageConfig.STAGE_WIDTH, 0);
			graphics.lineTo(StageConfig.STAGE_WIDTH, StageConfig.STAGE_HEIGHT);
			graphics.lineTo(0, StageConfig.STAGE_HEIGHT);
			graphics.lineTo(0, 0);
			
			graphics.endFill();
		}
		
		private function startFading():void
		{
			fadeSpd = (1 - minAlpha) / (power.duration / StageConfig.FRAME_RATE);
			power.start();
			addEventListener(Event.ENTER_FRAME, fading);
		}
		
		private function fading(e:Event):void 
		{
			if(alpha >= minAlpha) alpha -= fadeSpd;
			if (!power.isRunning) {
				dispatchEvent(new PowerEvent(PowerEvent.POWER_COMPLETE));
				removeEventListener(Event.ENTER_FRAME, fading);
				parent.removeChild(this);
			}
		}
		
	}

}