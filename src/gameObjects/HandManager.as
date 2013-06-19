package gameObjects 
{
	import gameObjects.rigidObjects.DraggableObject;
	/**
	 * ...
	 * @author ...
	 */
	public class HandManager 
	{
		private var itemsOnHands:Array = new Array();
		
		private static var instance:HandManager;
		
		public function HandManager() 
		{
			
		}
		
		public function grab(item:DraggableObject):void
		{
			itemsOnHands.push(item);
		}
		
		public function drop(item:DraggableObject):void
		{
			for (var i:int = 0; i < itemsOnHands.length; i++) {
				if (item == itemsOnHands[i]) itemsOnHands.splice(i, 1);
			}
		}
		
		public function isFull():Boolean 
		{
			return itemsOnHands.length == 2;
		}
		
		public function isEmpty():Boolean
		{
			return itemsOnHands.length == 0;
		}
		
		public function releaseAllObjectsOnHands():void
		{
			itemsOnHands = new Array();
		}
		
		public function clearToDrop():Boolean
		{
			for (var i:int = 0; i < itemsOnHands.length; i++) {
				var item:DraggableObject = itemsOnHands[i] as DraggableObject;
				if (item.isBlocked()) return false;
			}
			
			return true;
		}
		
		public static function getInstance():HandManager
		{
			if (instance == null) instance = new HandManager();
			return instance;
		}
		
		public static function reset():void
		{
			instance = new HandManager();
		}
	}

}