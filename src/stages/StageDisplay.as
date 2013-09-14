package stages 
{
	import assets.AssetCollection;
	import Box2D.Common.Math.b2Vec2;
	import builders.StageBuilder;
	import flash.display.Sprite;
	import gameEvents.GrabObjectEvent;
	import gameEvents.PowerEvent;
	import gameObjects.BlueLayer;
	import gameObjects.ItemPanel;
	import gameObjects.rigidObjects.DraggableObject;
	import general.Power;
	import general.StageRecord;
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class StageDisplay extends StageTutorialEngine 
	{
		private var collection:AssetCollection;
		private var assetList:Array;;
		
		private var rightIP:ItemPanel;
		private var leftIP:ItemPanel;
		
		public function StageDisplay(stageID:int) 
		{	
			collection = new AssetCollection();
			assetList = [collection.stageAsset, collection.stage2BGAsset, collection.stage3BGAsset];
			
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
			switch(e.power.type) {
				case Power.BALANCE: bLine.visible = true;
										addChild(new BlueLayer(e.power));
										addEventListener(PowerEvent.POWER_COMPLETE, powerComplete_balance);
										break;
			}
		}
		
		protected function initiateStage(id:String):void
		{
			record = StageRecord.getStageRecordByID(id);
			if(record) {
				record.stageStarted();
				sCounter.setScoreRecord(record.scoreRecord);
				header.updateScore(sCounter);
			}
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
		
		override protected function grabAnObject(e:GrabObjectEvent):String 
		{
			var whatHand:String = super.grabAnObject(e);
			var iPanel:ItemPanel;
			var grabbedObject:DraggableObject = e.object.GetUserData() as DraggableObject;
			
			if (whatHand == "right") {
				rightIP = new ItemPanel();
				rightIP.x = StageConfig.STAGE_WIDTH - 15 - rightIP.panelWidth/2;
				rightIP.y = StageConfig.HEADER_HEIGHT + 15 + rightIP.panelHeight / 2;
				iPanel = rightIP;
			} else {
				leftIP = new ItemPanel();
				leftIP.x = leftIP.panelWidth / 2 + 15;
				leftIP.y = StageConfig.HEADER_HEIGHT + 15 + rightIP.panelHeight / 2;
				iPanel = leftIP;
			}
			
			iPanel.displayData(grabbedObject.objectData);
			addChild(iPanel);
			
			
			return whatHand;
		}
		
	}

}