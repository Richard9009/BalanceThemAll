package managers 
{
	import assets.MusicCollection;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class MusicManager 
	{
		private const MUSIC_COL:MusicCollection = new MusicCollection();
		private const DEFAULT_VOLUME:Number = 0.1;
		
		private var sTrans:SoundTransform;
		private var sChannel:SoundChannel;
		private var music:Sound;
		
		private static var instance:MusicManager;
		
		public function MusicManager(pass:SingletonEnforcer) 
		{
			if (pass == null) throw new IllegalOperationError("This class is a singleton. Use getInstance() function to get its object");
			
			sTrans = new SoundTransform(DEFAULT_VOLUME);
			sChannel = new SoundChannel();
			sChannel.soundTransform = sTrans;
		}
		
		public static function getInstance():MusicManager
		{
			if (instance == null) instance = new MusicManager(new SingletonEnforcer());
			return instance;
		}
		
		public function playMainMenuBGM(volume:Number = DEFAULT_VOLUME):void 
		{
			playMusic(MUSIC_COL.mainMenuBGM, volume);
		}
		
		public function playStage1FirstHalfBGM(volume:Number = DEFAULT_VOLUME):void
		{
			playMusic(MUSIC_COL.s1FirstHalfBGM, volume);
		}
		
		public function playStage1SecondHalfBGM(volume:Number = DEFAULT_VOLUME):void
		{
			playMusic(MUSIC_COL.s1SecondHalfBGM, volume);
		}
		
		public function playStage2FirstHalfBGM(volume:Number = DEFAULT_VOLUME):void
		{
			playMusic(MUSIC_COL.s2FirstHalfBGM, volume);
		}
		
		public function playStage2SecondHalfBGM(volume:Number = DEFAULT_VOLUME):void
		{
			playMusic(MUSIC_COL.s2SecondHalfBGM, volume);
		}
		
		public function playStage3FirstHalfBGM(volume:Number = DEFAULT_VOLUME):void
		{
			playMusic(MUSIC_COL.s3FirstHalfBGM, volume);
		}
		
		public function playStage3SecondHalfBGM(volume:Number = DEFAULT_VOLUME):void
		{
			playMusic(MUSIC_COL.s3SecondHalfBGM, volume);
		}
		
		public function playSelectStageBGM(volume:Number = DEFAULT_VOLUME):void
		{
			playMusic(MUSIC_COL.selectLevelBGM, volume);
		}
		
		public function playStageClearBGM(volume:Number = DEFAULT_VOLUME):void
		{
			playMusic(MUSIC_COL.stageClearBGM, volume);
		}
		
		public function playOpeningBGM(volume:Number = DEFAULT_VOLUME):void
		{
			playMusic(MUSIC_COL.openingBGM, volume);
		}
		
		private function playMusic(musicClass:Class, volume:Number):void 
		{
			music = new musicClass();
			sTrans.volume = volume;
			sChannel = music.play();
			sChannel.soundTransform = sTrans;
			sChannel.addEventListener(Event.SOUND_COMPLETE, musicEnd);
		}
		
		private function musicEnd(e:Event):void
		{
			sChannel = music.play();
			sChannel.soundTransform = sTrans;
		}
		
		public function stopAllMusic():void 
		{
			sChannel.stop();
		}
		
	}

}

class SingletonEnforcer { }