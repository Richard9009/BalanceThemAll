package gameObjects 
{
	import flash.media.Sound;
	import general.PhysicSound;
	
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public interface IAudibleObject 
	{
		function getSound():PhysicSound;
		function setSound(impactSnd:Sound, breakSnd:Sound = null, rollSnd:Sound = null):void;
	}
	
}