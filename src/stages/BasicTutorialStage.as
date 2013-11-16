package stages 
{
	import assets.AssetCollection;
	import Box2D.Common.Math.b2Vec2;
	import builders.ObjectBuilder;
	import builders.SpecialObjectBuilder;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import gameObjects.rigidObjects.DraggableObject;
	import locales.LocalesTextField;
	import managers.SoundManager;
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
		private var shoe:DraggableObject;
		private var clearFunction:Function;
		private var respondFunction:Function;
		
		public function BasicTutorialStage()
		{
			super();
			
			display = new AssetClass();
			addChild(display);
			
			var tFormat:TextFormat = new TextFormat("Hobo std", 24, 0x66CC33);
			tFormat.align = TextFormatAlign.CENTER;
			
			headerBox = new LocalesTextField("tutorial.header", tFormat);
			headerBox.width = width;
			headerBox.y = 15;
			headerBox.setTextFormat(tFormat);
			addChild(headerBox);
			
			tFormat.color = 0x660000;
			titleBox = new LocalesTextField("", tFormat);
			titleBox.width = width;
			titleBox.y = 70;
			titleBox.setTextFormat(tFormat);
			addChild(titleBox);
			
			tFormat.size = 18;
			instructionBox = new LocalesTextField("", tFormat);
			instructionBox.width = width;
			instructionBox.y = 120;
			instructionBox.setTextFormat(tFormat);
			addChild(instructionBox);
			
			tFormat.color = 0x000000;
			tFormat.size = 22;
			nextTxt = LocalesTextField.addTextToButton("tutorial.next", this, AssetClass(display).nextButton, tFormat);
			showNextButton(false);
			
			setTutorial1();
		}
		
		private function setTutorial1():void {
			shoeOutline = new SpecialObjectBuilder().createShoeOutline(700, 250);
			addChild(shoeOutline);
			
			titleBox.setLocaleText("tutorial.movingObject.title");
			instructionBox.setLocaleText("tutorial.movingObject.instruction");
			
			shoe = new ObjectBuilder().createShoes(1)[0];
			shoe.getBody().SetPosition(new b2Vec2(3, 4));
			shoe.getBody().SetActive(false);
			addChild(shoe);
			
			addEventListener(Event.ENTER_FRAME, checkStatus);
			clearFunction = shoeIsInPlace;
			respondFunction = lockShoePosition;
			
			AssetClass(display).nextButton.addEventListener(MouseEvent.MOUSE_UP, setTutorial2);
		}
		
		private function setTutorial2(e:MouseEvent):void 
		{
			AssetClass(display).nextButton.removeEventListener(MouseEvent.MOUSE_UP, setTutorial2);
			
			shoeOutline.rotation = 90;
			showNextButton(false);
			titleBox.setLocaleText("tutorial.rotateObject.title");
			instructionBox.setLocaleText("tutorial.rotateObject.instruction");
			
			addEventListener(Event.ENTER_FRAME, checkStatus);
			clearFunction = shoeRotateSuccess;
			respondFunction = lockShoeRotation;
		}
		
		private function checkStatus(e:Event):void 
		{
			if (clearFunction()) {
				respondFunction();
				showNextButton();
				SoundManager.getInstance().playSuccess();
				removeEventListener(Event.ENTER_FRAME, checkStatus);
			}
		}
		
		private function showNextButton(show:Boolean = true):void {
			AssetClass(display).nextButton.visible = show;
			nextTxt.visible = show;
		}
		
		private function shoeIsInPlace():Boolean {
			var tolerance:Number = 5;
			if (shoe.x >= shoeOutline.x - tolerance && shoe.x <= shoeOutline.x + tolerance &&
				shoe.y >= shoeOutline.y - tolerance && shoe.y <= shoeOutline.y + tolerance) {
					return true;
			}
			
			return false;
		}
		
		private function shoeRotateSuccess():Boolean {
			var tolerance:Number = 10;
			return (shoe.rotation <= shoeOutline.rotation + tolerance && shoe.rotation >= shoeOutline.rotation - tolerance);
		}
		
		private function lockShoePosition():void {
			shoe.movementLocked = true;
			shoe.getBody().SetPosition(new b2Vec2(shoeOutline.x / Main._physScale, shoeOutline.y / Main._physScale));
		}
		
		private function lockShoeRotation():void {
			shoe.rotationLocked = true;
			shoe.getBody().SetAngle(shoeOutline.rotation * Math.PI / 180);
		}
	}

}