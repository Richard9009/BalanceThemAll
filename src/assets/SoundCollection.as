package assets 
{
	import flash.media.Sound;
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class SoundCollection 
	{
		[Embed(source="sounds/GlassBreaking_Sound.mp3")]
		public var glassBreakingSound:Class;
		
		[Embed(source = "sounds/ButtonClick_Sound.mp3")]
		public var buttonClickSound:Class;
		
		[Embed(source = "sounds/HeavyImpact_Sound.mp3")]
		public var heavyImpactSound:Class;
		
		[Embed(source = "sounds/LightGlassBreaking_Sound.mp3")]
		public var lightGlassBreakingSound:Class;
		
		[Embed(source="sounds/MediumImpact_Sound.mp3")]
		public var mediumImpactSound:Class;
		
		[Embed(source = "sounds/BallImpact_Sound.mp3")]
		public var ballImpactSound:Class;
		
		[Embed(source = "sounds/BookImpact_Sound.mp3")]
		public var bookImpactSound:Class;
		
		[Embed(source = "sounds/GlassImpact_Sound.mp3")]
		public var glassImpactSound:Class;
		
		[Embed(source = "sounds/PillowImpact_Sound.mp3")]
		public var pillowImpactSound:Class;
		
		[Embed(source="sounds/WoodImpact_Sound.mp3")]
		public var woodImpactSound:Class;
		
		[Embed(source="sounds/BallRolling_Sound.mp3")]
		public var ballRollingSound:Class;
		
		[Embed(source = "sounds/GetStar_Sound.mp3")]
		public var getStarSound:Class;
		
		[Embed(source = "sounds/DropButton-Success_Sound.mp3")]
		public var dropSuccessSound:Class;
		
		[Embed(source = "sounds/DropButton-Fail_Sound.mp3")]
		public var dropFailSound:Class;
		
		public function SoundCollection() 
		{
			
		}
		
	}

}