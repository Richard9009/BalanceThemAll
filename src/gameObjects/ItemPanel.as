package gameObjects
{
	import assets.AssetCollection;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import locales.LocalesTextField;
	
	/**
	 * ...
	 * @author ...
	 */
	public class ItemPanel extends MovieClip
	{
		private static const BULLET:String = "- ";
		private static const WEIGHT:String = "Weight: ";
		
		private static const PADDING:Number = 8;
		private static const GAP:Number = 23;
		private static const TEXT_SIZE:Number = 15;
		
		private var panel:Sprite;
		private var collection:AssetCollection = new AssetCollection();
		
		private var nameTxt:TextField;
		private var weightTxt:TextField;
		private var infoTxt:TextField;
		private var tFormat:TextFormat;
		
		private var itemName:String;
		private var weight:String;
		private var infoList:Array = new Array();
		
		public function ItemPanel()
		{
			psuedoData();
			tFormat = new TextFormat("Arial", TEXT_SIZE, 0x000000, false);
			
			panel = new collection.itemPanelAsset();
			panel.width = 180;
			panel.height = 100;
			addChild(panel);
			
			printData();
		}
		
		private function printData():void
		{
			nameTxt = new TextField();
			nameTxt.text = itemName;
			nameTxt.width = panel.width;
			var headerTF:TextFormat = new TextFormat("Arial", TEXT_SIZE, 0x000000, true);
			nameTxt.setTextFormat(headerTF);
			addChild(nameTxt);
			
			weightTxt = new TextField();
			weightTxt.text = BULLET + WEIGHT + weight;
			weightTxt.width = panel.width;
			weightTxt.setTextFormat(tFormat);
			addChild(weightTxt);
			
			infoTxt = new TextField();
			infoTxt.text = "";
			for each (var info:String in infoList)
			{
				infoTxt.appendText(BULLET + info + "\n");
			}
			infoTxt.width = panel.width;
			infoTxt.setTextFormat(tFormat);
			addChild(infoTxt);
			
			arrangeData();
		}
		
		private function arrangeData():void 
		{
			nameTxt.x = PADDING - panel.width / 2;
			nameTxt.y = PADDING - panel.height / 2;
			
			weightTxt.x = PADDING - panel.width / 2;
			weightTxt.y = nameTxt.y + GAP;
			
			infoTxt.x = PADDING - panel.width / 2;
			infoTxt.y = weightTxt.y + GAP;
		}
		
		private function psuedoData():void
		{
			itemName = "Glass Vase";
			weight = "Very Light";
			infoList = ["Slippery", "Fragile"];
		}
		
		public function get panelWidth():Number { return panel.width; }
		public function get panelHeight():Number { return panel.height; }
	}

}