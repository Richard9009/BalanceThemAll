package Resources 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	internal class LocalesManager extends EventDispatcher
	{
		public var currentLanguageCode:int = 0;
		public var localeArray:Array = new Array();
		public var englishArray:Array = new Array();
		public var chineseArray:Array = new Array();
		
		public static var instance:LocalesManager;
		
		public function LocalesManager() 
		{
			englishArray = ["greeting1=Hello", 
							"greeting2=How Are You?", 
							"swear1=What the fuck", 
							"swear2=hell no!", 
							"random=asdfgh" ];
							
			chineseArray = ["greeting1=你好", 
							"greeting2=你好嗎?", 
							"swear1=沖三洨？", 
							"swear2=吃屎啦!", 
							"random=就年米2部" ];
							
			localeArray = [englishArray, chineseArray];
			addEventListener(LocalesEvent.ON_LANGUAGE_SELECT, changeLocale);
		}
		
		private function changeLocale(e:LocalesEvent):void 
		{
			currentLanguageCode = (currentLanguageCode == 0) ? 1 : 0;
			dispatchEvent(new LocalesEvent(LocalesEvent.ON_LOCALE_CHANGE));
		}
		
		public static function getInstance():LocalesManager 
		{
			if (instance == null) instance = new LocalesManager();
			return instance;
		}
		
		public function getText(textCode:String):String
		{
			for (var i:int = 0; i < localeArray.length; i++ ) {
				if(i == currentLanguageCode) {
					var langArr:Array = localeArray[i] as Array;
					for each(var textPair:String in langArr) {
						var code:String = textPair.split("=")[0];
						var text:String = textPair.split("=")[1];
						if (code == textCode) return text;
					}
				}
			}
			
			return "Text not found";
		}
		
	}

}