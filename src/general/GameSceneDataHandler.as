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
			FlashConnect.trace(levelPanelArray);
			for each(var lPanelRow:Array in levelPanelArray) {
				for each (var lPanel:LevelPanel in lPanelRow) {
					
					var rec:StageRecord = StageRecord.getStageRecordByID(lPanel.stageID);
					if (rec.stageStatus == StageRecord.LOCKED) lPanel.lockStage();
					
					var star:StarObject;
					var objCol:ObjectCollection = new ObjectCollection(0.3);
					switch(rec.bestStar) {
						case StarObject.GOLDEN: star = objCol.createGoldenStar(0, 0); break;
						case StarObject.SILVER: star = objCol.createSilverStar(0, 0); break;
						case StarObject.BRONZE: star = objCol.createBronzeStar(0, 0); break;
						default: star = null;
					}
					
					if (star != null) lPanel.addChild(star);
				}
			}
		}
	}

}