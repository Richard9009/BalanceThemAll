package general 
{
	import gameObjects.StarObject;
	import org.flashdevelop.utils.FlashConnect;
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class GameSceneDataHandler 
	{
		public function GameSceneDataHandler() 
		{
			
		}
		
		public static function updateLevelPanels(levelPanelArray:Array):void {		
			
			for (var i:int; i < levelPanelArray.length; i++) {
				updateLevelPanelsRow(levelPanelArray[i]);
			}
		}
		
		public static function updateLevelPanelsRow(lPanelRow:Array):void {
			for each (var lPanel:LevelPanel in lPanelRow) {
					
					var rec:StageRecord = StageRecord.getStageRecordByID(lPanel.stageID);
					if (rec.stageStatus == StageRecord.LOCKED) lPanel.lockStage();
					
					var star:StarObject;
					var builder:SpecialObjectBuilder = new SpecialObjectBuilder(0.3);
					switch(rec.bestStar) {
						case StarObject.GOLDEN: star = builder.createGoldenStar(0, 0); break;
						case StarObject.SILVER: star = builder.createSilverStar(0, 0); break;
						case StarObject.BRONZE: star = builder.createBronzeStar(0, 0); break;
						default: star = null;
					}
					
					if (star != null) lPanel.addChild(star);
				}
		}
		
		public static function displayScoreOnStageClearScene(scene:EndLevel_Movie, record:ScoreRecord):void
		{
			var minusSign:String = (record.penalty > 0) ? "-" : "";
			
			scene.lastScoreText.text = record.scoreBeforeStage.toString();
			scene.scoreText.text = record.scoreInThisStage.toString();
			scene.starBonusText.text = record.starBonus.toString();
			scene.penaltyText.text = minusSign + record.penalty.toString();
			scene.totalText.text = ScoreRecord.totalScore.toString();
			
			scene.goldStarSymbol.visible = record.gotGoldStar;
			scene.silverStarSymbol.visible = record.gotSilverStar;
			scene.bronzeStarSymbol.visible = record.gotBronzeStar;
		}
	}

}