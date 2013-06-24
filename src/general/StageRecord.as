package general 
{
	import flash.errors.IllegalOperationError;
	import gameObjects.rigidObjects.DraggableObject;
	import gameObjects.StarObject;
	import org.flashdevelop.utils.FlashConnect;
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class StageRecord 
	{
		protected static const PASS_CODE:Number = 928374281374;
		
		public static const ONGOING:String = "ONGOING";
		public static const LOCKED:String = "LOCKED";
		public static const OPEN:String = "OPEN";
		public static const CLEARED:String = "CLEARED";
		
		public static var stageRecordList:Array = new Array();
		public static var totalStages:int = 5;
		public static var subStageinEveryStage:int = 5;
		
		public static var currentStage:int = 1;
		public static var currentSubStage:int = 1;
		
		public var stageID:String; //"1_1", "1_2", "1_3", etc
		public var stageStatus:String = "OPEN";
		public var bestStar:String = "NOTHING";
		public var timeCleared:Date;
		public var missedItemsCount:int = 0;
		public var droppedItemsCount:int = 0;
		public var totalItemsCount:int = 0;
		public var itemList:Array = new Array();
		public var scoreRecord:ScoreRecord = new ScoreRecord();
		
		private var startTime:Number;
		private var endTime:Number;
		
		public function StageRecord(pass:Number) 
		{
			if (pass != PASS_CODE) {
				throw new IllegalOperationError("You can't use new method to get an object of this class!!! Use getStage method");
			}
		}
		
		public function stageStarted():void
		{
			stageStatus = ONGOING;
			startTime = (new Date()).getTime();
			currentStage = stageID.split("_")[0].toString();
			currentSubStage = stageID.split("_")[1].toString();
			
			totalItemsCount = 0;
			droppedItemsCount = 0;
			
			scoreRecord.resetScore();
		}
		
		public function stageCleared():void
		{
			stageStatus = CLEARED;
			endTime = (new Date()).getTime();
			var miliTimeCleared:Number = endTime - startTime;
			timeCleared = new Date(0, 0, 0, 0, 0, 0, 0);
			timeCleared.seconds = Math.floor(miliTimeCleared / 1000);
		}
		
		public function allItemsDropped():Boolean
		{
			return droppedItemsCount == totalItemsCount;
		}
		
		public function registerItem(item:DraggableObject):void
		{
			itemList.push(item);
			totalItemsCount++;
		}
		
		public function registerStar(starType:String):void
		{
			if (getStarRank(starType) > getStarRank(bestStar)) bestStar = starType;
		}
		
		private function getStarRank(starType:String):int
		{
			switch(starType) {
				case StarObject.GOLDEN: return 3;
				case StarObject.SILVER: return 2;
				case StarObject.BRONZE: return 1;
				default: return 0;
			}
		}
		
		public static function CreateRecordList():void //this method shall only be called once in an application
		{	
			stageRecordList = new Array();
			
			for (var stageCount:int = 0; stageCount < totalStages; stageCount++) {
				for (var subStageCount:int = 0; subStageCount < subStageinEveryStage; subStageCount++) {
					var stage:StageRecord = new StageRecord(PASS_CODE);
					stage.stageID = (stageCount + 1).toString() + "_" + (subStageCount + 1).toString();
					if (stageCount > 1) stage.stageStatus = LOCKED;
					stageRecordList.push(stage);
				}
			}
		}
		
		public static function getStageRecordByID(id:String):StageRecord
		{
			for each(var stage:StageRecord in stageRecordList)
			{
				if (stage.stageID == id) {
					var stgID:Array = id.split("_");
					return stage;
				}
			}
			
			return null;
		}
		
		public static function getNextStageRecord():StageRecord
		{
			currentSubStage++;
			if (currentSubStage > subStageinEveryStage) {
				currentSubStage = 1;
				currentStage++;
			}
			
			var nextStgID:String = currentStage.toString() + "_" + currentSubStage.toString();
			return getStageRecordByID(nextStgID);
		}
		
	}
}