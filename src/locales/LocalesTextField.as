package locales 
{
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class LocalesTextField extends TextField 
	{
		private var textCode:String;
		private var _textFormat:TextFormat;
		
		public function LocalesTextField(localeTextCode:String = "", textFormat:TextFormat = null) 
		{
			super();
			selectable = false;
			multiline = true;
			
			if (textFormat == null) {
				_textFormat = new TextFormat('Arial', 20, 0x000000, true);
				_textFormat.leading = 5;
			}
			else _textFormat = textFormat;
			
			if(localeTextCode != "") setLocaleText(localeTextCode);
			LocalesManager.getInstance().addEventListener(LocalesEvent.ON_LOCALE_CHANGE, updateLocale);
		}
		
		public function setLocaleText(tCode:String):void {
			textCode = tCode;
			updateLocale();
		}
		
		private function updateLocale(e:LocalesEvent = null):void {
			htmlText = LocalesManager.getInstance().getText(textCode);
			this.setTextFormat(_textFormat);
		}
		
	}

}