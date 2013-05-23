package Resources 
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
		private var defaultTextFormat:TextFormat;
		
		public function LocalesTextField(localeTextCode:String, textFormat:TextFormat = null) 
		{
			super();
			
			if (textFormat == null) defaultTextFormat = new TextFormat('Arial', 20, 0x000000, true);
			else defaultTextFormat = textFormat;
			
			setLocaleText(localeTextCode);
			LocalesManager.getInstance().addEventListener(LocalesEvent.ON_LOCALE_CHANGE, updateLocale);
		}
		
		public function setLocaleText(tCode:String):void {
			textCode = tCode;
			updateLocale();
		}
		
		private function updateLocale(e:LocalesEvent = null):void {
			text = LocalesManager.getInstance().getText(textCode);
			this.setTextFormat(defaultTextFormat);
		}
		
	}

}