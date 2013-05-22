package general 
{
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class ScoreRecord 
	{
		public static var totalScore:Number = 0;
		
		public var scoreBeforeStage:Number = 0;
		public var penalty:Number = 0;
		public var starBonus:Number = 0;
		public var scoreInThisStage:Number = 0;
		
		public var gotGoldStar:Boolean = false;
		public var gotSilverStar:Boolean = false;
		public var gotBronzeStar:Boolean = false;
		
		public function ScoreRecord()
		{
			scoreBeforeStage = totalScore;
		}
		
		public function sumUpScore():void
		{
			totalScore = scoreBeforeStage + scoreInThisStage + starBonus - penalty;
		}
	}

}