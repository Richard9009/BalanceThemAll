package general 
{
	import builders.SpecialObjectBuilder;
	import flash.display.Sprite;
	import flash.geom.Point;
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
					drawConnectingLines(i, j, starArray);
				}
			}
		}
		
		public static function drawConnectingLines(index1:int, index2:int, array:Array):void {
			if (index2 > 0) {
				var thisStar:SelectLevelStar = array[index1][index2] as SelectLevelStar;
				var prevStar:SelectLevelStar = array[index1][index2 - 1] as SelectLevelStar;
				var line:Sprite = new Sprite();
				var lineColor:uint;
				
				switch(index1) {
					case 0: lineColor = 0x0033FF; break;
					case 1: lineColor = 0x663399; break;
					case 2: lineColor = 0xCC66CC; break;
				}
				
				thisStar.drawLine(new Point(prevStar.x, prevStar.y), lineColor);
			}
		}
		
	}

}