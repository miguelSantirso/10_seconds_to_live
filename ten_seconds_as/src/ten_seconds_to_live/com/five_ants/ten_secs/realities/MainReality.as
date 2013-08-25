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
			object("_bed").addActionSuccess(new ShowPopUp(Items.CAT, "camara", "camara!"));
			object("_bed").addActionSuccess(new AddItemToInventory(Items.CAMERA));
			
			object("_chair").addActionSuccess(new AddItemToInventory(Items.GUN));
			object("_chair").addActionSuccess(new ShowPopUp(Items.FAN, "pistola", "pistola regalada"));
		}
	}

}