package general 
{
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Common.Math.b2Vec2;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.media.SoundTransform;
	import Box2D.Dynamics.b2Body;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundLoaderContext;
	import flash.net.URLRequest;
	import org.flashdevelop.utils.FlashConnect;
	import stages.StageBaseClass;
	
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class PhysicSound
	{
		private static const AVERAGE_MASS:Number = 1;
		private static const AVERAGE_IMPULSE:Number = 3;
		private static const MAX_IMPULSE_VOLUME:Number = 10;
		
		private var body:b2Body;
		private var minImpulse:Number;
		private var maxImpulse:Number;
		private var impactSound:Sound;
		private var rollingSound:Sound;
		private var breakingSound:Sound;
		private var maxVolume:Number = 1;
		private var impactVolume:Number = 0;
		
		private var soundIsPlaying:Boolean = false;
		private var dispatcher:EventDispatcher = new EventDispatcher();
		
		public function PhysicSound() 
		{
			rollingSound = null;
		}
		
		public function setBody(rigidBody:b2Body):void
		{
			body = rigidBody;
			minImpulse = AVERAGE_IMPULSE * body.GetMass() / AVERAGE_MASS;
			maxImpulse = MAX_IMPULSE_VOLUME * body.GetMass() / AVERAGE_MASS;
		}
		
		public function setSound(s:Sound):void
		{
			impactSound = s;
		}
		
		public function setRollingSound(s:Sound):void
		{
			rollingSound = s;
		}
		
		public function setBreakingSound(s:Sound):void
		{
			breakingSound = s;
		}
		
		private function play(sound:Sound, volume:Number = 0.5, repeat:Boolean = false):void 
		{
			if (!soundIsPlaying) {
				var sChannel:SoundChannel;
				var sTrans:SoundTransform = new SoundTransform();
				sTrans.pan = getPanning();
				sTrans.volume = getPannedVolume(volume, sTrans.pan);
				sChannel = sound.play(0, (repeat) ? 1 : 0, null);
				sChannel.soundTransform = sTrans;
				
				if(!repeat){
					sChannel.addEventListener(Event.SOUND_COMPLETE, handleSoundComplete); 
					soundIsPlaying = true;
				}	
			}
		}
		
		public function playImpactSound(impulse:Number):void
		{
			if ((impulse > minImpulse) && (body.GetLinearVelocity().Length() > 0.5)) {
				
				impactVolume = (impulse - minImpulse) / (maxImpulse - minImpulse) * maxVolume;
				play(impactSound, impactVolume);
				
			}
		}
		
		public function playBreakingSound(startTime:Number = 0, loops:int = 1, sndTransform:SoundTransform = null):void
		{
			play(breakingSound, maxVolume);
		}
		
		private function handleSoundComplete(e:Event):void 
		{
			soundIsPlaying = false;
		}
		
		private function getPanning():Number
		{
			var xPos:Number = body.GetPosition().x * Main._physScale;
			var xCenter:Number = StageBaseClass.STAGE_WIDTH / 2;
			var stageHalfWidth:Number = xCenter;
			
			return ((xPos - xCenter) / stageHalfWidth);
		}
		
		private function getPannedVolume(vol:Number, pan:Number):Number
		{
			return ((1 - Math.abs(pan / 2)) * vol); 
		}
	}

}