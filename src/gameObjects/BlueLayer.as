package gameObjects 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import gameEvents.PowerEvent;
	import stages.StageConfig;
	
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class BlueLayer extends Sprite 
	{
		private var duration:Number;
		private var fadeSpd:Number;
		private var minAlpha:Number = 0.5;
		
		private var counter:Number = 0;
		
		public function BlueLayer(miliseconds:Number = 10000) 
		{
			mouseEnabled = false;
			duration = miliseconds;
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
			fadeSpd = (1 - minAlpha) / (duration / StageConfig.FRAME_RATE);
			counter = 0;
			addEventListener(Event.ENTER_FRAME, fading);
		}
		
		private function fading(e:Event):void 
		{
			if(alpha >= minAlpha) alpha -= fadeSpd;
			counter++;
			if (counter >= duration) {
				dispatchEvent(new PowerEvent(PowerEvent.POWER_COMPLETE));
				removeEventListener(Event.ENTER_FRAME, fading);
				parent.removeChild(this);
			}
		}
		
	}

}