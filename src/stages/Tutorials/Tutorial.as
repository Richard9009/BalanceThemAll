package stages.Tutorials 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import general.dialogs.Dialog;
	
	import general.animations.LinearAnimation;
	import stages.StageConfig;
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class Tutorial extends Dialog
	{
		public static const ABOVE_ITEM_BOX:String = "above item box";
		public static const ON_ITEM_BOX:String = "in the middle of item box";
		public static var tutorialOn:Boolean = false;
		public var npc:Sprite;
		
		public function Tutorial(stageID:String) 
		{
			super(DialogListCollection.getDialogListByID(stageID));
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
		
		override public function destroyMe():void 
		{
			tutorialOn = false;
			super.destroyMe();
		}
		
		public function moveTo(position:String):void
		{ 
			var destination:Point = new Point();
			switch(position) {
				case ABOVE_ITEM_BOX: destination.x = StageConfig.STAGE_WIDTH / 2;
									 destination.y = StageConfig.STAGE_HEIGHT - StageConfig.ITEMBOX_HEIGHT - dialogBoxHeight / 2;
									 break;
									 
				case ON_ITEM_BOX: destination.x = StageConfig.STAGE_WIDTH / 2;
								  destination.y = StageConfig.STAGE_HEIGHT - dialogBoxHeight / 2;
								  break;
			}
			
			var anim:LinearAnimation = new LinearAnimation();
			anim.constantMove(this, new Point(x, y), destination, 500);
		}
		
	}

}