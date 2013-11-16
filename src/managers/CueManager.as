package managers 
{
	import assets.AssetCollection;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	import gameEvents.CueEvent;
	import general.dialogs.DialogEventHandler;
	/**
	 * ...
	 * @author Herichard
	 */
	public class CueManager 
	{
		public static const ARROW:String = "ARROW";
		public static const BELOW:String = "BELOW";
		
		private static var instance:CueManager;
		
		private var stage:Sprite;
		private var collection:AssetCollection = new AssetCollection();
		private var cuesContainer:Sprite;
		
		public function CueManager(pass:SingletonEnforcer) 
		{
			if (pass == null) throw new Error("instantiation failed");
		
			cuesContainer = new Sprite();
		}
		
		public function cueThis(cuePosition:Point, type:String = ARROW):void
		{
			var newCue:Sprite;
			var position:String;
			
			switch(type) {
				case ARROW: newCue = new collection.arrowAsset() as Sprite; 
							newCue.width = 40;
							newCue.height = 60;
							newCue.x = cuePosition.x
							newCue.y = cuePosition.y;  
							break;
			}
			
			/*switch(position) {
				case BELOW: newCue.x = obj.x;
							newCue.y = obj.y + obj.height / 2; break;
			}*/
					
			cuesContainer.addChild(newCue);
			DialogEventHandler.getInstance().addEventListener(CueEvent.REMOVE_ALL, removeAllCues);
		}
		
		public function setStage(stg:Sprite):void
		{
			stage = stg;
			stage.addChildAt(cuesContainer, stage.numChildren - 1);
		}
		
		public function removeAllCues(e:CueEvent = null):void
		{
			while (cuesContainer.numChildren > 0) {
				cuesContainer.removeChildAt(0);
			}
		}
		
		public function destroyStage():void
		{
			if (stage == null) return;
			
			removeAllCues();
			stage.removeChild(cuesContainer);
			stage = null;
		}
		
		public static function getInstance():CueManager
		{
			if (!instance) instance = new CueManager(new SingletonEnforcer());
			return instance
		}
		
	}

}

class SingletonEnforcer { }