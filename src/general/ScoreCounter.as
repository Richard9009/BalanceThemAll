package general 
{
	import flash.display.Sprite;
	import gameObjects.StarObject;
	import stages.StageBaseClass;
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class ScoreCounter 
	{
		private  var currentScore:int = 0;
		private var scoreSegmentHeight:Number = 100;
		private var scorePerSegment:Number = 20;
		
		private var objectBreakPenalty:int;
		private var objectFallPenalty:int;
		
		public var scoreRecord:ScoreRecord;
		
		public function ScoreCounter() 
		{
			/*		index = ceil(object / segment height)
			 * 		score = scorePerSegment * index
			 * 
			 * 		.................................................	index = 1
			 * 		.			.			.			.			. \
			 * 		.			.			.			.			.  \{segment
			 * 		.			.	middle of balancer:	.			.  / height}
			 * 		.			.		score = 0		.			. /
			 * 		x2__________x1__________0__________x1__________x2  	index = 0
			 * 	(score rate)			|       |
			 * 							|       |
			 *	________________________|_ _ _ _|________________________________hit the ground: score = 0
			 */
			
			 calcPenalty();
			 scoreRecord = new ScoreRecord();
		}
		
		public function setScoreRate(averageScorePerObject:int):void 
		{
			scorePerSegment = averageScorePerObject;
			calcPenalty();
		}
		
		private function calcPenalty():void
		{
			objectBreakPenalty = scorePerSegment * 10;
			objectFallPenalty = scorePerSegment * 3;
		}
		
		public function countScore(item:Sprite, balanceBoard:Sprite):String 
		{
			if (scoreIsValid(item, balanceBoard)) {
				var fromBalancer:Number = balanceBoard.y - item.y;
				var segmentIndex:int = Math.ceil(fromBalancer / scoreSegmentHeight);
				var score:Number = scorePerSegment * segmentIndex;
				score = Math.round(score * scoreRate(item, balanceBoard) / 10) * 10;
				currentScore += score;
				scoreRecord.scoreInThisStage += score;
				
				return score.toString();
			}
			else {
				return "Miss";
			}
		}
		
		private function scoreIsValid(obj:Sprite, balanceBoard:Sprite):Boolean 
		{
			return ((obj.x < balanceBoard.x + balanceBoard.width / 2) && (obj.x > balanceBoard.x - balanceBoard.width / 2));
		}
		
		private function scoreRate(obj:Sprite, balanceBoard:Sprite):Number 
		{
			var distFromCenter:Number = Math.abs(obj.x - balanceBoard.x);
			var rate:Number = distFromCenter / (balanceBoard.width/2)* 2;
			
			return Math.round(rate * 10) / 10;
		}
		
		public function getScore():int {
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
			var bonus:int = star.starValue * scorePerSegment * 10;
			addScore(bonus);
			scoreRecord.starBonus += bonus;
			currentScore += bonus;
			
			switch(star.starType) {
				case StarObject.GOLDEN: scoreRecord.gotGoldStar = true; break;
				case StarObject.SILVER: scoreRecord.gotSilverStar = true; break;
				case StarObject.BRONZE: scoreRecord.gotBronzeStar = true; break;
			}
			
			return bonus.toString();
		}
		
		public function sumUpScore():void
		{
			scoreRecord.sumUpScore();
		}
		
		public function getBreakPenaltyString():String { return "-" + objectBreakPenalty.toString(); }
		public function getFallPenaltyString():String { return "-" + objectFallPenalty.toString(); }
		
	}

}