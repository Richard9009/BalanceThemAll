package general 
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import org.flashdevelop.utils.FlashConnect;
	
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class MousePhysic
	{
		private static var stageMc:Sprite;
		
		private static var _mouseX:Number;
		private static var _mouseY:Number;
		
		private static var _physMouseX:Number;
		private static var _physMouseY:Number;
		
		private static var isFirstClick:Boolean = true;
		private static var dClickTimer:Timer = new Timer(250, 1);
		private static var _isDown:Boolean = false;
		
		public static var isDragging:Boolean = false;
		public static var isHolding:Boolean = false;
		public static var pointedBody:b2Body;
		public static var scrollDelta:Number;
		public static var allowDoubleClick:Boolean = true;
		
		public function MousePhysic() 
		{

		}
		
		private static function onClick(e:MouseEvent):void 
		{
			if (!allowDoubleClick) return;
			
			if(isFirstClick){
				dClickTimer.start();
				isFirstClick = false;
			}
			else {
				isFirstClick = true;
				isHolding = false;
			}
		}
		
		private static function onMouseWheel(e:MouseEvent):void 
		{
			scrollDelta = e.delta;
		}
		
		private static function onMouseUp(e:MouseEvent):void 
		{
			_isDown = false;
		}
		
		private static function onMouseDown(e:MouseEvent):void 
		{
			_isDown = true;
		}
		
		private static function updatePosition(e:Event):void
		{
			_mouseX = stageMc.mouseX;
			_mouseY = stageMc.mouseY;
			
			_physMouseX = stageMc.mouseX / Main._physScale;
			_physMouseY = stageMc.mouseY / Main._physScale;
		}
		
		public static function setStage(stage:Sprite):void
		{
			stageMc = stage;
			
			stage.addEventListener(Event.ENTER_FRAME, updatePosition);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			stage.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
			stage.addEventListener(MouseEvent.CLICK, onClick);
			
			if(!dClickTimer.hasEventListener(TimerEvent.TIMER))
				dClickTimer.addEventListener(TimerEvent.TIMER, function():void { isFirstClick = true; } );
		}
		
		public static function destroyStage():void
		{
			if (stageMc == null) return;
			
			stageMc.removeEventListener(Event.ENTER_FRAME, updatePosition);
			stageMc.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			stageMc.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			stageMc.removeEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
			stageMc.removeEventListener(MouseEvent.CLICK, onClick);
			
			stageMc = null;
		}
		
		public static function get mousePos():b2Vec2
		{
			return new b2Vec2(_mouseX, _mouseY);
		}
		
		public static function get physMousePos():b2Vec2
		{
			return new b2Vec2(_physMouseX, _physMouseY);
		}
		
		public static function get isDown():Boolean
		{
			return _isDown;
		}
		
		public static function lockStage():void
		{
			_isDown = false;
			destroyStage();
		}
		
		public static function unlockStage(stage:Sprite):void
		{
			setStage(stage);
		}
		
	}

}