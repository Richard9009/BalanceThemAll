package assets 
{
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class AssetCollection 
	{
		[Embed (source = "AssetLibrary.swf", symbol = "Stage_Asset")]
		public var stageAsset:Class;
			
		public function AssetCollection() 
		{
			 
		}
		
	}

}