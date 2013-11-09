package gameObjects
{
	import assets.AssetCollection;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import gameEvents.CueEvent;
	import general.dialogs.DialogEventHandler;
	import general.ObjectData;
	import locales.LocalesTextField;
	import managers.CueManager;
	import managers.LocalesManager;
	
	/**
	 * ...
	 * @author ...
	 */
	public class ItemPanel extends Sprite
	{
		private static const BULLET:String = "- ";
		private static const WEIGHT:String = "info.weight";
		
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
		private var isRightPanel:Boolean;
		
		public function ItemPanel(isRight:Boolean)
		{
			tFormat = new TextFormat("Arial", TEXT_SIZE, 0x000000, false);
			isRightPanel = isRight;
			panel = new collection.itemPanelAsset();
			panel.width = 180;
			panel.height = 100;
			mouseEnabled = false;
			mouseChildren = false;
			addChild(panel);
			
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}
		
		private function addedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			
			DialogEventHandler.getInstance().addEventListener(CueEvent.CUE_ITEM_PANEL, function respond():void {
				CueManager.getInstance().cueThis(new Point(x, y + height/2));
			});
			
			trace(this as DisplayObject == null);
		}
		
		private function printData():void
		{
			var R_or_L:String = (isRightPanel) ? "R: " : "L: ";
			nameTxt = new TextField();
			nameTxt.selectable = false;
			nameTxt.text = R_or_L + itemName;
			nameTxt.width = panel.width;
			var headerTF:TextFormat = new TextFormat("Arial", TEXT_SIZE, 0x000000, true);
			nameTxt.setTextFormat(headerTF);
			addChild(nameTxt);
			
			
			var weightString:String = LocalesManager.getInstance().getText(WEIGHT) + ": ";
			//weightString = weightString.substring(0, weightString.length - 2);
			
			weightTxt = new TextField();
			weightTxt.selectable = false;
			weightTxt.text = BULLET + weightString + weight;
			weightTxt.width = panel.width;
			weightTxt.setTextFormat(tFormat);
			addChild(weightTxt);
			
			infoTxt = new TextField();
			infoTxt.selectable = false;
			infoTxt.text = "";
			for each (var info:String in infoList)
			{
				infoTxt.appendText(BULLET + info + "\n");
			}
			infoTxt.width = panel.width;
			infoTxt.setTextFormat(tFormat);
			addChild(infoTxt);
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
		
		private function writeData(data:ObjectData):void
		{
			itemName = data.name;
			weight = data.weight_category;
			infoList = data.infoList;
		}
		
		public function displayData(data:ObjectData):void
		{
			writeData(data);
			printData();
			arrangeData();
		}
		
		public function get panelWidth():Number { return panel.width; }
		public function get panelHeight():Number { return panel.height; }
	}

}