package stages 
{
	import assets.AssetCollection;
	import builders.SpecialObjectBuilder;
	import flash.display.Sprite;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import locales.LocalesTextField;
	/**
	 * ...
	 * @author Herichard
	 */
	public class BasicTutorialStage extends StageEngine
	{
		private var assetCol:AssetCollection = new AssetCollection();
		private var titleBox:LocalesTextField;
		private var instructionBox:LocalesTextField;
		private var headerBox:LocalesTextField;
		private var AssetClass:Class = assetCol.stageTutorialAsset;
		private var display:Sprite;
		private var nextTxt:LocalesTextField;
		private var shoeOutline:Sprite;
		
		public function BasicTutorialStage()
		{
			super();
			
			display = new AssetClass();
			addChild(display);
			
			var tFormat:TextFormat = new TextFormat("Hobo std", 24, 0x66CC33);
			tFormat.align = TextFormatAlign.CENTER;
			
			headerBox = new LocalesTextField("", tFormat);
			headerBox.width = width;
			headerBox.y = 15;
			headerBox.text = "TUTORIAL";
			headerBox.setTextFormat(tFormat);
			addChild(headerBox);
			
			tFormat.color = 0x660000;
			titleBox = new LocalesTextField("", tFormat);
			titleBox.width = width;
			titleBox.y = 70;
			titleBox.text = "TITLE";
			titleBox.setTextFormat(tFormat);
			addChild(titleBox);
			
			tFormat.size = 18;
			instructionBox = new LocalesTextField("", tFormat);
			instructionBox.width = width;
			instructionBox.y = 120;
			instructionBox.text = "THIS IS AN INSTRUCTION AND SOMETIMES IT'S GONNA BE VERY LONG LIKE THIS";
			instructionBox.setTextFormat(tFormat);
			addChild(instructionBox);
			
			tFormat.color = 0x000000;
			tFormat.size = 22;
			nextTxt = LocalesTextField.addTextToButton("tutorial.next", this, AssetClass(display).nextButton, tFormat);
			showNextButton(false);
			
			setTutorial1();
		}
		
		public function setTutorial1():void {
			shoeOutline = new SpecialObjectBuilder().createShoeOutline(700, 250);
			addChild(shoeOutline);
		}
		
		private function showNextButton(show:Boolean = true):void {
			AssetClass(display).nextButton.visible = show;
			nextTxt.visible = show;
		}
		
	}

}