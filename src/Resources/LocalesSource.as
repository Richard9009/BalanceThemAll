package Resources 
{
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class LocalesSource 
	{
		private var defaultLocaleArray:Array;
		
		[Embed(source = "Chinese.txt", mimeType="application/octet-stream")]
		private var chineseLocale:Class;
		private var chineseLocaleArray:Array;
		
		[Embed(source="English.txt", mimeType="application/octet-stream")]
		private var englishLocale:Class;
		private var englishLocaleArray:Array;
		
		private static var instance:LocalesSource;
		
		public function LocalesSource() 
		{
			englishLocaleArray = LocaleData.generateArray(englishLocale);
			chineseLocaleArray = LocaleData.generateArray(chineseLocale);
			defaultLocaleArray = englishLocaleArray;
		}
		
		public static function getInstance():LocalesSource
		{
			if (instance == null) instance = new LocalesSource();
			return instance;
		}
		
		public function getLocaleArrayByCode(localeCode:int):Array
		{
			switch(localeCode) {
				case 0: return englishLocaleArray;
				case 1: return chineseLocaleArray;
				default: return defaultLocaleArray;
			}
		}
		
	}

}
import flash.utils.ByteArray;

class LocaleData {
	private static var _class:Class;
	private static var _string:String;
	private static var _array:Array;
	
	public static function generateArray(localeClass:Class):Array {
		_class = localeClass;
		_string = (new _class() as ByteArray).toString();
		_array = _string.split("\n");
		return _array;
	}
}