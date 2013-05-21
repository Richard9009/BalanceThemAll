package gameObjects 
{
	import assets.SoundCollection;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.media.Sound;
	
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class StarObject extends Sprite 
	{
		public static const GOLDEN:String = "GOLDEN";
		public static const SILVER:String = "SILVER";
		public static const BRONZE:String = "BRONZE";
		
		private var sound:Sound;
		private var points:Number;
		private var color:uint;
		
		private var fadeSpd:Number = 0.03;
		private var growSpd:Number = 2;
		
		public var starType:String;
		
		public function StarObject(starAsset:Class, type:String) 
		{
			var soundCol:SoundCollection = new SoundCollection();
			sound = new soundCol.getStarSound();
			
			addChild(new starAsset());
			
			starType = type
			switch (type) {
				case GOLDEN: points = 1000; color = 0xD9D919; break;
				case SILVER: points = 500; color = 0x909090; break;
				case BRONZE: points = 200; color = 0xCD7F32; break;
			}

		}
		
		public function playSound():void
		{
			sound.play();
		}
		
		public function getPoints():Number
		{
			return points;
		}
		
		public function getColor():uint
		{
			return color;
		}
		
		public function getStarType():String
		{
			return starType;
		}
		
		public function startFadeOut():void
		{
			if (parent == null) return;
			playSound();
			parent.setChildIndex(this, parent.numChildren - 1);
			addEventListener(Event.ENTER_FRAME, fadingOut);
		}
		
		private function fadingOut(e:Event):void 
		{
			this.width += growSpd;
			this.height += growSpd;
			this.alpha -= fadeSpd;
			
			if (this.alpha <= 0) {
				removeEventListener(Event.ENTER_FRAME, fadingOut);
				parent.removeChild(this);
			}
		}
		
	}

}