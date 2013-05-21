package gameObjects 
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import org.flashdevelop.utils.FlashConnect;
	
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class BalanceLine extends Sprite 
	{
		
		private var bodyA:b2Body;
		private var bodyB:b2Body;
		private var balancePoint:b2Vec2;
		private var balanceRange:Number = 10;
		
		public function BalanceLine() 
		{
			super();
			balancePoint = new b2Vec2();
		}
		
		public function startDrawLine(body1:b2Body, body2:b2Body):void
		{
			bodyA = body1;
			bodyB = body2;
			addEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		private function enterFrame(e:Event):void 
		{
			graphics.clear();
			calculateBalancePoint();
			drawBalancePoint();
			drawLine();
		}
		
		private function drawBalancePoint():void 
		{
			var itemA:Sprite = bodyA.GetUserData();
			var itemB:Sprite = bodyB.GetUserData();
			
			var xDist:Number = Math.abs(itemA.x - itemB.x);
			var fromB:Number = Math.abs(balancePoint.x - itemB.x);
			var gradientRatio:int = Math.round(fromB / xDist * 255);
			
			var gradientMatrix:Matrix = new Matrix();
			gradientMatrix.createGradientBox(itemA.x - itemB.x, itemA.y - itemB.y, 0, itemB.x, 0);
		
			graphics.lineStyle(3);
			graphics.lineGradientStyle(GradientType.LINEAR, [0xFFFF00, 0xFF0000, 0xFF0000, 0xFFFF00], [0.5 , 1 , 1, 0.5], 
									[0, gradientRatio - balanceRange, gradientRatio + balanceRange, 255], gradientMatrix);
		}
		
		public function stopDrawLine():void
		{
			removeEventListener(Event.ENTER_FRAME, enterFrame);
			graphics.clear();
		}
		
		private function drawLine():void
		{
			if (bodyA == null || bodyB == null) return;
			
			graphics.moveTo(bodyA.GetUserData().x, bodyA.GetUserData().y);
			graphics.lineTo(bodyB.GetUserData().x, bodyB.GetUserData().y);
		}
		
		private function calculateBalancePoint():void
		{
			var xDist:Number = bodyA.GetUserData().x - bodyB.GetUserData().x;
			var yDist:Number = bodyA.GetUserData().y - bodyB.GetUserData().y;
			var tangent:Number = yDist / xDist;
			
			var massRatio:Number = bodyB.GetMass() / bodyA.GetMass();
			var xBPointFromA:Number = xDist*massRatio/(massRatio + 1);
			var yBPointFromA:Number = xBPointFromA * tangent;
			
			balancePoint.x = bodyA.GetUserData().x - xBPointFromA;
			balancePoint.y = bodyA.GetUserData().y - yBPointFromA;
		}
	}

}