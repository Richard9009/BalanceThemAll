package gameObjects.rigidObjects 
{
	import assets.AssetCollection;
	import flash.display.Sprite;
	import flash.events.Event;
	import gameEvents.TutorialEvent;
	import gameObjects.BalanceLine;
	import org.flashdevelop.utils.FlashConnect;
	import resources.DashedLine;
	import stages.Tutorials.TutorialEventDispatcher;
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class Foundation extends RigidObjectBase 
	{
		private var collection:AssetCollection = new AssetCollection();
		private var balanceZone:DashedLine;
		private var alreadyBalanced:Boolean = false;
		
		public function Foundation() 
		{
			super();
		}
		
		public function showBalancePoint():void
		{
			var lineLength:Number = 440;
			balanceZone = new DashedLine(2,0x333333,new Array(5, 8));
			
			balanceZone.x = this.x;
			balanceZone.y = this.y;
			
			balanceZone.moveTo(-20 - height/2,  - 70);
			balanceZone.lineTo(- 20 - height/2,  - lineLength);
			balanceZone.moveTo(- 20 + height/2,  - 70);
			balanceZone.lineTo(- 20 + height/2,  - lineLength);
			
			parent.addChild(balanceZone);
		}
		
		public function clearBalancePoint():void
		{
			if(balanceZone) {
				balanceZone.graphics.clear();
				parent.removeChild(balanceZone);
			}
		}
		
		private var balanceLine:BalanceLine;
		public function startCheckingBalanceLine(bLine:BalanceLine):void
		{
			balanceLine = bLine;
			alreadyBalanced = false;
			addEventListener(Event.ENTER_FRAME, checkBalanceLine);
		}
		
		public function stopChecking():void {
			removeEventListener(Event.ENTER_FRAME, checkBalanceLine);
			alreadyBalanced = false;
			balanceLine = null;
		}
		
		private function checkBalanceLine(e:Event):void 
		{
			if (balancePointInsideBalanceZone() && !alreadyBalanced) {
				FlashConnect.trace("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
				TutorialEventDispatcher.getInstance().dispatchEvent(new TutorialEvent(TutorialEvent.ON_BALANCE_POSITION));
				alreadyBalanced = true;
			}
			
			if (!balancePointInsideBalanceZone() && alreadyBalanced) {
				TutorialEventDispatcher.getInstance().dispatchEvent(new TutorialEvent(TutorialEvent.OUT_FROM_BALANCE_ZONE));
				alreadyBalanced = false;
			}
		}
		
		private function balancePointInsideBalanceZone():Boolean
		{
			FlashConnect.trace(balanceLine.balance_point.x + "___" + balanceZone.width);
			return (balanceLine.balance_point.x > balanceZone.x - balanceZone.width / 2
			        && balanceLine.balance_point.x < balanceZone.x + balanceZone.width / 2
					&& balanceLine.balance_point.y < balanceZone.y);
		}
		
	}

}