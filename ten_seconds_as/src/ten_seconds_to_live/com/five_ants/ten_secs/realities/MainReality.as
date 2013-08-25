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
	import ten_seconds_to_live.com.five_ants.ten_secs.object_actions.RemoveInteractiveObject;
	import ten_seconds_to_live.com.five_ants.ten_secs.object_actions.RemoveItemFromInventory;
	import ten_seconds_to_live.com.five_ants.ten_secs.object_actions.ShowDialog;
	import ten_seconds_to_live.com.five_ants.ten_secs.object_actions.ShowPopUp;
	import ten_seconds_to_live.com.five_ants.ten_secs.object_actions.StartSlowMotion;
	import ten_seconds_to_live.com.five_ants.ten_secs.object_actions.TriggerFlashback;
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
			
			object("_roomTable").addActionSuccess(new ShowPopUp(Items.NOTE_AND_WATCH, "note_and_watch"));

			object("_roomTable").addActionSuccess(new AlterKnowledge("going_to_die"));
			
			object("_window$30").addActionSuccess(new PlayerCinematic(Player.ANIM_JUMP_WINDOW), true);
			
			object("_gun").setKnowledgeDependency("going_to_die");
			object("_gun").addActionSuccess(new ShowPopUp(Items.GUN, "gun"));
			object("_gun").addActionSuccess(new AddItemToInventory(Items.GUN));
			
			object("_door").setItemDependency(Items.GUN);
			object("_door").addActionNoItem(new ShowPopUp(Items.DORM_DOOR, "locked_door_noI"));
			object("_door").addActionSuccess(new ShowPopUp(Items.DORM_DOOR, "locked_door"));
			object("_door").addActionSuccess(new ChangeCollision("door", false));
			object("_door").addActionSuccess(new PlayerCinematic(Player.ANIM_SHOOTING));
			object("_door").addActionSuccess(new RemoveItemFromInventory(Items.GUN));
			object("_door").addActionSuccess(new RemoveInteractiveObject("_door"));
			
			object("_car").setKnowledgeDependency("there_are_pills_in_car");
			object("_car").addActionNoItemNoKnowledge(new ShowPopUp(Items.CAR, "car_noI_noK"));
			object("_car").addActionSuccess(new ShowPopUp(Items.CAR, "car"));
			object("_car").addActionSuccess(new StartSlowMotion(0.2, 10));
			
			object("_statue").setKnowledgeDependency("i_need_the_secret_code");
			object("_statue").addActionNoItemNoKnowledge(new ShowPopUp(Items.STATUE, "statue_noI_noK"));
			object("_statue").addActionSuccess(new ShowPopUp(Items.STATUE, "statue"));
			object("_statue").addActionSuccess(new AlterKnowledge("the_secret_code_is_1234"));
			
			object("_pills").setKnowledgeDependency("going_to_die");
			object("_pills").addActionSuccess(new ShowPopUp(Items.MEDICATION, "adrenaline_pills"));
			object("_pills").addActionSuccess(new AlterKnowledge("there_are_pills_in_car"));
			object("_pills").addActionSuccess(new StartSlowMotion(0.2, 10));
			
			object("_bookshelf").setKnowledgeDependency("there_is_a_panic_room");
			object("_bookshelf").setItemDependency(Items.BOOK);
			object("_bookshelf").addActionNoItemNoKnowledge(new ShowPopUp(Items.BOOKSHELF, "book_shelf_noI_noK"));
			object("_bookshelf").addActionNoItem(new ShowPopUp(Items.BOOKSHELF, "book_shelf_noI"));
			object("_bookshelf").addActionSuccess(new ShowPopUp(Items.BOOKSHELF, "book_shelf"));
			object("_bookshelf").addActionSuccess(new RemoveItemFromInventory(Items.BOOK));
			object("_bookshelf").addActionSuccess(new AlterKnowledge("i_need_the_secret_code"));
			object("_bookshelf").addActionSuccess(new RemoveInteractiveObject("_bookshelf"));
			
			object("_secretDoor").setKnowledgeDependency("the_secret_code_is_1234");
			object("_secretDoor").addActionSuccess(new ShowPopUp(Items.SECRET_DOOR, "secretdoor"));
			object("_secretDoor").addActionSuccess(new ChangeCollision("library_secret_door", false));
			object("_secretDoor").addActionSuccess(new RemoveInteractiveObject("_secretDoor"));
			
			object("_picture$80").addActionSuccess(new ShowPopUp(Items.PICTURE, "picture"));
			object("_picture$80").addActionSuccess(new AlterKnowledge("catnip_attracts_cat"));
			
			object("_book").setKnowledgeDependency("there_is_a_panic_room");
			object("_book").addActionNoItemNoKnowledge(new ShowPopUp(Items.BOOK, "book_noI_noK"));
			object("_book").addActionSuccess(new ShowPopUp(Items.BOOK, "book"));
			object("_book").addActionSuccess(new AddItemToInventory(Items.BOOK));
			
			object("_catfood").setKnowledgeDependency("catnip_attracts_cat");
			object("_catfood").addActionSuccess(new ShowPopUp(Items.CATNIP, "catnip"));
			object("_catfood").addActionSuccess(new AddItemToInventory(Items.CATNIP));
			
			object("_camera1").addActionSuccess(new ShowPopUp(Items.CAMERA, "security_camera"));
			object("_camera1").addActionSuccess(new AlterKnowledge("there_is_a_panic_room"));
			
			object("_fireplace").addActionSuccess(new ShowPopUp(Items.NONE, "fireplace"));
			
			object("_bathtub").addActionSuccess(new ShowPopUp(Items.NONE, "bathtub"));
			
			object("_bed").addActionSuccess(new ShowPopUp(Items.NONE, "bed"));
			
			object("_kitchen").addActionSuccess(new ShowPopUp(Items.NONE, "kitchen"));
			
			object("_clock$50").addActionSuccess(new ShowPopUp(Items.NONE, "clock"));
			
			object("_kitchenTable").addActionSuccess(new ShowPopUp(Items.NONE, "kitchen_table"));
			
		}
	}

}