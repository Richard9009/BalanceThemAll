package stages 
{
	import assets.AssetCollection;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import gameEvents.GameEvent;
	import general.ScoreCounter;
	
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class StageHeader extends Sprite 
	{
		private var pauseBtn:Sprite;
		private var replayBtn:Sprite;
		private var scoreText:TextField;
		private var tFormat:TextFormat;
		
		public function StageHeader() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			addEventListener(MouseEvent.MOUSE_DOWN, abcd);
		}
		
		private function abcd(e:MouseEvent):void 
		{
			trace(e.target + "   " + e.currentTarget);
		}
		
		
		private function addedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			
			createPauseButton();
			createReplayButton();
			createScoreCounter();
		}
		
		
		private function createPauseButton():void 
		{
			var assetCol:AssetCollection = new AssetCollection();
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
			var assetCol:AssetCollection = new AssetCollection();
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
		
		private function createScoreCounter():void
		{
			tFormat = new TextFormat("Arial", 20, 0xAA9933, true);
			
			scoreText = new TextField();
			scoreText.selectable = false;
			scoreText.width = 300;
			
			scoreText.x = 25;
			scoreText.y = StageConfig.HEADER_HEIGHT / 2 - 10;
			addChild(scoreText);
		}
		
		public function updateScore(sCounter:ScoreCounter):void
		{
			scoreText.text = "Score: " + sCounter.getScore().toString();
			scoreText.setTextFormat(tFormat);
		}
		
	}

}