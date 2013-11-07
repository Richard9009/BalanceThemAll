package locales 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import managers.LocalesManager;
	
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class LocalesTextField extends TextField 
	{
		private static const MARGIN_R:Number = 10;
		private static const MARGIN_L:Number = 10;
		private static const MARGIN_UP:Number = 5;
		private static const MARGIN_LOW:Number = 5;
		
		private var textCode:String;
		private var _textFormat:TextFormat;
		
		public function LocalesTextField(localeTextCode:String = "", textFormat:TextFormat = null) 
		{
			super();
			selectable = false;
			multiline = true;
			mouseEnabled = false;
			
			if (textFormat == null) {
				_textFormat = new TextFormat('Hobo Std', 20, 0x000000);
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
		
		public static function addTextToButton(textCode:String, tParent:Sprite, btn:DisplayObject, tFormat:TextFormat):LocalesTextField
		{
			var tField:LocalesTextField = new LocalesTextField(textCode, tFormat);
			tField.width = btn.width - MARGIN_L - MARGIN_R;
			tField.height = btn.height - MARGIN_UP - MARGIN_LOW;
			tField.x = btn.x - btn.width/2 + MARGIN_L;
			tField.y = btn.y - Number(tFormat.size) * tField.numLines / 2 + MARGIN_UP;
			tParent.addChild(tField);
			return tField
		}
	}

}