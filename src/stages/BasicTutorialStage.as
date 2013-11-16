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
	import gameEvents.GameEvent;
	import gameEvents.GrabObjectEvent;
	import gameObjects.rigidObjects.DraggableObject;
	import gameObjects.rigidObjects.RigidObjectBase;
	import gameObjects.StarObject;
	import general.StageRecord;
	import locales.LocalesTextField;
	import managers.LocalesManager;
	import managers.SoundManager;
	import stages.Tutorials.Tutorial;
	/**
	 * ...
	 * @author Herichard
	 */
	public class BasicTutorialStage extends StageEngine
	{
		private var assetCol:AssetCollection = new AssetCollection();
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
			
			Tutorial.tutorialOn = true;
			
			display = new AssetClass();
			addChildAt(display, 0);
			
			var tFormat:TextFormat = new TextFormat(LocalesManager.getInstance().getFontFamily(), 24, 0x66CC33);
			tFormat.align = TextFormatAlign.CENTER;
			
			headerBox = new LocalesTextField("tutorial.header", tFormat);
			headerBox.width = width;
			headerBox.y = 15;
			headerBox.setTextFormat(tFormat);
			addChild(headerBox);
			
			var tFormat2:TextFormat = new TextFormat(LocalesManager.getInstance().getFontFamily(), 18, 0xCCCC33);
			tFormat2.align = TextFormatAlign.CENTER;
			instructionBox = new LocalesTextField("", tFormat2);
			instructionBox.width = width;
			instructionBox.y = 125;
			instructionBox.setTextFormat(tFormat);
			addChild(instructionBox);
			
			tFormat.color = 0x000000;
			tFormat.size = 22;
			nextTxt = LocalesTextField.addTextToButton("tutorial.next", this, AssetClass(display).nextButton, tFormat);
			showNextButton(false);
			
			record = StageRecord.getStageRecordByID("tutorial");
			record.stageStarted();
			removeChild(header);
			
			setTutorial1();
		}
		
		private function setTutorial1():void {
			shoeOutline = new SpecialObjectBuilder().createShoeOutline(500, 250);
			addChild(shoeOutline);
			
			instructionBox.setLocaleText("tutorial.movingObject");
			
			shoe = new ObjectBuilder().createShoes(1)[0];
			shoe.getBody().SetPosition(new b2Vec2(3, 9));
			shoe.getBody().SetActive(false);
			addChild(shoe);
			record.registerItem(shoe);
			
			DraggableObject.item_box_locked = true;
			dropBtn.visible = false;
			dropTxt.visible = false;
			
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
			instructionBox.setLocaleText("tutorial.rotateObject");
			
			addEventListener(Event.ENTER_FRAME, checkStatus);
			clearFunction = shoeRotateSuccess;
			respondFunction = lockShoeRotation;
			
			AssetClass(display).nextButton.addEventListener(MouseEvent.MOUSE_UP, setTutorial3);
		}
		
		private function setTutorial3(e:MouseEvent):void
		{
			AssetClass(display).nextButton.removeEventListener(MouseEvent.MOUSE_UP, setTutorial3);
			
			showNextButton(false);
			dropBtn.visible = true;
			dropTxt.visible = true;
			instructionBox.setLocaleText("tutorial.dropObject");
			
			var platform:RigidObjectBase = new SpecialObjectBuilder(0.8).createMicrowave(0, 0, false);
			platform.isBalanceBoard = true;
			addChild(platform);
			var platformPos:b2Vec2 = new b2Vec2(shoeOutline.x, StageConfig.ITEMBOX_Y - StageConfig.WALL_THICKNESS - platform.height / 3);
			platform.setPosition(platformPos.x, platformPos.y);
			
			removeChild(shoeOutline);
			
			addEventListener(Event.ENTER_FRAME, checkStatus);
			clearFunction = shoe.isOnBalanceBoard;
			respondFunction = null;
			
			AssetClass(display).nextButton.addEventListener(MouseEvent.MOUSE_UP, setTutorial4);
		}
		
		private var book:DraggableObject;
		private var star:StarObject;
		private function setTutorial4(e:MouseEvent):void 
		{
			AssetClass(display).nextButton.removeEventListener(MouseEvent.MOUSE_UP, setTutorial4);
			showNextButton(false);
			
			star = new SpecialObjectBuilder().createGoldenStar(shoe.x, shoe.y - shoe.height / 2 - 40);
			addChild(star);
			stars.push(star);
			instructionBox.setLocaleText("tutorial.getStar");
			
			book = new ObjectBuilder().createEncyclopedia(1)[0];
			book.setPosition(shoe.x - 10, star.y - 70);
			addChild(book);
			book.getBody().SetActive(false);
			record.registerItem(book);
			book.movementLocked = true;
			book.rotationLocked = true;
			
			addEventListener(Event.ENTER_FRAME, checkStatus);
			clearFunction = gotTheStar;
			respondFunction = finishTutorial;
		}
		
		private function checkStatus(e:Event):void 
		{
			if (clearFunction()) {
				if(respondFunction != null) respondFunction();
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
		
		private function finishTutorial():void {
			nextTxt.setLocaleText("tutorial.play");
			instructionBox.setLocaleText("tutorial.final");
			DraggableObject.item_box_locked = false;
			
			AssetClass(display).nextButton.addEventListener(MouseEvent.MOUSE_UP, closeTutorial);
		}
		
		private function closeTutorial(e:MouseEvent):void 
		{
			dispatchEvent(new GameEvent(GameEvent.BASIC_TUTORIAL_COMPLETE));
		}
		
		private function gotTheStar():Boolean {
			if (book == null || star == null) return false;
			
			if (book.getBody().GetLinearVelocity().Length() == 0 && star.hitTestObject(book)) {
				return true;
			}
			
			return false;
		}
		
		override protected function displayScore(e:GrabObjectEvent):void 
		{
			//super.displayScore(e);
			if(star != null) checkStarCollision(e.object.GetUserData());
		}
		
		override protected function checkStarCollision(item:Sprite):void 
		{
			//super.checkStarCollision(item);
			if (star.hitTestObject(book)) {
				star.startFadeOut();
			}
		}
	}

}