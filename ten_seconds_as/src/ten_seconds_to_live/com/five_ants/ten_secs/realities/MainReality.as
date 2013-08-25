package ten_seconds_to_live.com.five_ants.ten_secs.realities 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import ten_seconds_to_live.com.five_ants.ten_secs.Camera;
	import ten_seconds_to_live.com.five_ants.ten_secs.Entity;
	import ten_seconds_to_live.com.five_ants.ten_secs.GameMap;
	import ten_seconds_to_live.com.five_ants.ten_secs.GameplayState;
	import ten_seconds_to_live.com.five_ants.ten_secs.object_actions.AddItemToInventory;
	import ten_seconds_to_live.com.five_ants.ten_secs.object_actions.AlterKnowledge;
	import ten_seconds_to_live.com.five_ants.ten_secs.object_actions.PlayerCinematic;
	import ten_seconds_to_live.com.five_ants.ten_secs.object_actions.ShowPopUp;
	import ten_seconds_to_live.com.five_ants.ten_secs.object_actions.StartSlowMotion;
	import ten_seconds_to_live.com.five_ants.ten_secs.Player;
	import ten_seconds_to_live.com.five_ants.ten_secs.RealityLogic;
	import ten_seconds_to_live.com.five_ants.ten_secs.RoomUtils;
	import ten_seconds_to_live.com.five_ants.ten_secs.WallCollisions;
	import ten_seconds_to_live.com.five_ants.ten_secs.Items;
	
	/**
	 * ...
	 * @author Miguel Santirso
	 */
	public class MainReality implements IRealityConfig
	{
		public function constructHouseCollisions():Sprite
		{
			return new HouseCollisions();
		}
		
		
		public function constructFloors():Sprite
		{
			return new Floors();
		}
		
		
		public function constructPlayer():Player
		{
			return new Player();
		}
		
		public function constructVisualGameMap():MovieClip
		{
			return new VisualGameMap();
		}
		
		
		public function scriptEntities(logic:RealityLogic, gamePlay:GameplayState):void
		{
			logic.findEntityByName("_bed").addAction(new StartSlowMotion(0.1, 5, gamePlay));
			logic.findEntityByName("_bed").addAction(new AddItemToInventory(Items.NOTE_AND_WATCH, gamePlay));
			logic.findEntityByName("_bed").addAction(new PlayerCinematic(Player.ANIM_SHOOTING, gamePlay));
		}
		
	}

}