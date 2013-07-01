package stages 
{
	import assets.AssetCollection;
	import Box2D.Common.Math.b2Vec2;
	import builders.StageBuilder;
	import flash.display.Sprite;
	import gameEvents.PowerEvent;
	import gameObjects.BlueLayer;
	import gameObjects.rigidObjects.DraggableObject;
	import general.PowerType;
	import general.StageRecord;
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
			this.addChildAt(assetData,0);
			
			addEventListener(PowerEvent.USE_SPECIAL_POWER, handlePower);
			
			super();
		}
		
		private function powerComplete_balance(e:PowerEvent):void 
		{
			bLine.visible = false;
			removeEventListener(PowerEvent.POWER_COMPLETE, powerComplete_balance);
		}
		
		private function handlePower(e:PowerEvent):void 
		{
			switch(e.powerType) {
				case PowerType.BALANCE: bLine.visible = true;
										addChild(new BlueLayer(60000));
										addEventListener(PowerEvent.POWER_COMPLETE, powerComplete_balance);
										break;
			}
		}
		
		protected function initiateStage(id:String):void
		{
			record = StageRecord.getStageRecordByID(id);
			record.stageStarted();
			sCounter.setScoreRecord(record.scoreRecord);
			header.updateScore(sCounter);
		}
		
		public function createLevelBySubStageID(stageID:int, subStageIndex:int, hasTutorial:Boolean = false):void {
			
			var stgID:String = stageID.toString()+ "_" + subStageIndex.toString();
			initiateStage(stgID); 
			if(hasTutorial) createTutorialDialog(stgID);
			
			var builder:StageBuilder = new StageBuilder();
			addChild(builder.buildAndGetStage(stageID, subStageIndex));
			stars = builder.getStars();
			builder.getFoundation().setBalanceLine(bLine);
			registerItems(builder.getLiftableItems());
			if (stageID == 1 && subStageIndex == 1) header.hideBalanceButton();
			bLine.visible = false;
		}
		
		private function registerItems(list:Array):void
		{
			for each(var item:DraggableObject in list) {
				record.registerItem(item);
			}
		}
		
	}

}