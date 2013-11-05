package general 
{
	import Box2D.Dynamics.b2Fixture;
	import locales.LocalesManager;
	/**
	 * ...
	 * @author ...
	 */
	public class ObjectData 
	{
		private static const SLIPPERY:String = "info.slippery";
		private static const BOUNCY:String = "info.bouncy";
		private static const STICKY:String = "info.sticky";
		private static const FRAGILE:String = "info.fragile";
		private static const WEIGHT_LIST:Array = ["info.vLight", "info.light", "info.normal", "info.heavy", "info.vHeavy", "info.heaviest"];
		
		
		private var _name:String;
		private var _weight_category:String;
		private var _infoList:Array;
		
		private var weight_category_divider:Number = 0.5;
		private var slippery_threshold:Number = 0.3;
		private var bouncy_threshold:Number = 0.5;
		private var sticky_threshold:Number = 0.8;
		
		public function ObjectData(objName:String, fixture:b2Fixture, breakable:Boolean = false) 
		{
			_name = LocalesManager.getInstance().getText(objName);
			
			var weightIndex:int = Math.floor(fixture.GetBody().GetMass() / weight_category_divider);
			if (weightIndex >= WEIGHT_LIST.length) weightIndex = WEIGHT_LIST.length - 1;
			_weight_category = LocalesManager.getInstance().getText(WEIGHT_LIST[weightIndex]);
			
			_infoList = new Array();
			if (fixture.GetFriction() < slippery_threshold) _infoList.push(LocalesManager.getInstance().getText(SLIPPERY));
			if (fixture.GetFriction() > sticky_threshold) _infoList.push(LocalesManager.getInstance().getText(STICKY));
			if (fixture.GetRestitution() > bouncy_threshold) _infoList.push(LocalesManager.getInstance().getText(BOUNCY));
			if (breakable) _infoList.push(LocalesManager.getInstance().getText(FRAGILE));
		}
		
		public function get name():String { return _name; }
		public function get weight_category():String { return _weight_category; }
		public function get infoList():Array { return _infoList; }
	}

}