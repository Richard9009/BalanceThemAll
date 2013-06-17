package stages 
{
	import assets.AssetCollection;
	import builders.ObjectBuilder;
	import builders.SpecialObjectBuilder;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2Fixture;
	import builders.StageBuilder;
	import flash.display.Sprite;
	import gameObjects.rigidObjects.CompoundObject;
	import gameObjects.rigidObjects.Foundation;
	import gameObjects.rigidObjects.RigidObjectBase;
	import org.flashdevelop.utils.FlashConnect;
	/**
	 * ...
	 * @author Herichard Stefanus Salim
	 */
	public class SecondStage extends StageBaseClass implements IPlayableStage 
	{
		
		private var collection:AssetCollection;
		private var asset:Class;
		private var itemArray:Array = new Array();
		private var itemBuilder:ObjectBuilder = new ObjectBuilder();
		private var specialBuilder:SpecialObjectBuilder = new SpecialObjectBuilder();
		
		public function SecondStage() 
		{
			collection = new AssetCollection();
			asset = collection.stage2BGAsset;
			
			var assetData:Sprite = new asset() as Sprite;
			assetData.x = STAGE_WIDTH / 2;
			assetData.y = STAGE_HEIGHT / 2;
			this.addChild(assetData);
			
			super();
			
		}
		
		/* INTERFACE stages.IPlayableStage */
		
		public function createLevelBySubStageID(subStageIndex:int):void 
		{
			initiateStage("2_" + subStageIndex.toString());
			
			var builder:StageBuilder = new StageBuilder();
			addChild(builder.buildAndGetStage(2, subStageIndex));
			stars = builder.getStars();
		}
	}

}