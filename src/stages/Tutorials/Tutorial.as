package stages.Tutorials 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	import general.animations.LinearAnimation;
	import stages.StageBaseClass;
	import stages.Tutorials.commands.TutorialCommand;
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class Tutorial extends Dialog 
	{
		public static const ABOVE_ITEM_BOX:String = "above item box";
		public static const ON_ITEM_BOX:String = "in the middle of item box";
		public static var tutorialOn:Boolean = true;
		public var npc:Sprite;
		
		public function Tutorial(stageID:String) 
		{
			super(stageID);
		}
		
		override protected function setDefaultCondition():void 
		{
			super.setDefaultCondition();
			npc.visible = true;
		}
		
		override protected function creationComplete(e:Event):void 
		{
			super.creationComplete(e);
			
			var scaleRatio:Number = 0.8;
			npc = new collection.gavinAsset();
			npc.width *= scaleRatio;
			npc.height *= scaleRatio;
			npc.x = -width/2 + npc.width / 2 + 30;
			npc.y = - npc.height / 2 - height / 2;
			addChild(npc);
			
			tutorialOn = true;
			TutorialCommand.setTutorial(this);
		}
		
		public function moveTo(position:String):void
		{
			var destination:Point = new Point();
			switch(position) {
				case ABOVE_ITEM_BOX: destination.x = StageBaseClass.STAGE_WIDTH / 2;
									 destination.y = StageBaseClass.STAGE_HEIGHT - StageBaseClass.ITEMBOX_HEIGHT - dialogBoxHeight / 2;
									 break;
									 
				case ON_ITEM_BOX: destination.x = StageBaseClass.STAGE_WIDTH / 2;
								  destination.y = StageBaseClass.STAGE_HEIGHT - dialogBoxHeight / 2;
								  break;
			}
			
			var anim:LinearAnimation = new LinearAnimation();
			anim.constantMove(this, new Point(x, y), destination, 500);
		}
		
	}

}