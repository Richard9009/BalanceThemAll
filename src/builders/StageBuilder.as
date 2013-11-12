package builders 
{
	import flash.display.Sprite;
	import gameObjects.rigidObjects.DraggableObject;
	import gameObjects.rigidObjects.GravityBlock;
	import gameObjects.rigidObjects.RigidObjectBase;
	import managers.MusicManager;
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class StageBuilder 
	{
		
		private var stage:Sprite;
		private var liftablesContainer:Sprite;
		private var othersContainer:Sprite;
		private var stars:Array;
		
		protected var liftables:Array;
		protected var others:Array;
		protected var itemBuilder:ObjectBuilder = new ObjectBuilder();
		protected var specialBuilder:SpecialObjectBuilder = new SpecialObjectBuilder();
		
		public function StageBuilder() 
		{
			stage = new Sprite();
			liftablesContainer = new Sprite();
			othersContainer = new Sprite();
			stars = new Array();
			others = new Array();
			liftables = new Array(); 
		}
		
//==============================================================STAGE 1============================================================
		
		protected function stage1(subStageIndex:int):void
		{
			var hardMode:Boolean = subStageIndex > 4;
			
			if (!hardMode) MusicManager.getInstance().playStage1FirstHalfBGM();
			else MusicManager.getInstance().playStage1SecondHalfBGM(); 
			
			others.push(specialBuilder.createBroom(380, 395, hardMode ? 550 : 500));
			others.push(specialBuilder.createMicrowave(380, 420, hardMode));
		}
		
		private function stage1_1():void
		{
			liftables.push(itemBuilder.createEncyclopedia(2));
			
			stars.push(specialBuilder.createGoldenStar(150, 350));
			stars.push(specialBuilder.createSilverStar(600, 350));
		}
		
		private function stage1_2():void {
			liftables.push(itemBuilder.createBlueBook(1));
			liftables.push(itemBuilder.createEncyclopedia(1));
			
			stars.push(specialBuilder.createGoldenStar(300, 350));
			stars.push(specialBuilder.createSilverStar(600, 350));
		}
		
		private function stage1_3():void {
			liftables.push(itemBuilder.createShoes(1));
			liftables.push(itemBuilder.createEncyclopedia(1));
			var book:RigidObjectBase = RigidObjectBase(liftables[1][0]);
			book.getBody().SetAngle(90); 
			
			stars.push(specialBuilder.createGoldenStar(150, 290));
			stars.push(specialBuilder.createSilverStar(450, 290));
		}
		
		private function stage1_4():void {
			liftables.push(itemBuilder.createBlueBook(1));
			liftables.push(itemBuilder.createShoes(2));
			liftables.push(itemBuilder.createEncyclopedia(1));
			
			stars.push(specialBuilder.createGoldenStar(150, 250));
			stars.push(specialBuilder.createSilverStar(550, 250));
		}
		
		private function stage1_5():void {
			liftables.push(itemBuilder.createPhoto(3));
			liftables.push(itemBuilder.createEncyclopedia(1));
			liftables.push(itemBuilder.createShoes(1));
			
			stars.push(specialBuilder.createGoldenStar(150, 170));
			stars.push(specialBuilder.createSilverStar(550, 220));
		}
		
//=====================================================STAGE 2========================================================================

		protected function stage2(substageIndex:int):void
		{
			others.push(specialBuilder.createBookStack(380, 410));
			others.push(specialBuilder.createBaseballBat(390, 365));
			
			if (substageIndex < 3) MusicManager.getInstance().playStage2FirstHalfBGM();
			else MusicManager.getInstance().playStage2SecondHalfBGM(); 
		}
		
		private function stage2_1():void
		{
			liftables.push(itemBuilder.createPillow(1));
			liftables.push(itemBuilder.createHeavyObject(1));
			
			stars.push(specialBuilder.createGoldenStar(510, 365));
			stars.push(specialBuilder.createSilverStar(100, 340));
		}

		private function stage2_2():void
		{
			liftables.push(itemBuilder.createPillow(1));
			liftables.push(itemBuilder.createMug(1));
			liftables.push(itemBuilder.createGlassVase(1));
			
			stars.push(specialBuilder.createGoldenStar(550, 185));
			stars.push(specialBuilder.createSilverStar(550, 265));
		}
		
		private function stage2_3():void
		{
			liftables.push(itemBuilder.createPhoto(1));
			liftables.push(itemBuilder.createHeavyObject(1));
			liftables.push(itemBuilder.createBlueBook(1));
			
			stars.push(specialBuilder.createGoldenStar(110, 210));
			stars.push(specialBuilder.createSilverStar(550, 268));
		}
		
		private function stage2_4():void
		{
			liftables.push(itemBuilder.createHeavyObject(1));
			liftables.push(itemBuilder.createPillow(1));
			liftables.push(itemBuilder.createPhoto(1));
			
			stars.push(specialBuilder.createGoldenStar(50, 130));
			stars.push(specialBuilder.createSilverStar(570, 400));
		}
		
		private function stage2_5():void
		{
			liftables.push(itemBuilder.createHeavyObject(1));
			liftables.push(itemBuilder.createBowlingBall(1));
			liftables.push(itemBuilder.createTennisBall(1));
			liftables.push(itemBuilder.createBasketBall(1));
			
			stars.push(specialBuilder.createSilverStar(40, 280));
			stars.push(specialBuilder.createGoldenStar(550, 390));
		}
		
//=====================================================STAGE 3========================================================================
		protected function stage3(substageIndex:int):void
		{
			var hardMode:Boolean = (substageIndex > 3);
			
			if (hardMode) {
				others.push(specialBuilder.createSnowPile(250, 415));
				others.push(specialBuilder.createIceBeam(250, 408, true));
				others.push(specialBuilder.createSnowPile(550, 360, true));
				others.push(specialBuilder.createIceBeam(550, 350, true));
			} else {
				others.push(specialBuilder.createSnowPile(380, 415));
				others.push(specialBuilder.createIceBeam(380, 408));
			}
			
			if (substageIndex < 4) MusicManager.getInstance().playStage3FirstHalfBGM();
			else MusicManager.getInstance().playStage3SecondHalfBGM();
		}
		
		private function stage3_1():void
		{
			liftables.push(itemBuilder.createFrozenFish(2));
			liftables.push(itemBuilder.createFrozenTomato(2));
			liftables.push(itemBuilder.createFragileIce(1));
			
			stars.push(specialBuilder.createSilverStar(120, 200));
			stars.push(specialBuilder.createBronzeStar(640, 280));
			stars.push(specialBuilder.createGoldenStar(380, 312));
		}
		
		private function stage3_2():void
		{
			liftables.push(itemBuilder.createFrozenFish(1));
			liftables.push(itemBuilder.createPenguin(2));
			liftables.push(itemBuilder.createFragileIce(1));
			
			stars.push(specialBuilder.createBronzeStar(325, 340));
			stars.push(specialBuilder.createSilverStar(420, 233));
			stars.push(specialBuilder.createGoldenStar(357, 149));
		}
		
		private function stage3_3():void
		{
			liftables.push(itemBuilder.createFrozenFish(1));
			liftables.push(itemBuilder.createPenguin(2));
			
			stars.push(specialBuilder.createGoldenStar(200, 230));
			stars.push(specialBuilder.createSilverStar(536, 348));
			stars.push(specialBuilder.createBronzeStar(662, 412));
		}
		
		private function stage3_4():void
		{
			liftables.push(itemBuilder.createFrozenFish(2));
			liftables.push(itemBuilder.createPenguin(1));
			liftables.push(itemBuilder.createFrozenTomato(1));
			
			stars.push(specialBuilder.createGoldenStar(500, 350));
			stars.push(specialBuilder.createSilverStar(163, 267));
			stars.push(specialBuilder.createBronzeStar(670, 145));
		}
		
		private function stage3_5():void
		{
			liftables.push(itemBuilder.createFrozenFish(1));
			liftables.push(itemBuilder.createPenguin(1));
			liftables.push(itemBuilder.createFragileIce(1));
			
			stars.push(specialBuilder.createGoldenStar(680, 245));
			stars.push(specialBuilder.createBronzeStar(258, 375));
			stars.push(specialBuilder.createSilverStar(340, 253));
		}
		
//======================================================STAGE 4=========================================================================

		private function stage4(substg:int):void 
		{
			MusicManager.getInstance().playStage4BGM();
			DraggableObject.calculate_mass_on_me = true;
		}
		
		private function stage4_1():void
		{
			var gBlock1:GravityBlock = specialBuilder.createGravityBlock(150, 200);
			var gBlock2:GravityBlock = specialBuilder.createGravityBlock(650, 350);
			gBlock1.setPair(gBlock2);
	
			others.push(gBlock1);
			others.push(gBlock2);
			
			liftables.push(itemBuilder.createLightBox(2));
			liftables.push(itemBuilder.createLightTriangle(2));
			
			stars.push(specialBuilder.createGoldenStar(650, 200));
			stars.push(specialBuilder.createSilverStar(150, 350));
			stars.push(specialBuilder.createBronzeStar(150, 190));
		}
		
		private function stage4_2():void
		{
			var gBlock1:GravityBlock = specialBuilder.createGravityBlock(200, 350);
			var gBlock2:GravityBlock = specialBuilder.createGravityBlock(600, 250);
			gBlock1.setPair(gBlock2);
	
			others.push(gBlock1);
			others.push(gBlock2);
			
			liftables.push(itemBuilder.createLightBox(3));
			
			others.push(specialBuilder.createGravityBall(300, 220));
			
			stars.push(specialBuilder.createSilverStar(600, 200));
			stars.push(specialBuilder.createBronzeStar(200, 300));
			stars.push(specialBuilder.createGoldenStar(200, 190));
		}
		
		private function stage4_3():void
		{
			var gBlock1:GravityBlock = specialBuilder.createGravityBlock(180, 250);
			var gBlock2:GravityBlock = specialBuilder.createGravityBlock(620, 250);
			var gBlock3:GravityBlock = specialBuilder.createGravityBlock(400, 250)
			gBlock3.setPair(gBlock2);
			
			others.push(gBlock1);
			others.push(gBlock2);
			others.push(gBlock3);
			
			liftables.push(itemBuilder.createLightBox(1));
			liftables.push(itemBuilder.createLightTriangle(1));
			liftables.push(itemBuilder.createLightHolder(1));
			
			others.push(specialBuilder.createGravityBall(275, 150));
			others.push(specialBuilder.createGravityBall(725, 350));
			
			stars.push(specialBuilder.createGoldenStar(620, 125));
			stars.push(specialBuilder.createSilverStar(400, 300));
			stars.push(specialBuilder.createBronzeStar(180, 275));
		}
		
		private function stage4_4():void
		{
			var gBlock1:GravityBlock = specialBuilder.createGravityBlock(180, 325);
			var gBlock2:GravityBlock = specialBuilder.createGravityBlock(620, 325);
			gBlock1.setPair(gBlock2);
			var gBlock3:GravityBlock = specialBuilder.createGravityBlock(400, 175)
			
			others.push(gBlock1);
			others.push(gBlock2);
			others.push(gBlock3);
			
			liftables.push(itemBuilder.createLightBox(2));
			liftables.push(itemBuilder.createLightTriangle(2));
			
			others.push(specialBuilder.createGravityBall(275, 250));
			others.push(specialBuilder.createGravityBall(725, 250));
			
			stars.push(specialBuilder.createGoldenStar(600, 200));
			stars.push(specialBuilder.createSilverStar(200, 275));
			stars.push(specialBuilder.createBronzeStar(400, 190));
		}
		
		private function stage4_5():void
		{
			var gBlock1:GravityBlock = specialBuilder.createGravityBlock(180, 325);
			var gBlock2:GravityBlock = specialBuilder.createGravityBlock(620, 325);
			var gBlock3:GravityBlock = specialBuilder.createGravityBlock(300, 175);
			var gBlock4:GravityBlock = specialBuilder.createGravityBlock(500, 175);
			gBlock1.setPair(gBlock3);
			gBlock2.setPair(gBlock4);
			
			others.push(gBlock1);
			others.push(gBlock2);
			others.push(gBlock3);
			others.push(gBlock4);
			
			liftables.push(itemBuilder.createLightBox(2));
			liftables.push(itemBuilder.createLightTriangle(2));
			liftables.push(itemBuilder.createLightHolder(1));
			
			others.push(specialBuilder.createGravityBall(75, 100));
			others.push(specialBuilder.createGravityBall(725, 250));
			
			stars.push(specialBuilder.createGoldenStar(500, 120));
			stars.push(specialBuilder.createSilverStar(400, 220));
			stars.push(specialBuilder.createBronzeStar(180, 370));
		}

//================================================== GENERAL ===========================================================================
		public function buildAndGetStage(stageIndex:int, substageIndex:int):Sprite
		{
			var stageID:String = stageIndex.toString() + "_" + substageIndex.toString();
			DraggableObject.calculate_mass_on_me = false;
			this["stage" + stageIndex.toString()](substageIndex);
			this["stage" + stageID]();
			
			for each(var star:Sprite in stars) others.push(star);
			
			buildStage();
			return stage;
		}
		
		public function buildStage():void
		{
			for each(var iArray:Array in liftables) {
				for each(var item:Sprite in iArray) {
					liftablesContainer.addChild(item);
				}
			}
			
			for each(var other:Sprite in others) {
				othersContainer.addChild(other);
			}
			
			stage.addChild(othersContainer);
			stage.addChild(liftablesContainer);
			
		}
		
		public function getStage():Sprite
		{
			return stage;
		}
		
		public function getStars():Array
		{
			return stars;
		}
		
		public function getLiftableItems():Array
		{
			var itemList:Array = new Array()
			for each(var arr:Array in liftables) {
				for each(var s:Sprite in arr) {
					itemList.push(s);
				}
			}
			
			return itemList;
		}
	}

}