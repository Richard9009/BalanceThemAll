package stages 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.utils.Timer;
	import gameEvents.GameEvent;
	import locales.LocalesTextField;
	/**
	 * ...
	 * @author ...
	 */
	public class Opening extends OpeningScreen_Movie 
	{
		public static const TIME_PER_SCENE:int = 6000;
		private var sceneNum:int = 1;
		private var timer:Timer;
		private var tField:LocalesTextField;
		
		public function Opening() 
		{
			super();
			
			timer = new Timer(TIME_PER_SCENE);
			timer.addEventListener(TimerEvent.TIMER, blackFadeOut);
			timer.start();
			
			var tFormat:TextFormat = new TextFormat("Nueva Std", 20, 0xFFFF33);
			tFormat.align = TextFormatAlign.CENTER;
			
			tField = new LocalesTextField("", tFormat);
			tField.x = 15;
			tField.y = StageConfig.STAGE_HEIGHT - 75;
			tField.width = StageConfig.STAGE_WIDTH - 50;
			tField.height = 50;
			addChild(tField);
			tField.setLocaleText(getTextCode());
			
			addEventListener(MouseEvent.CLICK, handleClick);
		}
		
		private function handleClick(e:MouseEvent):void {
			timer.reset();
			changeScene(null);
		}
		
		private function blackFadeOut(e:TimerEvent):void {
			timer.stop();
			var black:BlackLayer_Movie = new BlackLayer_Movie();
			black.fadeOut(0.02);
			addEventListener("FADE COMPLETE", changeScene);
			addChild(black);
		}
		
		private function changeScene(e:Event):void {
			sceneNum++;
			if (sceneNum > totalFrames) {
				removeEventListener("FADE COMPLETE", changeScene);
				parent.dispatchEvent(new GameEvent(GameEvent.OPENING_COMPLETE));
			} else {
				gotoAndStop(sceneNum);
				tField.setLocaleText(getTextCode());
				setChildIndex(tField, numChildren - 1);
				timer.start();
			}
		}
		
		private function getTextCode():String {
			switch(sceneNum) {
				case 1: return "opening.first"; break;
				case 2: return "opening.second"; break;
				case 3: return "opening.third"; break;
				case 4: return "opening.fourth"; break;
			}
			
			return null;
		}
	}

}