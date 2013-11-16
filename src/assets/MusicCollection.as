package assets 
{
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class MusicCollection 
	{
		
		[Embed(source = "musics/Main Menu BGM.mp3")]
		public var mainMenuBGM:Class;
		
		[Embed(source = "musics/Opening BGM.mp3")]
		public var openingBGM:Class;
		
		[Embed(source = "musics/Select Level BGM.mp3")]
		public var selectLevelBGM:Class;
		
		[Embed(source = "musics/Stage1 - First Half.mp3")]
		public var s1FirstHalfBGM:Class;
		
		[Embed(source = "musics/Stage2 - First Half.mp3")]
		public var s2FirstHalfBGM:Class;
		
		[Embed(source="musics/Stage2 - Second Half.mp3")]
		public var s2SecondHalfBGM:Class;
		
		[Embed(source="musics/Stage3 - First Half.mp3")]
		public var s3FirstHalfBGM:Class;
		
		[Embed(source="musics/Stage3 - Second Half.mp3")]
		public var s3SecondHalfBGM:Class;
		
		[Embed(source="musics/Stage4.mp3")]
		public var s4BGM:Class;
		
		public function MusicCollection() 
		{
			
		}
		
	}

}