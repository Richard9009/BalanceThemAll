package general
{
	import flash.display.Sprite;
	import gameObjects.StarObject;
	import stages.StageConfig;
	
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class ScoreCounter
	{
		private var currentScore:int = 0;
		private var scorePerObject:Number = 20;
		
		private var objectBreakPenalty:int;
		private var objectFallPenalty:int;
		private var bonusPoint:int;
		
		public var scoreRecord:ScoreRecord;
		
		public function ScoreCounter()
		{
			calcAdditionalScore();
			currentScore = ScoreRecord.totalScore;
		}
		
		public function setScoreRecord(rec:ScoreRecord):void
		{
			scoreRecord = rec;
		}
		
		public function setScoreRate(averageScorePerObject:int):void
		{
			scorePerObject = averageScorePerObject;
			calcAdditionalScore();
		}
		
		private function calcAdditionalScore():void
		{
			objectBreakPenalty = scorePerObject * 5;
			objectFallPenalty = scorePerObject * 2;
			bonusPoint = scorePerObject * 5;
		}
		
		public function countScore():String
		{
			addScore(scorePerObject);
			return scorePerObject.toString();
		}
		
		public function getScore():int
		{
			return currentScore;
		}
		
		public function addScore(howManyPoints:Number):void
		{
			currentScore += howManyPoints;
			scoreRecord.scoreInThisStage += howManyPoints;
		}
		
		public function breakPenalty():void
		{
			addScore( -objectBreakPenalty);
		}
		
		public function fallPenalty():void
		{
			addScore( -objectFallPenalty);
		}
		
		public function getStarBonus(star:StarObject):String
		{
			var bonus:int = star.starValue * scorePerObject;
			addScore(bonus);
			
			switch (star.starType)
			{
				case StarObject.GOLDEN: 
					scoreRecord.gotGoldStar = true;
					break;
				case StarObject.SILVER: 
					scoreRecord.gotSilverStar = true;
					break;
				case StarObject.BRONZE: 
					scoreRecord.gotBronzeStar = true;
					break;
			}
			
			return bonus.toString();
		}
		
		public function getBonusPoints():String
		{
			addScore(bonusPoint);
			return bonusPoint.toString();
		}
		
		public function sumUpScore():void {
			scoreRecord.sumUpScore();
		}
		
		public function getBreakPenaltyString():String
		{
			return "-" + objectBreakPenalty.toString();
		}
		
		public function getFallPenaltyString():String
		{
			return "-" + objectFallPenalty.toString();
		}
	
	}

}