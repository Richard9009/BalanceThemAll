package 
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2DebugDraw;
	import Box2D.Dynamics.b2World;
	import flash.display.StageDisplayState;
	import flash.errors.IOError;
	import flash.events.TimerEvent;
	import flash.external.ExternalInterface;
	import flash.text.TextField;
	import flash.utils.Timer;
	import gameEvents.GameEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import gameEvents.MainMenuEvent;
	import gameEvents.SelectStageEvent;
	import general.BreakContactListener;
	import general.MousePhysic;
	import locales.LocalesEvent;
	import managers.CueManager;
	import managers.MusicManager;
	import general.GameSceneDataHandler;
	import general.ScoreRecord;
	import general.StageRecord;
	import org.flashdevelop.utils.FlashConnect;
	import stages.BasicTutorialStage;
	import stages.Opening;
	import stages.StageDisplay;
	import stages.StageEngine;
	
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class Main extends Sprite 
	{
		public static var ip_address:String;
		public static var _gravity:b2Vec2;
		public static var _physScale:Number = 30;
		
		private static var world:b2World;
		private var currentScene:Sprite;
		private var optScreen:Sprite;
		private var listenersList:Array = new Array();
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
			
		} 
		
		protected function init(e:Event = null):void 
		{
			stage.stageFocusRect = false;
			cleanListener();
			StageRecord.CreateRecordList();
			
			if (ExternalInterface.available) {
				ExternalInterface.addCallback("setIP", setIP);
				ExternalInterface.call("writeIP");
			}
			openSelectLanguage();
			// entry point
		}
		
		
		
		override public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void 
		{
			super.addEventListener(type, listener, useCapture, priority, useWeakReference);
			
			var l:ListenerModel = new ListenerModel();
			l.type = type;
			l.listener = listener;
			listenersList.push(l);
		}
		
		public function cleanListener():void 
		{
			while (listenersList.length > 0)
			{
				var l:ListenerModel = listenersList[0] as ListenerModel;
				removeEventListener(l.type, l.listener);
				listenersList.splice(0, 1);
			}
		}
		
		private function changeScene():void 
		{
			MusicManager.getInstance().stopAllMusic();
			removeChild(currentScene);
			cleanListener();
		}
		
		private function openSelectLanguage():void
		{
			currentScene = new SelectLanguage_Movie();
			addChild(currentScene);
			addEventListener(LocalesEvent.ON_LANGUAGE_SELECT, function respond():void {
				//stage.displayState = StageDisplayState.FULL_SCREEN;
				changeScene();
				createMainMenu();
				blackFadeIn();
			});
		}
		
		private function createMainMenu():void 
		{
			MusicManager.getInstance().playMainMenuBGM();
			currentScene = new MainMenu_Movie(); 
			addChild(currentScene); 
			addEventListener(GameEvent.START_GAME, showOpening);
			addEventListener(SelectStageEvent.OPEN_SELECT_LEVEL, beforeOpenSelectLevel); 
			addEventListener(MainMenuEvent.CHEAT_OPEN_ALL, unlockAll);
			addEventListener(MainMenuEvent.OPEN_CREDIT, openCredit);
		}
		
		private function openCredit(e:Event):void {
			changeScene();
			
			MusicManager.getInstance().playMainMenuBGM();
			currentScene = new CreditScreen_Movie();
			addChild(currentScene);
			blackFadeIn();
			addEventListener(MainMenuEvent.BACK_TO_MAIN, back_to_main);
		}
		
		private function back_to_main(e:Event):void {
			changeScene();
			createMainMenu();
			blackFadeIn();
		}
		
		private function unlockAll(e:Event):void {
			StageRecord.unlockAll();
		}
		
		private function beforeOpenSelectLevel(e:Event):void 
		{
			changeScene();	
			openSelectLevel();
		}
		
		private function openSelectLevel():void 
		{
			MusicManager.getInstance().playSelectStageBGM();
			currentScene = new SelectStage_Movie();
			addChild(currentScene);
			addEventListener(SelectStageEvent.STAGE_SELECTED, stageSelected);
			addEventListener(GameEvent.BACK_TO_MAIN, back_to_main);
			currentScene.visible = false;
			blackFadeIn();
			
			var delayTimer:Timer = new Timer(100, 1);
			delayTimer.start();
			delayTimer.addEventListener(TimerEvent.TIMER, function delayListener(e:TimerEvent):void{
				e.target.stop();
				e.target.removeEventListener(TimerEvent.TIMER, delayListener);
				GameSceneDataHandler.updateLevelMap(SelectStage_Movie(currentScene).starArray);
				(currentScene as SelectStage_Movie).updateStatus();
				currentScene.visible = true;
				
				StageRecord.updateSaveData();
			});
		}
		
		private function stageSelected(e:Event):void 
		{
			var selectedStage:String = (currentScene as SelectStage_Movie).stageID;
			
			changeScene();
			createLevelByID(selectedStage);
		}
		
		
		private function update(e:Event):void 
		{
			world.Step(1 / 30, 10, 10);
			
			if(debugMode) {
				world.DrawDebugData();
				setChildIndex(debugSprite, numChildren - 1);
			}
			// Go through body list and update sprite positions/rotations
			for (var bb:b2Body = world.GetBodyList(); bb; bb = bb.GetNext()){
				if (bb.GetUserData() is Sprite){
					
					var sprite:Sprite = bb.GetUserData() as Sprite;
					sprite.x = bb.GetPosition().x * _physScale;
					sprite.y = bb.GetPosition().y * _physScale;
					sprite.rotation = bb.GetAngle() * (180 / Math.PI);
				}
			}
		}
		
		private function showOpening(e:Event):void
		{
			changeScene();
			//createLevelByID("1_1");
			MusicManager.getInstance().playOpeningBGM(0.7);
			currentScene = new Opening();
			addChild(currentScene);
			//addEventListener(GameEvent.OPENING_COMPLETE, startGame);
			addEventListener(GameEvent.OPENING_COMPLETE, showBasicTutorial);
		}
		
		private function showBasicTutorial(e:GameEvent):void 
		{
			changeScene();
			createWorld();
			
			MusicManager.getInstance().playStage2SecondHalfBGM();
			currentScene = new BasicTutorialStage();
			MousePhysic.setStage(currentScene);
			addChild(currentScene);
			blackFadeIn();
			
			currentScene.addEventListener(GameEvent.BASIC_TUTORIAL_COMPLETE, startGame);
		}
		
		private function startGame(e:GameEvent):void
		{
			destroyCurrentLevel();
			createLevelByID("1_1");
		}
		
		private function createLevelByID(stageID:String):void
		{
			var idArray:Array = stageID.split("_");
			var stg:int = int(idArray[0]);
			var subStg:int = int(idArray[1]);
			var hasTutorial:Boolean = true;
			
			createWorld();
			currentScene = new StageDisplay(stg);
			addChild(currentScene);
			(currentScene as StageDisplay).createLevelBySubStageID(stg, subStg, hasTutorial);
			
			MousePhysic.setStage(currentScene);
			this.addEventListener(GameEvent.PAUSE_GAME, displayOptionScreen);
			this.addEventListener(GameEvent.RESTART_LEVEL, restartLevel);
			this.addEventListener(GameEvent.STAGE_CLEAR, stageClear);
			
			blackFadeIn();
		}
		
		private function stageClear(e:GameEvent):void 
		{
			var scoreRecord:ScoreRecord = (currentScene as StageEngine).getStageRecord().scoreRecord;
			destroyCurrentLevel();
			openSelectLevel();
		}
		
		private function destroyCurrentLevel():void
		{
			StageEngine(currentScene).destroyMe();
			changeScene(); 
			CueManager.getInstance().destroyStage();
			MousePhysic.destroyStage();
			destroyWorld();
		
		}
		
		private function restartLevel(e:GameEvent):void 
		{
			lastStageID = StageEngine(currentScene).getStageRecord().stageID;
			destroyCurrentLevel();
			createLevelByID(lastStageID);
		}
		
		private function displayOptionScreen(e:GameEvent):void 
		{
			currentScene.mouseChildren = false;
			currentScene.mouseEnabled = false;
			
			optScreen = new OptionScreen_Movie();
			addChild(optScreen);
			
			addEventListener(GameEvent.RESUME_GAME, resumeGame);
			addEventListener(GameEvent.BACK_TO_MAIN, option_to_main);
			addEventListener(SelectStageEvent.OPEN_SELECT_LEVEL_FROM_OPTION, openSelectLevelFromOption);
		}
		
		private var lastStageID:String;
		private function openSelectLevelFromOption(e:Event):void 
		{
			lastStageID = (currentScene as StageEngine).getStageRecord().stageID;
			removeChild(optScreen);
			destroyCurrentLevel();
			openSelectLevel();
			
			addEventListener(SelectStageEvent.BACK_TO_LAST_SCENE, selectStage_to_lastStage);
		}
		
		private function selectStage_to_lastStage(e:Event):void 
		{
			changeScene();
			createLevelByID(lastStageID);
		}
		
		private function option_to_main(e:Event):void 
		{
			removeChild(optScreen);
			destroyCurrentLevel();
			createMainMenu();
			blackFadeIn();
		}
		
		private function destroyWorld():void
		{
			world = null; 
		}
		
		protected function createWorld():void
		{
			_gravity = new b2Vec2(0, 10.0);
			world = new b2World(_gravity, true);
			world.SetContactListener(new BreakContactListener());
			this.addEventListener(Event.ENTER_FRAME, update);
			if(debugMode) debugDraw();
		}
		
		private function resumeGame(e:Event):void 
		{
			removeChild(optScreen);
			currentScene.mouseChildren = true;
			currentScene.mouseEnabled = true;
		}
		
		public static function getWorld():b2World    
		{  
			return world;
		}
		
		private function blackFadeIn():void
		{
			var blackLayer:BlackLayer_Movie = new BlackLayer_Movie();
			blackLayer.fadeIn();
			addChild(blackLayer);
		}
		
		private function debugDraw():void
		{
			var dbgDraw:b2DebugDraw = new b2DebugDraw();
			debugSprite.mouseEnabled = false;
			dbgDraw.SetSprite(debugSprite);
			dbgDraw.SetDrawScale(_physScale);
			dbgDraw.SetFillAlpha(0.3);
			dbgDraw.SetLineThickness(1.0);
			dbgDraw.SetFlags(b2DebugDraw.e_shapeBit | b2DebugDraw.e_jointBit);
			world.SetDebugDraw(dbgDraw);
			addChild(debugSprite);
		}
		
		private function setIP(ip:String):void {
			ip_address = ip;
		}
		
		private var debugSprite:Sprite = new Sprite();
		private var debugMode:Boolean = false;
	}
}

class ListenerModel {
	public var type:String;
	public var listener:Function;
}