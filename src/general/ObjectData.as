package general 
{
	import Box2D.Dynamics.b2Fixture;
	/**
	 * ...
	 * @author ...
	 */
	public class ObjectData 
	{
		private static const SLIPPERY:String = "Slippery";
		private static const BOUNCY:String = "Bouncy";
		private static const FRAGILE:String = "Fragile";
		private static const WEIGHT_LIST:Array = ["Very Light", "Light", "Normal", "Heavy", "Very Heavy"];
		
		
		private var _name:String;
		private var _weight_category:String;
		private var _infoList:Array;
		
		private var weight_category_divider:Number = 0.5;
		private var slippery_threshold:Number = 0.3;
		private var bouncy_threshold:Number = 0.5;
		
		public function ObjectData(objName:String, fixture:b2Fixture, breakable:Boolean = false) 
		{
			_name = objName;
			
			var weightIndex:int = Math.floor(fixture.GetBody().GetMass() / weight_category_divider);
			if (weightIndex >= WEIGHT_LIST.length) weightIndex = WEIGHT_LIST.length - 1;
			_weight_category = WEIGHT_LIST[weightIndex];
			
			_infoList = new Array();
			if (fixture.GetFriction() < slippery_threshold) _infoList.push(SLIPPERY);
			if (fixture.GetRestitution() < bouncy_threshold) _infoList.push(BOUNCY);
			if (breakable) _infoList.push(FRAGILE);
		}
		
		public function get name():String { return _name; }
		public function get weight_category():String { return _weight_category; }
		public function get infoList():Array { return _infoList; }
	}

}