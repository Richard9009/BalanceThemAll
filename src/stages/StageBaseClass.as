package stages 
{
	import assets.AssetCollection;
	import assets.SoundCollection;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	import flash.errors.IOError;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import gameEvents.BalanceLineEvent;
	import gameEvents.GameEvent;
	import gameEvents.GrabObjectEvent;
	import gameEvents.ObjectBreakEvent;
	import flash.display.Sprite;
	import flash.events.GestureEvent;
	import flash.text.StaticText;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import gameObjects.rigidObjects.*;
	import gameObjects.BalanceLine;
	import gameObjects.FloatingText;
	import gameObjects.Hand;
	import gameObjects.StarObject;
	import general.ScoreCounter;
	import general.StageRecord;
	import org.flashdevelop.utils.FlashConnect;
	
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class StageBaseClass extends Sprite 
	{
		public static const HEADER_HEIGHT:Number = 50.0;
		public static const ITEMBOX_HEIGHT:Number = 150.0;
		public static const STAGE_WIDTH:Number = 800.0;
		public static const STAGE_HEIGHT:Number = 600.0;
		public static const BORDER_THICKNESS:Number = 10;
		
		private static const RED_COLOR:uint = 0xAA2233;
		
		protected var borderList:Array;
		protected var balanceBoard:BalanceBoard;
		protected var groundBody:b2Body;
		
		protected var record:StageRecord;
		protected var bLine:BalanceLine;
		protected var showBalanceLine:Boolean = true;
		protected var objectsOnHand:Array;
		
		private var sCounter:ScoreCounter;
		private var menuButton:Sprite;
		private var replayButton:Sprite;
		
		private var scoreText:TextField;
		private var tFormat:TextFormat;
		
		private var rHand:Hand = new Hand(true);
		private var lHand:Hand = new Hand(false);
		private var rHandIsEmpty:Boolean = true;
		
		public var stars:Array = new Array();
		
		public function StageBaseClass() 
		{
			super();
			
			if (Main.getWorld() == null) {
				throw new IOError("Physic world can't be found. Please create a world before creating a Stage");
			}
			
			sCounter = new ScoreCounter();
			borderList = new Array();
			objectsOnHand = new Array();
			bLine = new BalanceLine();
			addChild(bLine);
			
			rHand.x = 300;
			rHand.y = 300;
			lHand.x = 300;
			lHand.y = 300;
			addChild(rHand);
			addChild(lHand);
			
			addEventListener(GameEvent.GAME_OVER, gameOver);
			addEventListener(GrabObjectEvent.GRAB_AN_OBJECT, grabAnObject);
			addEventListener(GrabObjectEvent.DROP_AN_OBJECT, dropAnObject);
			addEventListener(GrabObjectEvent.DROP_ALL_OBJECTS, dropAll);
			addEventListener(GrabObjectEvent.OBJECT_RELOCATED, objectRelocated);
			addEventListener(GrabObjectEvent.OBJECT_STOPS, displayScore);
			addEventListener(BalanceLineEvent.START_DRAW_LINE, startDrawLine);
			addEventListener(BalanceLineEvent.STOP_DRAW_LINE, stopDrawLine);
			addEventListener(ObjectBreakEvent.GENERATE_PARTICLE, generateParticle);
			
			createBorders();
			createScoreCounter();
			createMenuButton();
		}
		
		public function removeAllListeners():void {
			removeEventListener(GameEvent.GAME_OVER, gameOver);
			removeEventListener(GrabObjectEvent.GRAB_AN_OBJECT, grabAnObject);
			removeEventListener(GrabObjectEvent.DROP_AN_OBJECT, dropAnObject);
			removeEventListener(GrabObjectEvent.DROP_ALL_OBJECTS, dropAll);
			removeEventListener(GrabObjectEvent.OBJECT_STOPS, displayScore);
			removeEventListener(BalanceLineEvent.START_DRAW_LINE, startDrawLine);
			removeEventListener(BalanceLineEvent.STOP_DRAW_LINE, stopDrawLine);
			removeEventListener(ObjectBreakEvent.GENERATE_PARTICLE, generateParticle);
			
			destroyAllObjects();
		}
		
		protected function initiateStage(id:String):void
		{
			record = StageRecord.getStageRecordByID(id);
			record.stageStarted();
			sCounter.setScoreRecord(record.scoreRecord);
		}
		
		private function destroyAllObjects():void {
			
			while (record.itemList.length > 0) {
				var obj:DraggableObject = record.itemList[0] as DraggableObject;
				obj.destroyMe();
				record.itemList.splice(0, 1);
			}
		}
		
		private function createMenuButton():void 
		{
			var assetCol:AssetCollection = new AssetCollection();
			menuButton = new assetCol.menuButtonAsset();
			menuButton.width = 30;
			menuButton.height = 30;
			menuButton.x = STAGE_WIDTH - menuButton.width;
			menuButton.y = HEADER_HEIGHT / 2;
			addChild(menuButton);
			menuButton.addEventListener(MouseEvent.CLICK, onMenuClick);
			
			replayButton = new assetCol.replayButtonAsset();
			replayButton.width = 30;
			replayButton.height = 30;
			replayButton.x = STAGE_WIDTH - replayButton.width - menuButton.width - 10;
			replayButton.y = HEADER_HEIGHT / 2;
			addChild(replayButton);
			replayButton.addEventListener(MouseEvent.CLICK, onReplayClick);
		}
		
		private function onReplayClick(e:MouseEvent):void 
		{
			parent.dispatchEvent(new GameEvent(GameEvent.RESTART_LEVEL));
		}
		
		private function onMenuClick(e:MouseEvent):void 
		{
			parent.dispatchEvent(new GameEvent(GameEvent.PAUSE_GAME));
		}
		
		private function generateParticle(e:ObjectBreakEvent):void 
		{
			var particlesNum:int = Math.floor(Math.random() * 10 + 10);
			for (var i:int = 0; i < particlesNum; i++)
			{
				var p:Particle = new Particle();
				var randomX:Number = e.brokenObject.x + Math.random() * e.brokenObject.width - e.brokenObject.width / 2;
				var randomY:Number = e.brokenObject.y + Math.random() * e.brokenObject.height - e.brokenObject.height / 2;
				p.setPosition(randomX, randomY);
				addChild(p);
			}
			
			var fText:FloatingText = new FloatingText(sCounter.getBreakPenaltyString(), 2, 2, RED_COLOR);
			fText.x = e.brokenObject.x;
			fText.y = e.brokenObject.y;
			addChild(fText);
			
			sCounter.breakPenalty();
			updateScore();
			
			removeChild(e.brokenObject);
		}
		
		private function gameOver(e:GameEvent):void 
		{
			FlashConnect.trace("game over");
		}
		
		protected function displayScore(e:GrabObjectEvent):void 
		{
			record.droppedItemsCount++;
			
			var item:DraggableObject =  e.object.GetUserData();
			var fText:FloatingText;
			if (item.onWhichBalanceBoard()) {
				fText = new FloatingText(sCounter.countScore(item, item.onWhichBalanceBoard()));
				checkStarCollision(item);
			}	
			else {
				fText = new FloatingText("Miss", 2, 2, RED_COLOR);
				item.destroyMe();
				record.missedItemsCount++;
			}
			fText.x = e.object.GetUserData().x;
			fText.y = e.object.GetUserData().y;
			addChild(fText);
			
			updateScore();
			
			if (record.allItemsDropped() && stars.length > 0) delayAction(2000, levelClear);
		}
		
		protected function levelClear():void 
		{
			FlashConnect.trace("level clear");
			sCounter.sumUpScore();
			record.stageCleared();
			parent.dispatchEvent(new GameEvent(GameEvent.STAGE_CLEAR));
		}
		
		private function countBonusPoints():void
		{
			if (record.allItemsDropped()) return;
			
			for each(var obj:DraggableObject in record.itemList) {
				if (obj.insideItemBox()) {
					var fText:FloatingText = new FloatingText(sCounter.getBonusPoints());
					fText.x = obj.x;
					fText.y = obj.y;
					addChild(fText);
				}
			}
		}
		
		protected function checkStarCollision(item:Sprite):void
		{
			if (stars.length < 1) return;
			
			for (var i:int = 0; i < stars.length; i++)
			{
				var star:StarObject = stars[i] as StarObject;
				
				if (star.hitTestObject(item)) {
					var fText:FloatingText = new FloatingText(sCounter.getStarBonus(star), 2, 3, star.getColor());
					fText.x = star.x;
					fText.y = star.y;
					addChild(fText);
					
					record.registerStar(star.getStarType());
					
					star.startFadeOut();
					stars.splice(i, 1);
					updateScore();
				}
			}
			
			if (stars.length == 0) {
				countBonusPoints();
				delayAction(2000, levelClear);
			}
		}
		
		protected function delayAction(delay:Number, action:Function):void {
			var delayTimer:Timer = new Timer(delay);
			delayTimer.start();
			delayTimer.addEventListener(TimerEvent.TIMER, function delay(e:TimerEvent):void {
				delayTimer.stop();
				delayTimer.removeEventListener(TimerEvent.TIMER, delay);
				action();
			});
		}
		
		private function createScoreCounter():void
		{
			tFormat = new TextFormat("Arial", 20, 0xAA9933, true);
			
			scoreText = new TextField();
			scoreText.selectable = false;
			scoreText.width = 1000;
			updateScore();
			
			scoreText.x = 25;
			scoreText.y = HEADER_HEIGHT / 2 - 10;
			addChild(scoreText);
		}
		
		protected function dropAll(e:GrabObjectEvent):void 
		{
			bLine.stopDrawLine();
			objectsOnHand = new Array();
			
			rHand.stopHoldObject();
			lHand.stopHoldObject();
			rHandIsEmpty = true;
		}
		
		private function stopDrawLine(e:BalanceLineEvent):void 
		{
			if(showBalanceLine) bLine.stopDrawLine();
		}
		
		private function startDrawLine(e:BalanceLineEvent):void 
		{
			if(showBalanceLine) bLine.startDrawLine(objectsOnHand[0], objectsOnHand[1]);
		}
		
		private function dropAnObject(e:GrabObjectEvent):void 
		{
			if (rHand.isHoldingThisObject(e.object.GetUserData())) {
				rHand.stopHoldObject();
				rHandIsEmpty = true;
			}
			else {
				lHand.stopHoldObject();
			}
			
			for (var i:int = 0; i < objectsOnHand.length; i++) 
			{
				if (objectsOnHand[i] == e.object) {
					objectsOnHand.splice(i, 1);
					if (objectsOnHand.length < 2) 
						dispatchEvent(new BalanceLineEvent(BalanceLineEvent.STOP_DRAW_LINE));
					return;
				}
			}
		}
		
		private function objectRelocated(e:GrabObjectEvent):void 
		{
			var obj:DraggableObject = e.object.GetUserData() as DraggableObject;
			if (obj.onWhichBalanceBoard() == null) {
				obj.destroyMe();
				
				var fText:FloatingText = new FloatingText(sCounter.getFallPenaltyString(), 2, 2, RED_COLOR);
				fText.x = obj.x;
				fText.y = obj.y;
				addChild(fText);
				
				sCounter.fallPenalty();
				updateScore();
			}
		}
		
		protected function updateScore():void
		{
			scoreText.text = "Score: " + sCounter.getScore().toString();
			scoreText.setTextFormat(tFormat);
		}
		
		protected function grabAnObject(e:GrabObjectEvent):void
		{
			objectsOnHand.push(e.object);
			
			if (rHandIsEmpty) {
				rHandIsEmpty = false;
				rHand.startHoldObject(e.object.GetUserData());
			}
			else {
				lHand.startHoldObject(e.object.GetUserData());
			}
			
			if (objectsOnHand.length == 2) 
				dispatchEvent(new BalanceLineEvent(BalanceLineEvent.START_DRAW_LINE));
		}
		
		public function getStageRecord():StageRecord
		{
			return record;
		}
		
		protected function createItems(itemList:Array):void
		{
			for each(var iArray:Array in itemList)
			{
				for each(var item:DraggableObject in iArray)
				{
					record.registerItem(item);
					addChild(item);
				}
			}
		}
		
		protected function createStars():void
		{
			for each(var star:StarObject in stars) addChild(star);
		}
		
		protected function createBorders():void 
		{
			var bd:b2BodyDef = new b2BodyDef();
			var fd:b2FixtureDef = new b2FixtureDef();
			var borderBody:b2Body;
			var borderShape:b2PolygonShape = new b2PolygonShape();
			var borderThickness:Number = BORDER_THICKNESS/2;
			
			bd.type = b2Body.b2_staticBody;
			fd.density = 0;
			fd.friction = 0.5;
			
			//----------------------- VERTICAL BORDERS ------------------------
			
			borderShape.SetAsBox(borderThickness / Main._physScale, this.height / (2 * Main._physScale));
			fd.shape = borderShape;
			
			/****** LEFT BORDER ********/
			bd.position.Set( borderThickness / Main._physScale ,  this.height / (2 * Main._physScale));
			borderBody = Main.getWorld().CreateBody(bd);
			borderBody.CreateFixture(fd);
			borderList.push(borderBody);
			
			/****** RIGHT BORDER ********/
			bd.position.Set( (this.width - borderThickness) / Main._physScale, this.height / (2 * Main._physScale));
			borderBody = Main.getWorld().CreateBody(bd);
			borderBody.CreateFixture(fd);
			borderList.push(borderBody);
			
			//------------------------ HORIZONTAL BORDERS ------------------------
			
			borderShape.SetAsBox(this.width/(2 * Main._physScale), borderThickness / Main._physScale);
			fd.shape = borderShape;
			
			/****** TOP BORDER ***********/
			bd.position.Set( this.width / (2 * Main._physScale), (HEADER_HEIGHT + borderThickness) / Main._physScale);
			borderBody = Main.getWorld().CreateBody(bd);
			borderBody.CreateFixture(fd);
			borderList.push(borderBody);
			
			/****** ITEM BOX UPPER BORDER ***********/
			bd.position.Set( this.width / (2 * Main._physScale), (this.height - ITEMBOX_HEIGHT - borderThickness) / Main._physScale);
			borderBody = Main.getWorld().CreateBody(bd);
			groundBody = borderBody;
			borderBody.CreateFixture(fd);
			borderList.push(borderBody);
			
			/****** ITEM BOX LOWER BORDER ***********/
			bd.position.Set( this.width / (2 * Main._physScale), (this.height - borderThickness) / Main._physScale);
			borderBody = Main.getWorld().CreateBody(bd);
			borderBody.CreateFixture(fd);
			borderList.push(borderBody);
		}
		
	}

}