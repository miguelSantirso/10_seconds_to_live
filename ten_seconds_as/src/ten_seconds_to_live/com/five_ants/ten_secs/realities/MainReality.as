package ten_seconds_to_live.com.five_ants.ten_secs.realities 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.sensors.Accelerometer;
	import ten_seconds_to_live.com.five_ants.ten_secs.Camera;
	import ten_seconds_to_live.com.five_ants.ten_secs.Dialog;
	import ten_seconds_to_live.com.five_ants.ten_secs.DialogItem;
	import ten_seconds_to_live.com.five_ants.ten_secs.Entity;
	import ten_seconds_to_live.com.five_ants.ten_secs.GameMap;
	import ten_seconds_to_live.com.five_ants.ten_secs.GameplayState;
	import ten_seconds_to_live.com.five_ants.ten_secs.interfaces.IInteractiveEntity;
	import ten_seconds_to_live.com.five_ants.ten_secs.object_actions.AddItemToInventory;
	import ten_seconds_to_live.com.five_ants.ten_secs.object_actions.AlterKnowledge;
	import ten_seconds_to_live.com.five_ants.ten_secs.object_actions.ChangeCollision;
	import ten_seconds_to_live.com.five_ants.ten_secs.object_actions.ObjectToggleInteraction;
	import ten_seconds_to_live.com.five_ants.ten_secs.object_actions.PlayerCinematic;
	import ten_seconds_to_live.com.five_ants.ten_secs.object_actions.PlaySound;
	import ten_seconds_to_live.com.five_ants.ten_secs.object_actions.PlayFlashbackCinematic;
	import ten_seconds_to_live.com.five_ants.ten_secs.object_actions.RemoveInteractiveObject;
	import ten_seconds_to_live.com.five_ants.ten_secs.object_actions.RemoveItemFromInventory;
	import ten_seconds_to_live.com.five_ants.ten_secs.object_actions.ShowClock;
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
	import ten_seconds_to_live.com.five_ants.ten_secs.Sounds;
	import ten_seconds_to_live.com.five_ants.ten_secs.HUD.HUD;
	import ten_seconds_to_live.com.five_ants.ten_secs.xml.TextManager;
	
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
			
			object("_roomTable$65").addActionSuccess(new ShowPopUp(Items.NOTE_AND_WATCH, "note_and_watch"));
			object("_roomTable$65").addActionSuccess(new AlterKnowledge("going_to_die"));
			object("_roomTable$65").addActionSuccess(new ShowClock());
			object("_roomTable$65").addActionSuccess(new PlaySound(Sounds.NOTE));
			
			object("_window$30").setKnowledgeDependency("going_to_die");
			object("_window$30").addActionNoItemNoKnowledge(new ShowDialog(TextManager.get().getDialogById("_window$30")));
			object("_window$30").addActionSuccess(new PlayerCinematic(Player.ANIM_JUMP_WINDOW), true);
			object("_window$30").addActionSuccess(new PlaySound(Sounds.GEAR));
			
			object("_gun").setKnowledgeDependency("going_to_die");
			object("_gun").addActionNoItemNoKnowledge(new ShowPopUp(Items.GUN, "gun_nI_nK")); //
			object("_gun").addActionSuccess(new ShowPopUp(Items.GUN, "gun"));
			object("_gun").addActionSuccess(new AddItemToInventory(Items.GUN));
			object("_gun").addActionSuccess(new PlaySound(Sounds.CLOSET_OPEN));
			object("_gun").addActionSuccess(new PlaySound(Sounds.TAKING_GUN));
			
			object("_door").setItemDependency(Items.GUN);
			object("_door").addActionNoItem(new ShowPopUp(Items.DORM_DOOR, "door_nI_nK")); //
			object("_door").addActionNoItem(new PlaySound(Sounds.LOCKED_DOOR));
			object("_door").addActionSuccess(new ShowPopUp(Items.DORM_DOOR, "locked_door"));
			object("_door").addActionSuccess(new PlaySound(Sounds.GUN_SHOT));
			object("_door").addActionSuccess(new ChangeCollision("door", false));
			object("_door").addActionSuccess(new RemoveItemFromInventory(Items.GUN));
			object("_door").addActionSuccess(new RemoveInteractiveObject("_door"));
			
			object("_car").setKnowledgeDependency("there_are_pills_in_car");
			object("_car").addActionNoItemNoKnowledge(new ShowPopUp(Items.CAR, "car_nI_nK")); //
			object("_car").addActionNoItemNoKnowledge(new PlaySound(Sounds.CAR_UNLOCK));
			object("_car").addActionSuccess(new ShowPopUp(Items.CAR, "car"));
			object("_car").addActionSuccess(new PlaySound(Sounds.PILLS2));
			object("_car").addActionSuccess(new PlaySound(Sounds.CAR_UNLOCK));
			object("_car").addActionSuccess(new StartSlowMotion(0.01, 12));
			
			object("_statue").setKnowledgeDependency("i_need_the_secret_code");
			object("_statue").addActionNoItemNoKnowledge(new ShowPopUp(Items.STATUE, "statue_nI_nK")); //
			object("_statue").addActionNoItemNoKnowledge(new PlaySound(Sounds.BIRDS));
			object("_statue").addActionSuccess(new ShowPopUp(Items.STATUE, "statue"));
			object("_statue").addActionSuccess(new PlaySound(Sounds.BIRDS));
			object("_statue").addActionSuccess(new AlterKnowledge("the_secret_code_is_1234"));
			
			object("_pills$65").setKnowledgeDependency("going_to_die");
			object("_pills$65").addActionSuccess(new ShowPopUp(Items.MEDICATION, "adrenaline_pills"));
			object("_pills$65").addActionSuccess(new PlaySound(Sounds.SWALLOW));
			object("_pills$65").addActionSuccess(new AlterKnowledge("there_are_pills_in_car"));
			object("_pills$65").addActionSuccess(new StartSlowMotion(0.01, 12));
			object("_pills$65").addActionSuccess(new RemoveInteractiveObject("_pills$65"));
			
			object("_bookshelf").setKnowledgeDependency("there_is_a_panic_room");
			object("_bookshelf").setItemDependency(Items.BOOK);
			object("_bookshelf").addActionNoItemNoKnowledge(new ShowPopUp(Items.BOOKSHELF, "bookshelf_nI_nK")); //
			object("_bookshelf").addActionNoItemNoKnowledge(new PlaySound(Sounds.TAKING_THING));
			object("_bookshelf").addActionNoItem(new ShowPopUp(Items.BOOKSHELF,"book_shelf_nI"));
			object("_bookshelf").addActionNoItem(new PlaySound(Sounds.TAKING_THING));
			object("_bookshelf").addActionNoItem(new AlterKnowledge("i_need_a_book"));
			object("_bookshelf").addActionSuccess(new ShowPopUp(Items.BOOKSHELF, "book_shelf"));
			object("_bookshelf").addActionSuccess(new PlaySound(Sounds.DOOR_IRON));
			object("_bookshelf").addActionSuccess(new AlterKnowledge("i_need_the_secret_code"));
			object("_bookshelf").addActionSuccess(new RemoveItemFromInventory(Items.BOOK));
			object("_bookshelf").addActionSuccess(new ObjectToggleInteraction("_secretDoor", true)); // Enable secret door now
			object("_bookshelf").addActionSuccess(new RemoveInteractiveObject("_bookshelf"));
			
			object("_secretDoor").enableInteractions = false; // Initially disabled to avoid conflicts with the bookshelf
			object("_secretDoor").setKnowledgeDependency("the_secret_code_is_1234");
			object("_secretDoor").addActionSuccess(new ShowPopUp(Items.SECRET_DOOR, "secretdoor"));
			object("_secretDoor").addActionSuccess(new PlaySound(Sounds.DOOR_HEAVY));
			object("_secretDoor").addActionSuccess(new ChangeCollision("library_secret_door", false));
			object("_secretDoor").addActionSuccess(new RemoveInteractiveObject("_secretDoor"));
			
			//object("_picture$80").setKnowledgeDependency("cat_has_antidote");
			//object("_picture$80").addActionNoItemNoKnowledge(new ShowPopUp(Items.PICTURE, "picture_nI_nK"));
			object("_picture$80").addActionSuccess(new ShowPopUp(Items.PICTURE, "picture"));
			object("_picture$80").addActionSuccess(new PlaySound(Sounds.GIRL_LAUGH_REVERB));
			object("_picture$80").addActionSuccess(new AlterKnowledge("catnip_attracts_cat"));
			
			object("_book").setKnowledgeDependency("i_need_a_book");
			object("_book").addActionNoItemNoKnowledge(new ShowPopUp(Items.BOOK, "book_nI_nK")); //
			//object("_book").addActionNoItem(new ShowPopUp(Items.BOOK, "book_nI")); // jorl?
			object("_book").addActionSuccess(new PlaySound(Sounds.NOTE));
			object("_book").addActionSuccess(new ShowPopUp(Items.BOOK, "book"));
			object("_book").addActionSuccess(new PlaySound(Sounds.NOTE));
			object("_book").addActionSuccess(new AddItemToInventory(Items.BOOK));
			object("_book").addActionSuccess(new RemoveInteractiveObject("_book"));
			
			object("_catfood").setKnowledgeDependency("catnip_attracts_cat");
			object("_catfood").addActionNoItemNoKnowledge(new ShowPopUp(Items.CATNIP, "catfood_nI")); //
			object("_catfood").addActionNoItemNoKnowledge(new PlaySound(Sounds.TIN_CAN));
			object("_catfood").addActionSuccess(new ShowPopUp(Items.CATNIP, "catnip"));
			object("_catfood").addActionSuccess(new PlaySound(Sounds.TIN_CAN));
			object("_catfood").addActionSuccess(new AddItemToInventory(Items.CATNIP));
			object("_catfood").addActionSuccess(new RemoveInteractiveObject("_catfood"));
			
			object("_camera1").addActionSuccess(new ShowPopUp(Items.CAMERA, "security_camera"));
			object("_camera1").addActionSuccess(new AlterKnowledge("there_is_a_panic_room"));
			object("_camera1").addActionSuccess(new PlaySound(Sounds.VIDEO_ONOFF));
			
			// CINEMATIC
			object("_videoWall").addActionSuccess(new PlayFlashbackCinematic(HUD.CINEMATIC_CAMERA_RECORDINGS));
			//object("_videoWall").addActionSuccess(new ShowPopUp(Items.VIDEO_WALL, "video_wall"));
			object("_videoWall").addActionSuccess(new AlterKnowledge("cat_has_antidote"));
			object("_videoWall").addActionSuccess(new PlaySound(Sounds.TV_NOISE));
			
			object("_fireplace").addActionSuccess(new ShowDialog(TextManager.get().getDialogById("_fireplace")));
			object("_bathtub$80").addActionSuccess(new ShowDialog(TextManager.get().getDialogById("_bathtub$80")));
			object("_kitchen").addActionSuccess(new ShowDialog(TextManager.get().getDialogById("_kitchen")));
			object("_clock$50").addActionSuccess(new ShowDialog(TextManager.get().getDialogById("_clock$50")));
			object("_kitchenTable").addActionSuccess(new ShowDialog(TextManager.get().getDialogById("_kitchenTable")));
			object("_chair").addActionSuccess(new ShowDialog(TextManager.get().getDialogById("_chair")));
		}
	}

}