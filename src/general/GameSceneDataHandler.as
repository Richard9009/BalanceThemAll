package general 
{
	import builders.SpecialObjectBuilder;
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
		
		public static function updateLevelMap(starArray:Array):void {
			for (var i:int = 0; i < starArray.length; i++) {
				for (var j:int = 0; j < starArray[0].length; j++) {
					var stageID:String = (i + 1).toString() + "_" + (j + 1).toString();
					var rec:StageRecord = StageRecord.getStageRecordByID(stageID);
					var selectLvStar:SelectLevelStar = starArray[i][j] as SelectLevelStar;
					selectLvStar.setStatus(rec.stageStatus, rec.bestStar);
				}
			}
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
	}

}