package stages 
{
	import assets.AssetCollection;
	import events.GameEvent;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class MainMenu extends Sprite 
	{
		private var collection:AssetCollection = new AssetCollection();
		private var asset:Sprite;
		
		public function MainMenu() 
		{
			asset = new collection.mainMenuAsset();
			addChild(asset);
			
			asset.addEventListener(MouseEvent.MOUSE_UP, startGame);
		}
		
		private function startGame(e:MouseEvent):void 
		{
			parent.dispatchEvent(new GameEvent(GameEvent.START_GAME));
		}
		
		
	}

}