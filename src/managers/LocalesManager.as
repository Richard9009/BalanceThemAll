package managers 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import locales.LocalesEvent;
	import locales.LocalesSource;
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class LocalesManager extends EventDispatcher
	{		
		public var currentLanguageCode:int = 0;
		public var localeArray:Array = new Array();
		public var englishArray:Array = new Array();
		public var chineseArray:Array = new Array();
		
		public static var instance:LocalesManager;
		
		public function LocalesManager() 
		{							
			localeArray = LocalesSource.getInstance().getLocaleArrayByCode(currentLanguageCode);
			addEventListener(LocalesEvent.ON_LANGUAGE_SELECT, changeLocale);
		}
		
		private function changeLocale(e:LocalesEvent):void 
		{
			currentLanguageCode = (currentLanguageCode == 0) ? 1 : 0;
			localeArray = LocalesSource.getInstance().getLocaleArrayByCode(currentLanguageCode);
			dispatchEvent(new LocalesEvent(LocalesEvent.ON_LOCALE_CHANGE)); 
		}
		
		public static function getInstance():LocalesManager 
		{
			if (instance == null) instance = new LocalesManager();
			return instance;
		}
		
		public function getText(textCode:String):String
		{
			for each(var textPair:String in localeArray) {
				var code:String = textPair.split(" = ")[0];
				var text:String = textPair.split(" = ")[1];
				if (code == textCode) return text;
			
			}

			return "Text not found";
		}
		
		
	}

}