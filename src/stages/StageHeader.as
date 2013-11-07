package stages 
{
	import assets.AssetCollection;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import gameEvents.GameEvent;
	import gameEvents.PowerEvent;
	import gameEvents.TutorialEvent;
	import general.dialogs.DialogEventHandler;
	import general.Power;
	import general.ScoreCounter;
	import locales.LocalesTextField;
	import managers.LocalesManager;
	import managers.MessageManager;
	
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class StageHeader extends Sprite 
	{
		private var pauseBtn:Sprite;
		private var replayBtn:Sprite;
		private var scoreText:TextField;
		private var messageBox:LocalesTextField;
		private var tFormat:TextFormat;
		private var bButton:BalanceButton;
		private var assetCol:AssetCollection = new AssetCollection();
		
		public function StageHeader() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}
		
		private function addedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			
			createPauseButton();
			createReplayButton();
			createScoreCounter();
			createBalanceButton();
			createMessageBox();
		}
		
		private function createMessageBox():void
		{
			var msgFormat:TextFormat = new TextFormat("Hobo Std", 20, 0x773333, true);
			msgFormat.align = TextFormatAlign.CENTER;
			
			messageBox = new LocalesTextField("", msgFormat);
			messageBox.x = 160;
			messageBox.y = StageConfig.HEADER_HEIGHT / 2 - 10;
			messageBox.width = StageConfig.STAGE_WIDTH - messageBox.x * 2;
			messageBox.height = 30;
			messageBox.visible = false;
			addChild(messageBox);
			
			MessageManager.getInstance().setMsgBox(messageBox);
		}
		
		private function createPauseButton():void 
		{
			pauseBtn = new assetCol.menuButtonAsset();
			pauseBtn.width = 30;
			pauseBtn.height = 30; 
			pauseBtn.x = StageConfig.STAGE_WIDTH - pauseBtn.width;
			pauseBtn.y = StageConfig.HEADER_HEIGHT / 2;
			addChild(pauseBtn);
			pauseBtn.addEventListener(MouseEvent.MOUSE_UP, onMenuClick);
		}
		
		private function createReplayButton():void
		{
			replayBtn = new assetCol.replayButtonAsset();
			replayBtn.width = 30;
			replayBtn.height = 30;
			replayBtn.x = pauseBtn.x - pauseBtn.width - 10;
			replayBtn.y = StageConfig.HEADER_HEIGHT / 2;
			addChild(replayBtn);
			replayBtn.addEventListener(MouseEvent.MOUSE_UP, onReplayClick);
		}
		
		private function onReplayClick(e:MouseEvent):void
		{
			dispatchEvent(new GameEvent(GameEvent.RESTART_LEVEL));
		}
		
		private function onMenuClick(e:MouseEvent):void 
		{
			dispatchEvent(new GameEvent(GameEvent.PAUSE_GAME));
		}
		
		private function createBalanceButton():void
		{
			bButton = new BalanceButton();
			bButton.width = 38;
			bButton.height = 38;
			bButton.x = StageConfig.STAGE_WIDTH / 2;
			bButton.y = StageConfig.HEADER_HEIGHT / 2;
			//addChild(bButton); UNCOMMENT TO SHOW THE BUTTON!!!!!!!!!!!!!!!!!!
			
			bButton.addEventListener(MouseEvent.MOUSE_UP, function balancePow(e:MouseEvent):void {
				if (Power.getPower_balance().isRunning) return;
				
				dispatchEvent(new PowerEvent(PowerEvent.USE_SPECIAL_POWER, Power.getPower_balance()));
				DialogEventHandler.getInstance().dispatchEvent(new TutorialEvent(TutorialEvent.POWER_USED));
				bButton.used();
			});
		}
		
		private function createScoreCounter():void
		{
			tFormat = new TextFormat("Hobo Std", 20, 0x333333, true);
			
			scoreText = new TextField();
			scoreText.selectable = false;
			scoreText.width = 130;
			scoreText.height = 30;
			scoreText.x = 25;
			scoreText.y = StageConfig.HEADER_HEIGHT / 2 - 10;
			addChild(scoreText);
		}
		
		public function updateScore(sCounter:ScoreCounter):void
		{
			var scoreString:String = LocalesManager.getInstance().getText("header.score");
			scoreText.text = scoreString + sCounter.getScore().toString();
			scoreText.setTextFormat(tFormat);
		}
		
		public function hideBalanceButton():void
		{
			bButton.visible = false;
		}
		
	}

}