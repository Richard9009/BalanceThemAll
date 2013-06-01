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
		
		public function resetScore():void
		{
			totalScore -= totalScoreOfThisStage;
			scoreBeforeStage = totalScore;
			
			penalty = 0;
			starBonus = 0;
			scoreInThisStage = 0;
			gotGoldStar = false;
			gotSilverStar = false;
			gotBronzeStar = false;
		}
		
		public function sumUpScore():void
		{
			totalScore = scoreBeforeStage + totalScoreOfThisStage;
		}
		
		public function get totalScoreOfThisStage():Number
		{
			return scoreInThisStage + starBonus - penalty;
		}
	}

}