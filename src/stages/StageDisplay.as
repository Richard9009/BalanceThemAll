package stages 
{
	import assets.AssetCollection;
	import builders.StageBuilder;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class StageDisplay extends StageTutorialEngine 
	{
		private var collection:AssetCollection;
		private var assetList:Array;;
		
		public function StageDisplay(stageID:int) 
		{	
			collection = new AssetCollection();
			assetList = [collection.stageAsset, collection.stage2BGAsset];
			
			var assetData:Sprite = new assetList[stageID - 1]() as Sprite;
			assetData.x = StageConfig.STAGE_WIDTH / 2; 
			assetData.y = StageConfig.STAGE_HEIGHT / 2;
			this.addChild(assetData);
			
			super();
		}
		
		public function createLevelBySubStageID(stageID:int, subStageIndex:int, hasTutorial:Boolean = false):void {
			
			var stgID:String = stageID.toString()+ "_" + subStageIndex.toString();
			initiateStage(stgID); 
			if(hasTutorial) createTutorialDialog(stgID);
			
			var builder:StageBuilder = new StageBuilder();
			addChild(builder.buildAndGetStage(stageID, subStageIndex));
			stars = builder.getStars();
			builder.getFoundation().setBalanceLine(bLine);
		}
		
	}

}