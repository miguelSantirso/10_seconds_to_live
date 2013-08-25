package ten_seconds_to_live.com.five_ants.ten_secs.realities 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.sensors.Accelerometer;
	import ten_seconds_to_live.com.five_ants.ten_secs.Camera;
	import ten_seconds_to_live.com.five_ants.ten_secs.Entity;
	import ten_seconds_to_live.com.five_ants.ten_secs.GameMap;
	import ten_seconds_to_live.com.five_ants.ten_secs.GameplayState;
	import ten_seconds_to_live.com.five_ants.ten_secs.interfaces.IInteractiveEntity;
	import ten_seconds_to_live.com.five_ants.ten_secs.object_actions.AddItemToInventory;
	import ten_seconds_to_live.com.five_ants.ten_secs.object_actions.AlterKnowledge;
	import ten_seconds_to_live.com.five_ants.ten_secs.object_actions.PlayerCinematic;
	import ten_seconds_to_live.com.five_ants.ten_secs.object_actions.ShowPopUp;
	import ten_seconds_to_live.com.five_ants.ten_secs.object_actions.StartSlowMotion;
	import ten_seconds_to_live.com.five_ants.ten_secs.Player;
	import ten_seconds_to_live.com.five_ants.ten_secs.RealityLogic;
	import ten_seconds_to_live.com.five_ants.ten_secs.RoomUtils;
	import ten_seconds_to_live.com.five_ants.ten_secs.WallCollisions;
	import ten_seconds_to_live.com.five_ants.ten_secs.PlayerKnowledge;
	import ten_seconds_to_live.com.five_ants.ten_secs.Items;
	
	/**
	 * ...
	 * @author Miguel Santirso
	 */
	public class MainReality implements IRealityConfig
	{
		private var _logic:RealityLogic;
		
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
		
		public function object(name:String):IInteractiveEntity
		{
			if (_logic)
			{
				return _logic.findEntityByName(name);
			}
			else return null;
		}
		
		public function scriptEntities(logic:RealityLogic):void
		{
			_logic = logic;
			
			// _bed
			object("_bed").setItemDependency(Items.GUN);
			object("_bed").addActionNoItem(new ShowPopUp(Items.CAT, "hola", "hola"));
			object("_bed").addActionNoItem(new StartSlowMotion(0.2, 5));
			object("_bed").addActionSuccess(new AddItemToInventory(Items.CAMERA));
			
			object("_interaction1").addActionSuccess(new AddItemToInventory(Items.GUN));
			object("_interaction1").addActionNoItem(new ShowPopUp(Items.GUN, "pistola", "pistola regalada"));
			
			/*// _interactive1
			object("_interactive1").setItemDependency("angry bird");
			object("_interactive1").addConsecuence(new AddItemToInventory("las bambas del jose", gamePlay));
			object("_interactive1").addConsecuence(new AlterKnowledge("flex", gamePlay));
			
			object("_interactive0").addConsecuence(new AddItemToInventory("angry bird", gamePlay));
			
			//object("_interactive1").setKnowledgeDependency("flex");
			//object("_bed").addActionNoItemNoKnowledge(new StartSlowMotion(0.1, 5, gamePlay));
			logic.findEntityByName("_bed").addAction(new PlayerCinematic(Player.ANIM_SHOOTING, gamePlay));*/
		}
		
	}

}