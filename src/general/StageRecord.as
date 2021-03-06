package general 
{
	import flash.errors.IllegalOperationError;
	import flash.external.ExternalInterface;
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
		public static const COMPLETED:String = "COMPLETED";
		
		public static var stageRecordList:Array = new Array();
		public static var totalStages:int = 4;
		public static var subStageinEveryStage:int = 5;
		
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
			if(stageStatus == OPEN) stageStatus = ONGOING;
			startTime = (new Date()).getTime();
			
			totalItemsCount = 0;
			droppedItemsCount = 0;
			
			scoreRecord.resetScore();
			itemList = new Array();
		}
		
		public function stageCleared():void
		{
			if(stageStatus != COMPLETED) stageStatus = CLEARED;
			endTime = (new Date()).getTime();
			var miliTimeCleared:Number = endTime - startTime;
			timeCleared = new Date(0, 0, 0, 0, 0, 0, 0);
			timeCleared.seconds = Math.floor(miliTimeCleared / 1000);
			unlockNextLevel();
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
		
		private function unlockNextLevel():void
		{
			var next:StageRecord = getNextLevel();
			if(next.stageStatus == LOCKED) 
				next.stageStatus = OPEN;
		}
		
		private function getNextLevel():StageRecord
		{
			var stg:int = int(stageID.split("_")[0]);
			var subStg:int = int(stageID.split("_")[1]);
			var nextStageID:String;
			
			if (subStg + 1 > subStageinEveryStage) {
				nextStageID = (stg + 1).toString() + "_1";
			} else {
				nextStageID = stg.toString() + "_" + (subStg + 1).toString();
			}
			
			return getStageRecordByID(nextStageID);
		}
		
		public static function CreateRecordList():void //this method shall only be called once in an application
		{	
			stageRecordList = new Array();
			
			for (var stageCount:int = 0; stageCount < totalStages; stageCount++) {
				for (var subStageCount:int = 0; subStageCount < subStageinEveryStage; subStageCount++) {
					var stage:StageRecord = new StageRecord(PASS_CODE);
					stage.stageID = (stageCount + 1).toString() + "_" + (subStageCount + 1).toString();
					
					if (stage.stageID == "1_1") stage.stageStatus = OPEN;
					//if (true) stage.stageStatus = CLEARED;
					else stage.stageStatus = LOCKED;
					
					stageRecordList.push(stage);
				}
			}
			
			var tutorialStage:StageRecord = new StageRecord(PASS_CODE);
			tutorialStage.stageID = "tutorial";
			stage.stageStatus = OPEN;
			stageRecordList.push(tutorialStage);
			
			if(ExternalInterface.available) ExternalInterface.addCallback("loadRecord", loadRecord);
		}
		
		public static function unlockAll():void {
			for each(var stage:StageRecord in stageRecordList)
			{
				stage.stageStatus = CLEARED;
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
		
		public static function updateSaveData():void
		{
			var progress:String = "";
			for each(var stage:StageRecord in stageRecordList)
			{
				switch(stage.stageStatus) {
					case ONGOING:
					case OPEN : progress += "O"; break;
					case LOCKED : progress += "L"; break;
					case COMPLETED : progress += "C"; break;
					case CLEARED : 
						{
							switch(stage.bestStar) {
								case StarObject.GOLDEN : progress += "3"; break;
								case StarObject.SILVER : progress += "2"; break;
								case StarObject.BRONZE : progress += "1"; break;
							}
						} break;
					default: progress += "L"; break;
				}
			}
			
			var param:Object = new Object();
			param.progress = progress;
			param.score = ScoreRecord.totalScore;
			
			if(ExternalInterface.available) ExternalInterface.call("updateSave", param);
		}
		
		public static function loadRecord(progress:String, score:int):void
		{
			var index:int = 0;
			for each(var stage:StageRecord in stageRecordList) {
				switch(progress.charAt(index)) {
					case "O": stage.stageStatus = OPEN; break;
					case "L": stage.stageStatus = LOCKED; break;
					case "C": stage.stageStatus = COMPLETED; break;
					
					case "1": stage.stageStatus = CLEARED;
							  stage.bestStar = StarObject.BRONZE;
							  break;
					
					case "2": stage.stageStatus = CLEARED;
							  stage.bestStar = StarObject.SILVER;
							  break;
					
					case "3": stage.stageStatus = CLEARED;
							  stage.bestStar = StarObject.GOLDEN;
							  break;
				}
			}
			
			ScoreRecord.totalScore = score;
		}
	}
}