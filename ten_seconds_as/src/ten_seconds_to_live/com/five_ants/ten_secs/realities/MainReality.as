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
			
			object("_roomTable").addActionSuccess(new ShowPopUp(Items.NOTE_AND_WATCH, "Piece Of Paper", "\"There�s a lethal poison spreading in your body. You�ll die at 15:00 because you�ll never find the antidote.\" There�s only 10 seconds left!"));
			object("_roomTable").addActionSuccess(new AlterKnowledge("going_to_die"));
			
			object("_window$30").addActionSuccess(new PlayerCinematic(Player.ANIM_JUMP_WINDOW), true);
			
			object("_gun").setKnowledgeDependency("going_to_die");
			object("_gun").addActionSuccess(new ShowPopUp(Items.GUN, "My Gun", "bla bla bla"));
			object("_gun").addActionSuccess(new AddItemToInventory(Items.GUN));
			
			object("_door").setItemDependency(Items.GUN);
			object("_door").addActionNoItem(new ShowPopUp(Items.GUN, "Locked Door", "Argh! The door is locked, I need something to open it!"));
			object("_door").addActionSuccess(new ShowPopUp(Items.GUN, "Door Open!", "I opened the door with the gun"));
			object("_door").addActionSuccess(new ChangeCollision("door", false));
			object("_door").addActionSuccess(new PlayerCinematic(Player.ANIM_SHOOTING));
			object("_door").addActionSuccess(new RemoveItemFromInventory(Items.GUN));
			
			object("_car").setKnowledgeDependency("there_are_pills_in_car");
			object("_car").addActionNoItemNoKnowledge(new ShowPopUp(Items.CAT, "My Car", "My car. The nearest hospital is too far away"));
			object("_car").addActionSuccess(new ShowPopUp(Items.MEDICATION, "Adrenaline Pills", "These pills help me move a lot faster!"));
			object("_car").addActionSuccess(new StartSlowMotion(0.2, 10));
			
			object("_statue").setKnowledgeDependency("i_need_the_secret_code");
			object("_statue").addActionNoItemNoKnowledge(new ShowPopUp(Items.STATUE, "Statue", "This is the statue I sent carving for our anniversary. There’s a date written on the foot. “February 16th.” Wasn’t she beautiful...?"));
			object("_statue").addActionSuccess(new ShowPopUp(Items.SECRET_KEY, "1234", "1234! That's the code"));
			object("_statue").addActionSuccess(new AlterKnowledge("the_secret_code_is_1234"));
			
			object("_pills").setKnowledgeDependency("going_to_die");
			object("_pills").addActionSuccess(new ShowPopUp(Items.MEDICATION, "Adrenaline Pills", "These pills help me move a lot faster. I think I have more in the trunk of my car!"));
			object("_pills").addActionSuccess(new AlterKnowledge("there_are_pills_in_car"));
			object("_pills").addActionSuccess(new StartSlowMotion(0.2, 10));
			
			object("_bookshelf").setKnowledgeDependency("there_is_a_panic_room");
			object("_bookshelf").setItemDependency(Items.BOOK);
			object("_bookshelf").addActionNoItemNoKnowledge(new ShowPopUp(Items.BOOK, "My Books", "A lot of books. I can't use them now..."));
			object("_bookshelf").addActionNoItem(new ShowPopUp(Items.BOOK, "My Books", "There's a book left! That's how the bookshelf opens"));
			object("_bookshelf").addActionSuccess(new ShowPopUp(Items.BOOK, "My Books", "Yes, the book opened the secret door"));
			object("_bookshelf").addActionSuccess(new RemoveItemFromInventory(Items.BOOK));
			
			object("_picture").addActionSuccess(new ShowPopUp(Items.PICTURE, "Family Photo", "There is catnip somewhere... The cat loves it"));
			object("_picture").addActionSuccess(new AlterKnowledge("catnip_attracts_cat"));
			
			object("_book").setKnowledgeDependency("there_is_a_panic_room");
			object("_book").addActionSuccess(new ShowPopUp(Items.BOOK, "Book", "Aha! This book opens the entrance to the panic room"));
			object("_book").addActionSuccess(new AddItemToInventory(Items.BOOK));
			
			object("_catfood").setKnowledgeDependency("catnip_attracts_cat");
			object("_catfood").addActionSuccess(new ShowPopUp(Items.CATNIP, "Catnip", "Here�s the Catnip!"));
			object("_catfood").addActionSuccess(new AddItemToInventory(Items.CATNIP));
			
			object("_camera1").addActionSuccess(new ShowPopUp(Items.CAMERA, "Camera", "Cameras! I remember now, we have a Panic Room behind the bookshelf in the living room... That will give me the answer!"));
			object("_camera1").addActionSuccess(new AlterKnowledge("there_is_a_panic_room"));
		}
	}

}