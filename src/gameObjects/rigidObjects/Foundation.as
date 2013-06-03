package gameObjects.rigidObjects 
{
	import assets.AssetCollection;
	import flash.display.Sprite;
	import resources.DashedLine;
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class Foundation extends RigidObjectBase 
	{
		private var collection:AssetCollection = new AssetCollection();
		private var balance:DashedLine;
		
		public function Foundation() 
		{
			super();
		}
		
		public function showBalancePoint():void
		{
			var lineLength:Number = 440;
			balance = new DashedLine(2,0x333333,new Array(5, 8));
			
			balance.moveTo(x - 20, y - 70);
			balance.lineTo(x - 20, y - lineLength);
			parent.addChild(balance);
		}
		
		public function clearBalancePoint():void
		{
			if(balance) {
				balance.graphics.clear();
				parent.removeChild(balance);
			}
		}
		
	}

}