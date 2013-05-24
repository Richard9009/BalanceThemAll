package Resources 
{
	import assets.AssetCollection;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class LocaleTestMainClass extends Sprite 
	{
		private var tField:LocalesTextField;
		private var btn:Sprite;
		
		public function LocaleTestMainClass() 
		{	
			tField = new LocalesTextField('longSentence');
			tField.x = 300;
			tField.y = 300;
			addChild(tField);
			btn = new (new AssetCollection()).basketBallAsset();
			btn.x = 100;
			btn.y = 100;
			addChild(btn);
			btn.addEventListener(MouseEvent.CLICK, onClick);
			
		}
		
		private function onClick(e:MouseEvent):void 
		{
			LocalesManager.getInstance().dispatchEvent(new LocalesEvent(LocalesEvent.ON_LANGUAGE_SELECT));
		}
		
	}

}