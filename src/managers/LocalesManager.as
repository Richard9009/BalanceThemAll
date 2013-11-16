package managers 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import locales.LocaleLanguages;
	import locales.LocalesEvent;
	import locales.LocalesSource;
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class LocalesManager extends EventDispatcher
	{		
		public var currentLanguageCode:uint = 0;
		public var localeArray:Array = new Array();
		public var englishArray:Array = new Array();
		public var chineseArray:Array = new Array();
		
		public static var instance:LocalesManager;
		
		public function LocalesManager() 
		{							
			localeArray = LocalesSource.getInstance().getLocaleArrayByCode(currentLanguageCode);
		}
		
		public function changeLocaleTo(language:uint):void
		{
			currentLanguageCode = language;
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
			
			if (currentLanguageCode == LocaleLanguages.JAPANESE && textCode == "stage1_4.success") {
				//for some unknown reason, this one particular text can't be found in japanese
				return "やっぱり、君なら出来る!";
			}

			return "Text not found";
		}
		
		public function getFontFamily():String
		{
			switch(currentLanguageCode) {
				case LocaleLanguages.INDONESIAN:
				case LocaleLanguages.ENGLISH: return "Hobo std";
				
				case LocaleLanguages.CHINESE:
				case LocaleLanguages.JAPANESE: return "Meiryo UI";
				
				default: return "Arial";
			}
		}
		
		
	}

}