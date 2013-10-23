package general 
{
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class ScoreRecord 
	{
		public static var totalScore:Number = 0;
	
		public var scoreInThisStage:Number = 0;
		
		public var gotGoldStar:Boolean = false;
		public var gotSilverStar:Boolean = false;
		public var gotBronzeStar:Boolean = false;
		
		public function ScoreRecord()
		{
			
		}
		
		public function resetScore():void
		{
			//totalScore -= scoreInThisStage;

			scoreInThisStage = 0;
			gotGoldStar = false;
			gotSilverStar = false;
			gotBronzeStar = false;
		}
		
		public function sumUpScore():void
		{
			totalScore += scoreInThisStage;
		}
	}

}