package gameObjects 
{
	import assets.AssetCollection;
	import assets.SoundCollection;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundTransform;
	
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
		public var starValue:int = 0;
		
		public function StarObject(type:String) 
		{
			var soundCol:SoundCollection = new SoundCollection();
			sound = new soundCol.getStarSound();
			
			starType = type
			createAsset();
			
			switch (type) {
				case GOLDEN: points = 1000; color = 0xD9D919; starValue = 3; break;
				case SILVER: points = 500; color = 0x909090; starValue = 2; break;
				case BRONZE: points = 200; color = 0xCD7F32; starValue = 1;  break;
			}
			
			mouseChildren = false;
			mouseEnabled = false;
		}
		
		public function createAsset():void
		{
			var assetClass:Class;
			var assetsCol:AssetCollection = new AssetCollection();
			
			switch(starType) {
				case GOLDEN: assetClass = assetsCol.goldenStarAsset; break;
				case SILVER: assetClass = assetsCol.silverStarAsset; break;
				case BRONZE: assetClass = assetsCol.bronzeStarAsset; break;
			}
			
			addChild(new assetClass());
		}
		
		public function playSound():void
		{
			var sTrans:SoundTransform = new SoundTransform(0.3);
			sound.play().soundTransform = sTrans;
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