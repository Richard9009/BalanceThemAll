package gameObjects 
{
	import assets.AssetCollection;
	import Box2D.Common.Math.b2Vec2;
	import flash.display.Sprite;
	import flash.events.Event;
	import gameObjects.rigidObjects.DraggableObject;
	
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class Hand extends Sprite 
	{
		private var collection:AssetCollection = new AssetCollection();
		private var asset:Sprite;
		private var rightHand:Boolean;
		private var itemOnHand:DraggableObject;
		
		private var localTrans:b2Vec2 = new b2Vec2();
		private var localRot:Number = 0;
		
		public function Hand(isRightHand:Boolean = true) 
		{
			rightHand = isRightHand;
			if (isRightHand) asset = new collection.rightHandAsset();
			else asset = new collection.leftHandAsset();
			addChild(asset);
			
			this.visible = false;
			this.width *= 0.5;
			this.height *= 0.5;
			
			this.mouseEnabled = false;
			this.mouseChildren = false;
			this.alpha = 0.7;
		}
		
		public function startHoldObject(item:DraggableObject):void
		{
			itemOnHand = item;
			visible = true;
			addEventListener(Event.ENTER_FRAME, enterFrame);
			parent.setChildIndex(this, parent.numChildren - 1);
		}
		
		public function stopHoldObject():void
		{
			itemOnHand = null;
			visible = false;
			removeEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		public function isHoldingThisObject(item:Sprite):Boolean {
			return (item == itemOnHand);
		}
		
		private function enterFrame(e:Event):void 
		{
			setLocalWorld();
			moveToLocalWorld(getOriginalSize());
			rotateToLocalWorld();
			backToGlobalWorld();
		}
		
		private function setLocalWorld():void
		{
			localTrans.x = -itemOnHand.x;
			localTrans.y = -itemOnHand.y;
			localRot = itemOnHand.rotation * Math.PI / 180;
		}
		
		private function getOriginalSize():b2Vec2
		{
			var rot:Number = itemOnHand.rotation;
			itemOnHand.rotation = 0;
			var sizeVec:b2Vec2 = new b2Vec2();
			sizeVec.x = itemOnHand.width;
			sizeVec.y = itemOnHand.height;
			itemOnHand.rotation = rot;
			
			return sizeVec;
		}
		
		private function moveToLocalWorld(sizeVec:b2Vec2):void
		{
			if (itemOnHand.handPosition == "bottom") {
				x = 0;
				y = sizeVec.y / 2;
				rotation = itemOnHand.rotation;
			}
			else {
				y = 0;
				x = sizeVec.x / 2 * (rightHand ? 1 : -1);
				rotation = itemOnHand.rotation + (rightHand ? -90 : 90);
			}
		}
		
		private function rotateToLocalWorld():void
		{
			var rotatedPos:b2Vec2 = new b2Vec2();
			rotatedPos.x = x * Math.cos(localRot) - y * Math.sin(localRot);
			rotatedPos.y = x * Math.sin(localRot) + y * Math.cos(localRot);
			
			x = rotatedPos.x;
			y = rotatedPos.y;
		}
		
		private function backToGlobalWorld():void
		{
			x -= localTrans.x;
			y -= localTrans.y;
		}
	}

}