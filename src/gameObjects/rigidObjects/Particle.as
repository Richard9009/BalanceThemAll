package gameObjects.rigidObjects 
{
	import assets.AssetCollection;
	import Box2D.Common.Math.b2Vec2;
	import flash.events.Event;
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class Particle extends RigidObjectBase 
	{
		public static const GLASS:String = "GLASS";
		public static var glassAssets:Array;
		private var collection:AssetCollection = new AssetCollection();
		
		public function Particle() 
		{
			Main.getWorld().Step(0, 10, 10);
			super();
			Main.getWorld().Step(1 / 30, 10, 10);
			
			if(glassAssets == null) {
				glassAssets = [collection.glassPart1Asset, collection.glassPart2Asset,
								 collection.glassPart3Asset, collection.glassPart4Asset];
			}
			var randomIndex:int = Math.floor(Math.random() * glassAssets.length);
			createDisplayBody(glassAssets[randomIndex]);
			setFixtureProperties(0.1, 0.1, 0.4);
			var randomSize:Number = Math.floor(Math.random() * 150 + 150) / Main._physScale;
			setSize(randomSize, randomSize);
			applyImpulseToRandomDirection();
			
			addEventListener(Event.ENTER_FRAME, checkActivity);
		}
		
		protected function checkActivity(e:Event):void 
		{
			if (rigidBody.GetLinearVelocity().Length() < 0.1) {
				destroyRigidBody();
				parent.removeChild(this);
				removeEventListener(Event.ENTER_FRAME, checkActivity);
			}
		}
		
		private function applyImpulseToRandomDirection():void
		{
			var randomAngle:Number = Math.random() * Math.PI * 2;
			var randomStrength:Number = Math.random() * 0.08;
			var impulseVector:b2Vec2 = new b2Vec2();
			impulseVector.x = randomStrength * Math.cos(randomAngle);
			impulseVector.y = randomStrength * Math.sin(randomAngle);
			
			rigidBody.ApplyImpulse(impulseVector, rigidBody.GetWorldCenter());
		}
		
	}

}