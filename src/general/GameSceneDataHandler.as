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
		
	}

}