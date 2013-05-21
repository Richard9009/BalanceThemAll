package general.collisions 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public interface ICollisionTest 
	{
		function hitTest(objectA:Sprite, objectB:Sprite):Boolean;
	}
	
}