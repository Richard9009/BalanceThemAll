package builders 
{
	import flash.display.Sprite;
	import gameObjects.rigidObjects.Foundation;
	import gameObjects.rigidObjects.RigidObjectBase;
	import general.MusicManager;
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
		private var liftables:Array;
		private var others:Array;
		
		private var itemBuilder:ObjectBuilder = new ObjectBuilder();
		private var specialBuilder:SpecialObjectBuilder = new SpecialObjectBuilder();
		
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
		
		private function stage1(subStageIndex:int):void
		{
			var hardMode:Boolean = subStageIndex > 4;
			
			switch(subStageIndex) {
				case 1: stage1_1(); break;
				case 2: stage1_2(); break;
				case 3: stage1_3(); break;
				case 4: stage1_4(); break;
				case 5: stage1_5(); break;
			}
			
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
			liftables.push(itemBuilder.createPillow(1));
			liftables.push(itemBuilder.createEncyclopedia(1));
			var book:RigidObjectBase = RigidObjectBase(liftables[1][0]);
			book.getBody().SetAngle(90); 
			
			stars.push(specialBuilder.createGoldenStar(150, 290));
			stars.push(specialBuilder.createSilverStar(450, 290));
		}
		
		private function stage1_4():void {
			liftables.push(itemBuilder.createPillow(1));
			liftables.push(itemBuilder.createBlueBook(1));
			liftables.push(itemBuilder.createShoes(1));
			liftables.push(itemBuilder.createEncyclopedia(1));
			
			stars.push(specialBuilder.createGoldenStar(150, 250));
			stars.push(specialBuilder.createSilverStar(550, 250));
		}
		
		private function stage1_5():void {
			liftables.push(itemBuilder.createPhoto(3));
			liftables.push(itemBuilder.createPillow(1));
			liftables.push(itemBuilder.createShoes(1));
			
			stars.push(specialBuilder.createGoldenStar(150, 170));
			stars.push(specialBuilder.createSilverStar(550, 220));
		}
		
//=====================================================STAGE 2========================================================================

		private function stage2(substageIndex:int):void
		{
			switch(substageIndex) {
				case 1: stage2_1(); break;
				case 2: stage2_2(); break;
				case 3: stage2_3(); break;
			}
			
			others.push(specialBuilder.createBookStack(380, 410));
			others.push(specialBuilder.createBaseballBat(380, 365));
		}

		private function stage2_1():void
		{
			liftables.push(itemBuilder.createBasketBall(1));
			liftables.push(itemBuilder.createEncyclopedia(1));
			liftables.push(itemBuilder.createMug(1));
			liftables.push(itemBuilder.createGlassVase(1));
			
			stars.push(specialBuilder.createGoldenStar(110, 225));
			stars.push(specialBuilder.createSilverStar(550, 265));
		}
		
		private function stage2_2():void
		{
			liftables.push(itemBuilder.createPhoto(1));
			liftables.push(itemBuilder.createHeavyObject(1));
			liftables.push(itemBuilder.createBlueBook(1));
			
			stars.push(specialBuilder.createGoldenStar(110, 210));
			stars.push(specialBuilder.createSilverStar(550, 268));
		}
		
		private function stage2_3():void
		{
			liftables.push(itemBuilder.createShoes(2));
			liftables.push(itemBuilder.createBowlingBall(2));
			liftables.push(itemBuilder.createHeavyObject(2));
			
			stars.push(specialBuilder.createGoldenStar(110, 210));
			stars.push(specialBuilder.createSilverStar(550, 268));
		}

//================================================== GENERAL ===========================================================================
		public function buildAndGetStage(stageIndex:int, substageIndex:int):Sprite
		{
			switch(stageIndex) {
				case 1: stage1(substageIndex); break;
				case 2: stage2(substageIndex); break;
			}
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
			
			stage.addChild(liftablesContainer);
			stage.addChild(othersContainer);
		}
		
		public function getStage():Sprite
		{
			return stage;
		}
		
		public function getStars():Array
		{
			return stars;
		}
		
		public function getFoundation():Foundation
		{
			for each(var obj:Sprite in others) {
				if (obj is Foundation) return (obj as Foundation);
			}
			
			return null;
		}
	}

}