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
			objectBreakPenalty = scorePerObject * 10;
			objectFallPenalty = scorePerObject * 3;
			bonusPoint = scorePerObject * 5;
		}
		
		public function countScore():String
		{
			currentScore += scorePerObject;
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
			currentScore -= objectBreakPenalty;
			scoreRecord.penalty += objectBreakPenalty;
		}
		
		public function fallPenalty():void
		{
			currentScore -= objectFallPenalty
			scoreRecord.penalty += objectFallPenalty;
		}
		
		public function getStarBonus(star:StarObject):String
		{
			var bonus:int = star.starValue * scorePerObject * 10;
			addScore(bonus);
			scoreRecord.starBonus += bonus;
			currentScore += bonus;
			
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
			currentScore += bonusPoint;
			return bonusPoint.toString();
		}
		
		public function sumUpScore():void
		{
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