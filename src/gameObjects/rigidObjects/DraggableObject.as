package gameObjects.rigidObjects 
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2Fixture;
	import flash.errors.StackOverflowError;
	import flash.events.KeyboardEvent;
	import gameEvents.GrabObjectEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import gameEvents.TutorialEvent;
	import managers.HandManager;
	import general.collisions.CollisionGenerator;
	import general.MousePhysic;
	import general.ObjectData;
	import managers.MessageManager;
	import managers.SoundManager;
	import org.flashdevelop.utils.FlashConnect;
	import stages.StageConfig;
	import stages.Tutorials.Tutorial;
	import general.dialogs.DialogEventHandler;

	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class DraggableObject extends RigidObjectBase
	{	
		public static var calculate_mass_on_me:Boolean = false;
		public static var item_box_locked:Boolean = false;
		
		protected var redLayerClass:Class;
		
		protected var minLimit:b2Vec2;
		protected var maxLimit:b2Vec2;
		
		protected var isDraggable:Boolean = true;
		protected var isRed:Boolean = false;
		protected var onHand:Boolean = false;
		protected var redLayer:Sprite = new Sprite();
		
		private var grabEvt:GrabObjectEvent;
		private var dropEvt:GrabObjectEvent;
		private var stopEvt:GrabObjectEvent;
		
		private var hand:HandManager;
		protected var objectName:String;
		
		public var objectData:ObjectData;
		public var handPosition:String = "bottom"; //bottom or side
		public var movementLocked:Boolean = false;
		public var rotationLocked:Boolean = false;
					
		public function DraggableObject(objName:String, minimumLimit:b2Vec2 = null, maximumLimit:b2Vec2 = null) 
		{
			super();
			
			objectName = objName;
			minLimit = minimumLimit;
			maxLimit = maximumLimit;
			
			hand = HandManager.getInstance();
		
			addEventListener(Event.ADDED_TO_STAGE, creationComplete);
		}
		
		private function creationComplete(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, creationComplete);
			
			stage.stageFocusRect = false;
			addEventListener(MouseEvent.MOUSE_OVER, onMouseHover);
			addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			addEventListener(Event.ENTER_FRAME, onEveryFrame);
			addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWhell);
			addEventListener(GrabObjectEvent.DROP_AN_OBJECT, dropped);
			
			addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		private function onKeyDown(e:KeyboardEvent):void 
		{
			if (MousePhysic.pointedBody != this.rigidBody || rigidBody.IsActive()) return;
			if(e.keyCode == 32 && !rotationLocked) rotateBody(3, true);
		}
		
		override public function createDisplayBody(assetClass:Class):void
		{
			super.createDisplayBody(assetClass);
			createRedLayer(assetClass);
		}
		
		override public function setSize(w:Number, h:Number, density:Number = 0.3):void 
		{
			super.setSize(w, h, density);
			handPosition = (w >= h) ? "bottom" : "side";
		}
		
		protected function createRedLayer(assetClass:Class):void
		{
			redLayer = new assetClass();
			var cTransform:ColorTransform = new ColorTransform(1, 0, 0, 0.5);
			redLayer.transform.colorTransform = cTransform;
			addChild(redLayer);
		}
		
		private function dropped(e:GrabObjectEvent):void 
		{
			addEventListener(Event.ENTER_FRAME, checkActivity);
		}
		
		private var hasBeenDropped:Boolean = false;
		private var hasBeenRelocated:Boolean = true;
		private var prevBodyBelow:b2Body;
		protected function checkActivity(e:Event):void 
		{
			if (rigidBody.GetLinearVelocity().Length() == 0 && hasBeenRelocated) {
				
				var evtType:String = (!hasBeenDropped) ? GrabObjectEvent.OBJECT_STOPS : GrabObjectEvent.OBJECT_RELOCATED;
				var evt:GrabObjectEvent = new GrabObjectEvent(evtType);
				evt.object = rigidBody;
				parent.dispatchEvent(evt);

				removeEventListener(Event.ENTER_FRAME, onEveryFrame);
				
				hasBeenDropped = true;
				hasBeenRelocated = false;
			}
			else if(rigidBody.GetLinearVelocity().Length() > 0 && calculate_mass_on_me) {
				var bodyBelow:b2Body = getBodyBelowMe();
				if (prevBodyBelow != bodyBelow) {
					if (bodyBelow != null) 
						RigidObjectBase(bodyBelow.GetUserData()).addMassOnMe(getTotalMass());
					if(prevBodyBelow != null)
						RigidObjectBase(prevBodyBelow.GetUserData()).addMassOnMe(-getTotalMass());
				}
				prevBodyBelow = bodyBelow;
			}
			if (Math.abs(rigidBody.GetLinearVelocity().Length()) > 0) hasBeenRelocated = true;
		}
		
		private function onMouseWhell(e:MouseEvent):void 
		{
			if (rigidBody.IsActive() || rotationLocked) return;
			rotateBody(5, e.delta > 0);	
		}
		
		private function rotateBody(rotationAngle:Number, clockWise:Boolean):void
		{
			var direction:int = (clockWise) ? 1 : -1;
			
			var oldAngle:Number = Math.floor(rigidBody.GetAngle() * 180 / Math.PI);
			var newAngle:Number = (oldAngle + direction * rotationAngle) % 360;
			if (newAngle < 0 ) newAngle += 360;
			
			DialogEventHandler.getInstance().dispatchEvent(new TutorialEvent(TutorialEvent.OBJECT_ROTATED));
		
			rigidBody.SetPositionAndAngle(rigidBody.GetPosition(), newAngle * Math.PI / 180);
		}
		
		private function onEveryFrame(e:Event):void 
		{
			updateItemsOnHands();
			updateRedLayer();
			
			/*if (this.hitTestPoint(MousePhysic.mousePos.x, MousePhysic.mousePos.y) && MousePhysic.pointedBody != rigidBody) {
				pointAtMe();
			}*/
			
			if (MousePhysic.pointedBody == this.rigidBody && isDraggable) 
			{
				if (MousePhysic.isDown && (!hand.isFull() || !insideItemBox())) {
				
					if (MousePhysic.isDragging == false) {
						MousePhysic.isDragging = true;
						rigidBody.SetActive(false);
						parent.setChildIndex(this, parent.numChildren - 1);
						DialogEventHandler.getInstance().dispatchEvent(new TutorialEvent(TutorialEvent.DRAG_THE_BOOK));
						startCollisionDetection();
					}
					
					if(!movementLocked) {
						this.rigidBody.SetPosition(MousePhysic.physMousePos);
						checkLimit();
					}
				}
				
				else if (MousePhysic.isDown && hand.isFull() && insideItemBox()) {
					SoundManager.getInstance().playDropFail();
					MessageManager.getInstance().displayMessage("message.handFull");
				}
			
				else if(MousePhysic.isDragging)
				{
					MousePhysic.isDragging = false;
					if (insideItemBox()) releaseObject();
					else DialogEventHandler.getInstance().dispatchEvent(new TutorialEvent(TutorialEvent.STOP_DRAG_BOOK))
				}
			}
			
			if (onHand && !MousePhysic.isHolding)
			{
				if (!hand.clearToDrop()) {
					MousePhysic.isHolding = true;
					SoundManager.getInstance().playDropFail();
					MessageManager.getInstance().displayMessage("message.noDrop.red");
				}
				else {
					SoundManager.getInstance().playDropSuccess(0.5);
					releaseObject();
					hand.drop(this);
					isDraggable = false;
					
					dropEvt = new GrabObjectEvent(GrabObjectEvent.DROP_AN_OBJECT);
					dropEvt.object = rigidBody;
					dispatchEvent(dropEvt);
					parent.dispatchEvent(new GrabObjectEvent(GrabObjectEvent.DROP_ALL_OBJECTS));
				}
			}
		}
		
		private function onMouseOut(e:MouseEvent):void 
		{
			if (MousePhysic.isDown == false && MousePhysic.isDragging == false) {
				MousePhysic.pointedBody = null;
			}
		}
		
		private function onMouseHover(e:MouseEvent):void 
		{
			pointAtMe();
		}
		
		private function pointAtMe():void 
		{
			stage.focus = this;
			DialogEventHandler.getInstance().dispatchEvent(new TutorialEvent(TutorialEvent.OBJECT_POINTED));
			if(MousePhysic.isDown == false){
				MousePhysic.pointedBody = this.rigidBody;
			}
		}
		
		private function onMouseUp(e:MouseEvent):void
		{
			addEventListener(Event.ENTER_FRAME, function nextFrame(e:Event):void {
						if (isDraggable) MousePhysic.pointedBody = rigidBody;
						removeEventListener(Event.ENTER_FRAME, nextFrame);
				}
			);
			
		}
		
		private function checkLimit():void
		{
			if (maxLimit == null || minLimit == null) return;
			
			var maxPoint:b2Vec2 = new b2Vec2(rigidBody.GetPosition().x * Main._physScale + this.width / 2, rigidBody.GetPosition().y * Main._physScale + this.height / 2);
			var minPoint:b2Vec2 = new b2Vec2(rigidBody.GetPosition().x * Main._physScale - this.width / 2, rigidBody.GetPosition().y * Main._physScale - this.height / 2);
			
			if (item_box_locked) maxLimit.y = (StageConfig.ITEMBOX_Y - StageConfig.WALL_THICKNESS);
			
			if (maxPoint.x > maxLimit.x)
			{
				rigidBody.SetPosition(new b2Vec2((maxLimit.x - width / 2) / Main._physScale, MousePhysic.physMousePos.y));
			}
			else if (minPoint.x < minLimit.x)
			{
				rigidBody.SetPosition(new b2Vec2((minLimit.x + width / 2) / Main._physScale, MousePhysic.physMousePos.y));
			}
			
			if (maxPoint.y > maxLimit.y)
			{
				rigidBody.SetPosition(new b2Vec2(MousePhysic.physMousePos.x, (maxLimit.y - height / 2) / Main._physScale));
			}
			else if (minPoint.y < minLimit.y)
			{
				rigidBody.SetPosition(new b2Vec2(MousePhysic.physMousePos.x, (minLimit.y + height / 2) / Main._physScale));
			}
		}
		
		public function insideItemBox():Boolean
		{
			return (this.y - this.height/4 > StageConfig.STAGE_HEIGHT - StageConfig.ITEMBOX_HEIGHT)
		}
		
		private function updateRedLayer():void
		{
			if (rigidBody.IsActive()) return;
			
			if (isColliding && redLayer.visible == false) redLayer.visible = true;
			else if (!isColliding && redLayer.visible == true) redLayer.visible = false;
		}
		
		private function updateItemsOnHands():void
		{
			if (onHand)
			{
				if (insideItemBox()) {
					
					DialogEventHandler.getInstance().dispatchEvent(new TutorialEvent(TutorialEvent.BACK_TO_ITEMBOX));
					onHand = false;
					
					dropEvt = new GrabObjectEvent(GrabObjectEvent.DROP_AN_OBJECT);
					dropEvt.object = rigidBody;
					parent.dispatchEvent(dropEvt);
					
					hand.drop(this);
					if (hand.isEmpty()) MousePhysic.isHolding = false;
				}
			}
			
			else
			{
				if (!insideItemBox() && isDraggable) {
					DialogEventHandler.getInstance().dispatchEvent(new TutorialEvent(TutorialEvent.GET_OUT_ITEMBOX));
					onHand = true;
					MousePhysic.isHolding = true;
					grabEvt = new GrabObjectEvent(GrabObjectEvent.GRAB_AN_OBJECT);
					grabEvt.object = rigidBody;
					parent.dispatchEvent(grabEvt);
					
					hand.grab(this);
				}
				else if (hand.isFull() && isDraggable) {
					redLayer.visible = true;
				}
				else if (redLayer.visible) {
					redLayer.visible = false;
				}
			}
		}
		
		private function releaseObject():void
		{
			MousePhysic.pointedBody = null;
			rigidBody.SetActive(true);
			stopCollisionDetection();
			onHand = false;
		}
		
		override public function stopCollisionDetection():void 
		{
			super.stopCollisionDetection();
			redLayer.visible = false;
		}
		
		public function setRandomPositionInsideItemBox():void
		{
			if (maxLimit == null || minLimit == null) return;
			
			var maxRandom:b2Vec2 = new b2Vec2(maxLimit.x - this.width/2, maxLimit.y - this.height/2);
			var minRandom:b2Vec2 = new b2Vec2(minLimit.x + this.width/2, maxLimit.y - StageConfig.ITEMBOX_HEIGHT + this.height/2);
			
			var randomX:Number = Math.floor( Math.random() * (maxRandom.x - minRandom.x) + minRandom.x );
			var randomY:Number = Math.floor( Math.random() * (maxRandom.y - minRandom.y) + minRandom.y );
			
			rigidBody.SetPosition(new b2Vec2(randomX / Main._physScale, randomY / Main._physScale));	
		}
		
		public function getBodyBelowMe():b2Body
		{
			this.y += 10;
			
			for (var bb:b2Body = Main.getWorld().GetBodyList(); bb; bb = bb.GetNext())
			{
				if (bb.GetUserData() == this) bb = bb.GetNext();
				if (bb.GetUserData() is RigidObjectBase && hitTestObject(bb.GetUserData()))
				{
					if(CollisionGenerator.isAbelowB(bb.GetUserData(), this)) {
						this.y -= 10;
						return bb;
					}
				}
			}
			this.y -= 10;
			return null;
		}
		
		public function isOnBalanceBoard():Boolean
		{
			if (getBodyBelowMe() == null) return false;
			var objectBelow:RigidObjectBase = getBodyBelowMe().GetUserData();
			if (objectBelow == this) return false;
			var onBoard:Boolean = objectBelow.isBalanceBoard;
			
			if (!onBoard && objectBelow is DraggableObject) {
				try {
					onBoard = DraggableObject(objectBelow).isOnBalanceBoard();
				} catch (e:StackOverflowError) {
					return true;
				}
			}
			
			return onBoard;
			
		}
		
		public function writeObjectData():void
		{
			objectData = new ObjectData(objectName, rigidBody.GetFixtureList());
		}
		
		public function isBlocked():Boolean { return redLayer.visible; }
		
		override public function addMassOnMe(addedMass:Number):void 
		{
			super.addMassOnMe(addedMass);
			var bodyBelow:b2Body = getBodyBelowMe();
			
			try {
				if (bodyBelow) 
					RigidObjectBase(bodyBelow.GetUserData()).addMassOnMe(addedMass);
			} catch (e:StackOverflowError) {
				return;
			}
		}
		
		override public function destroyMe():void 
		{
			super.destroyMe();
			if (onHand) hand.drop(this);
			removeEventListener(MouseEvent.MOUSE_OVER, onMouseHover);
			removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			removeEventListener(Event.ENTER_FRAME, onEveryFrame);
			removeEventListener(Event.ENTER_FRAME, checkActivity);
			removeEventListener(MouseEvent.MOUSE_WHEEL, onMouseWhell);
			removeEventListener(GrabObjectEvent.DROP_AN_OBJECT, dropped);
		}
	}

}