package managers 
{
	import assets.SoundCollection;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	/**
	 * ...
	 * @author Herichard
	 */
	public class SoundManager 
	{
		private static const DEFAULT_VOLUME:Number = 1;
		
		private var collection:SoundCollection = new SoundCollection();
		private var sChannel:SoundChannel;
		
		private static var instance:SoundManager;
		
		public function SoundManager(pass:SingletonEnforcer) 
		{
			if (pass == null) throw new Error("instantiation failed");
		}
		
		public function playDropSuccess(vol:Number = DEFAULT_VOLUME):void
		{
			playSound(collection.dropSuccessSound, vol);
		}
		
		public function playDropFail(vol:Number = DEFAULT_VOLUME):void
		{
			playSound(collection.dropFailSound, vol);
		}
		
		public function playGravBoxMoving(vol:Number = DEFAULT_VOLUME):void
		{
			playSound(collection.gravBlockSound, vol);
		}
		
		public function stopSound():void
		{
			sChannel.stop();
		}
		
		private function playSound(sound:Class, vol:Number):void
		{
			var sfx:Sound = new sound();
			var sTransform:SoundTransform = new SoundTransform(vol, 0);
			sChannel = sfx.play();
			sChannel.soundTransform = sTransform;
		}
		
		public static function getInstance():SoundManager
		{
			if (!instance) instance = new SoundManager(new SingletonEnforcer());
			return instance;
		}
		
	}

}

class SingletonEnforcer { }