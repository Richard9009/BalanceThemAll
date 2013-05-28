package stages 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import locales.LocalesTextField;
	import org.flashdevelop.utils.FlashConnect;
	
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class Tutorial extends DialogBox 
	{
		private const TFIELD_GAP:int = 35;
		private var tField:LocalesTextField;
		
		public function Tutorial() 
		{
			addEventListener(Event.ADDED_TO_STAGE, creationComplete);
		}
		
		private function creationComplete(e:Event):void 
		{
			x = StageBaseClass.STAGE_WIDTH / 2;
			y = StageBaseClass.STAGE_HEIGHT - height / 2;
			
			tField = new LocalesTextField("greeting1");
			addChild(tField);
			tField.x = -width / 2 + TFIELD_GAP;
			tField.y = -height / 2 + TFIELD_GAP;
			tField.width = width - TFIELD_GAP * 2;
			tField.height = height - TFIELD_GAP * 2;
			
		}
		
	}

}