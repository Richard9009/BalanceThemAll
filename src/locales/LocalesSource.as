package locales 
{
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class LocalesSource 
	{
		private var defaultLocaleArray:Array;
		
		[Embed(source = "fileSource/Chinese.txt", mimeType="application/octet-stream")]
		private var chineseLocale:Class;
		private var chineseLocaleArray:Array;
		
		[Embed(source="fileSource/English.txt", mimeType="application/octet-stream")]
		private var englishLocale:Class;
		private var englishLocaleArray:Array;
		
		[Embed(source="fileSource/Indonesian.txt", mimeType="application/octet-stream")]
		private var indoLocale:Class;
		private var indoLocaleArray:Array;
		
		[Embed(source = "fileSource/Japanese.txt", mimeType = "application/octet-stream")]
		private var japanLocale:Class;
		private var japanLocaleArray:Array;
		
		private static var instance:LocalesSource;
		
		public function LocalesSource() 
		{
			englishLocaleArray = LocaleData.generateArray(englishLocale);
			chineseLocaleArray = LocaleData.generateArray(chineseLocale);
			indoLocaleArray = LocaleData.generateArray(indoLocale);
			japanLocaleArray = LocaleData.generateArray(japanLocale);
			defaultLocaleArray = englishLocaleArray;
		}
		
		public static function getInstance():LocalesSource
		{
			if (instance == null) instance = new LocalesSource();
			return instance;
		}
		
		public function getLocaleArrayByCode(localeCode:uint):Array
		{
			switch(localeCode) {
				case LocaleLanguages.ENGLISH: return englishLocaleArray;
				case LocaleLanguages.INDONESIAN: return indoLocaleArray;
				case LocaleLanguages.CHINESE: return chineseLocaleArray;
				case LocaleLanguages.JAPANESE: return japanLocaleArray;
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