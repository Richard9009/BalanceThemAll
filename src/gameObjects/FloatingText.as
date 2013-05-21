package gameObjects 
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class FloatingText extends TextField 
	{
		private var speed:Number = 1;
		private var duration:Number = 2;
		private var fadeSpeed:Number;
		private var tFormat:TextFormat;
		
		public function FloatingText(message:String, floatSpeed:Number = 2, seconds:Number = 2, color:uint = 0xAACC44 ) 
		{
			super();
			
			speed = floatSpeed;
			duration = seconds;
			tFormat = new TextFormat("Arial", 18, color, false);
			this.text = message;
			this.setTextFormat(tFormat);
			fadeSpeed = 1 / (30 * seconds);
			
			selectable  = false;
			addEventListener(Event.ENTER_FRAME, enterFrame);
			
			var timer:Timer = new Timer(seconds * 1000);
			timer.addEventListener(TimerEvent.TIMER, timeUp);
			timer.start();
		}
		
		private function timeUp(e:TimerEvent):void 
		{
			e.target.stop();
			removeEventListener(Event.ENTER_FRAME, enterFrame);
			parent.removeChild(this);
			//this = null;
		}
		
		private function enterFrame(e:Event):void 
		{
			this.y -= speed;
			this.alpha -= fadeSpeed;
		}
		
	}

}