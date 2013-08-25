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
	import ten_seconds_to_live.com.five_ants.ten_secs.object_actions.ChangeCollision;
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
			
			object("_roomTable").addActionSuccess(new ShowPopUp(Items.NOTE_AND_WATCH, "Note from A.B.", "You are going to die. A.B."));
			object("_roomTable").addActionSuccess(new AlterKnowledge("going_to_die"));
			
			object("_window").addActionSuccess(new PlayerCinematic(Player.ANIM_JUMP_WINDOW));
			
			object("_gun").setKnowledgeDependency("going_to_die");
			object("_gun").addActionSuccess(new ShowPopUp(Items.GUN, "My Gun", "bla bla bla"));
			object("_gun").addActionSuccess(new AddItemToInventory(Items.GUN));
			
			object("_door").setItemDependency(Items.GUN);
			object("_door").addActionNoItem(new ShowPopUp(Items.GUN, "Locked Door", "Argh! The door is locked, I need something to open it!"));
			object("_door").addActionSuccess(new ShowPopUp(Items.GUN, "Door Open!", "I opened the door with the gun"));
			object("_door").addActionSuccess(new ChangeCollision("_door", false));
			object("_door").addActionSuccess(new PlayerCinematic(Player.ANIM_SHOOTING));
		}
	}

}