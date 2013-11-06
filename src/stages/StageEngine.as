package stages 
{
	import assets.AssetCollection;
	import assets.SoundCollection;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	import flash.display.DisplayObject;
	import flash.errors.IOError;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import gameEvents.GameEvent;
	import gameEvents.GrabObjectEvent;
	import gameEvents.ObjectBreakEvent;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import managers.HandManager;
	import gameObjects.rigidObjects.*;
	import gameObjects.FloatingText;
	import gameObjects.Hand;
	import gameObjects.StarObject;
	import general.MousePhysic;
	import general.ScoreCounter;
	import general.StageRecord;
	import org.flashdevelop.utils.FlashConnect;
	
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class StageEngine extends Sprite 
	{
		private static const RED_COLOR:uint = 0xAA2233;
		
		protected var borderList:Array;
		protected var groundBody:b2Body;
		
		protected var record:StageRecord;
		protected var objectsOnHand:Array;
		protected var header:StageHeader;
		protected var sCounter:ScoreCounter;
	
		private var tFormat:TextFormat;
		protected var dropBtn:DropButton;
		
		private var rHand:Hand = new Hand(true);
		private var lHand:Hand = new Hand(false);
		private var rHandIsEmpty:Boolean = true;
		
		public var stars:Array = new Array();
		
		public function StageEngine() 
		{
			super();
			
			if (Main.getWorld() == null) {
				throw new IOError("Physic world can't be found. Please create a world before creating a Stage");
			}
			
			sCounter = new ScoreCounter();
			borderList = new Array();
			objectsOnHand = new Array();
			header = new StageHeader();
			addChild(header);
			
			rHand.x = 300;
			rHand.y = 300;
			lHand.x = 300;
			lHand.y = 300;
			addChild(rHand);
			addChild(lHand);
			
			addEventListener(GrabObjectEvent.GRAB_AN_OBJECT, grabAnObject);
			addEventListener(GrabObjectEvent.DROP_AN_OBJECT, dropAnObject);
			addEventListener(GrabObjectEvent.DROP_ALL_OBJECTS, dropAll);
			addEventListener(GrabObjectEvent.OBJECT_RELOCATED, objectRelocated);
			addEventListener(GrabObjectEvent.OBJECT_STOPS, displayScore);
			addEventListener(ObjectBreakEvent.GENERATE_PARTICLE, generateParticle);
			
			createBorders();
			createDropButton();
		}
		
		public function removeAllListeners():void {
			removeEventListener(GrabObjectEvent.GRAB_AN_OBJECT, grabAnObject);
			removeEventListener(GrabObjectEvent.DROP_AN_OBJECT, dropAnObject);
			removeEventListener(GrabObjectEvent.DROP_ALL_OBJECTS, dropAll);
			removeEventListener(GrabObjectEvent.OBJECT_STOPS, displayScore);
			removeEventListener(ObjectBreakEvent.GENERATE_PARTICLE, generateParticle);
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
			header.updateScore(sCounter);
			
			DraggableObject(e.brokenObject).destroyMe();
		}
		
		private function createDropButton():void 
		{
			dropBtn = new DropButton();
			dropBtn.width = 50;
			dropBtn.height = 50;
			dropBtn.x = StageConfig.STAGE_WIDTH / 2;
			dropBtn.y = StageConfig.HEADER_HEIGHT + dropBtn.height / 2 + StageConfig.WALL_THICKNESS;
			addChild(dropBtn);
			
			dropBtn.addEventListener(MouseEvent.MOUSE_UP, function drop(e:MouseEvent):void {
				MousePhysic.releaseAll();
			});

		}
		
		protected function displayScore(e:GrabObjectEvent):void 
		{
			record.droppedItemsCount++;
			
			var item:DraggableObject =  e.object.GetUserData();
			var fText:FloatingText;
			if (item.isOnBalanceBoard()) {
				fText = new FloatingText(sCounter.countScore());
				checkStarCollision(item);
			}	
			else {
				fText = new FloatingText(sCounter.getFallPenaltyString(), 2, 2, RED_COLOR);
				sCounter.fallPenalty();
				item.destroyMe();
				record.missedItemsCount++;
			}
			fText.x = e.object.GetUserData().x;
			fText.y = e.object.GetUserData().y;
			addChild(fText);
			
			header.updateScore(sCounter);
	
			if (record.allItemsDropped() && stars.length > 0) delayAction(2000, levelClear);
		}
		
		protected function levelClear():void 
		{
			sCounter.sumUpScore();
			record.stageCleared();
			dispatchEvent(new GameEvent(GameEvent.STAGE_CLEAR));
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
					header.updateScore(sCounter);
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
		
		protected function dropAll(e:GrabObjectEvent):void 
		{
			objectsOnHand = new Array();
			
			rHand.stopHoldObject();
			lHand.stopHoldObject();
			rHandIsEmpty = true;
		}
		
		protected function dropAnObject(e:GrabObjectEvent):String
		{
			var whatHand:String;
			
			if (rHand.isHoldingThisObject(e.object.GetUserData())) {
				rHand.stopHoldObject();
				rHandIsEmpty = true;
				whatHand = "right";
			}
			else {
				lHand.stopHoldObject();
				whatHand = "left";
			}
			
			for (var i:int = 0; i < objectsOnHand.length; i++) 
			{
				if (objectsOnHand[i] == e.object) {
					objectsOnHand.splice(i, 1);
					break;
				}
			}
			
			return whatHand;
		}
		
		private function objectRelocated(e:GrabObjectEvent):void 
		{
			var obj:DraggableObject = e.object.GetUserData() as DraggableObject;
			if (!obj.isOnBalanceBoard()) {
				obj.destroyMe();
				
				var fText:FloatingText = new FloatingText(sCounter.getFallPenaltyString(), 2, 2, RED_COLOR);
				fText.x = obj.x;
				fText.y = obj.y;
				addChild(fText);
				
				sCounter.fallPenalty();
				header.updateScore(sCounter);
			}
			
			checkStarCollision(obj);
		}
		
		protected function grabAnObject(e:GrabObjectEvent):String
		{
			objectsOnHand.push(e.object);
			
			var whatHand:String;
			
			if (rHandIsEmpty) {
				rHandIsEmpty = false;
				rHand.startHoldObject(e.object.GetUserData());
				whatHand = "right";
			}
			else {
				lHand.startHoldObject(e.object.GetUserData());
				whatHand = "left";
			}
				
			return whatHand;
		}
		
		public function getStageRecord():StageRecord
		{
			return record;
		}
		
		protected function createBorders():void 
		{
			var bd:b2BodyDef = new b2BodyDef();
			var fd:b2FixtureDef = new b2FixtureDef();
			var borderBody:b2Body;
			var borderShape:b2PolygonShape = new b2PolygonShape();
			var borderThickness:Number = StageConfig.BORDER_THICKNESS/2;
			
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
			bd.position.Set( this.width / (2 * Main._physScale), (StageConfig.HEADER_HEIGHT + borderThickness) / Main._physScale);
			borderBody = Main.getWorld().CreateBody(bd);
			borderBody.CreateFixture(fd);
			borderList.push(borderBody);
			
			/****** ITEM BOX UPPER BORDER ***********/
			bd.position.Set( this.width / (2 * Main._physScale), (this.height - StageConfig.ITEMBOX_HEIGHT - borderThickness) / Main._physScale);
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
		
		public function destroyMe():void
		{
			removeAllListeners();
			HandManager.reset(); 
		}
		
	}

}