package ten_seconds_to_live.com.five_ants.ten_secs 
{
	import flash.media.Sound;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	/**
	 * ...
	 * @author Miguel Santirso
	 */
	public class Sounds 
	{
		public static const BODY_FALLING:int = registerSound(Sound_BodyFalling, "BodyFalling");
		public static const BODY_FALLING_GRASS:int = registerSound(Sound_BodyFallingGrass, "BodyFallingGrass");
		public static const BREATHING_HEAVY:int = registerSound(Sound_BreathingHeavy, "BreathingHeavy");
		public static const BREATHING_DEEP:int = registerSound(Sound_BreathingDeep, "BreathingDeep");
		public static const CAT_ANGRY:int = registerSound(Sound_CatAngry, "CatAngry");
		public static const CAT_PURRING:int = registerSound(Sound_CatPurring, "CatPurring");
		public static const CLOSET_OPEN:int = registerSound(Sound_ClosetOpen, "ClosetOpen");
		public static const CLOSET_CLOSE:int = registerSound(Sound_ClosetClose, "ClosetClose");
		public static const CAR_DOOR_CLOSE:int = registerSound(Sound_CarDoorClose, "CarDoorClose");
		public static const DOOR_HEAVY:int = registerSound(Sound_DoorHeavy, "DoorHeavy");
		public static const DOOR_OPEN:int = registerSound(Sound_DoorOpen, "DoorOpen");
		public static const DOOR_IRON:int = registerSound(Sound_DoorIron, "DoorIron");
		public static const DOOR_CLOSE:int = registerSound(Sound_DoorClose, "DoorClose");
		public static const DRAWER_CLOSE:int = registerSound(Sound_DrawerClose, "DrawerClose");
		public static const DRAWER_OPEN:int = registerSound(Sound_DrawerOpen, "DrawerOpen");
		public static const DRAWER_CLOSE_2:int = registerSound(Sound_DrawerClose2, "DrawerClose2");
		public static const DYING:int = registerSound(Sound_Dying, "Dying");
		public static const FLASHBACK:int = registerSound(Sound_Flashback, "Flashback");
		public static const FOOTSTEP:int = registerSound(Sound_Footstep, "Footstep");
		public static const FOOTSTEPS_GARDEN:int = registerSound(Sound_FootstepsGarden, "FootstepsGarden");
		public static const FOOTSTEPS_INHOUSE:int = registerSound(Sound_FootstepsInhouse, "FootstepsInhouse");
		public static const GIRL_LAUGH_NORMAL:int = registerSound(Sound_GirlLaughNormal, "GirlLaughNormal");
		public static const GIRL_LAUGH_REVERB:int = registerSound(Sound_GirlLaughReverb, "GirlLaughReverb");
		public static const DOOR_CRASH:int = registerSound(Sound_DoorCrash, "DoorCrash");
		public static const GUN_SHOT:int = registerSound(Sound_GunShot, "GunShot");
		public static const GEAR:int = registerSound(Sound_Gear, "Gear");
		public static const GEAR_OPEN:int = registerSound(Sound_GearOpen, "GearOpen");
		public static const SIGH_MOVEMENT:int = registerSound(Sound_SighMovement, "SighMovement");
		public static const NOTE:int = registerSound(Sound_Note, "Note");
		public static const POT_OPENING:int = registerSound(Sound_PotOpening, "PotOpening");
		public static const PILLS:int = registerSound(Sound_Pills, "Pills");
		public static const PILLS2:int = registerSound(Sound_Pills2, "Pills2");
		public static const AMBIENT_LOOP:int = registerSound(Sound_AmbientLoop, "AmbientLoop");
		public static const SWALLOW:int = registerSound(Sound_Swallow, "Swallow");
		public static const TAKING_GUN:int = registerSound(Sound_TakingGun, "TakingGun");
		public static const TAKING_THING:int = registerSound(Sound_TakingThing, "TakingThing");
		public static const VIDEO_ONOFF:int = registerSound(Sound_VideoOnOff, "VideoOnOff");
		public static const VIDEO_SNAPSHOT:int = registerSound(Sound_VideoSnapshot, "VideoSnapshot");
		public static const LOCKED_DOOR:int = registerSound(Sound_LockedDoor, "LockedDoor");
		public static const CAR_UNLOCK:int = registerSound(Sound_CarUnlock, "CarUnlock");
		public static const BIRDS:int = registerSound(Sound_Birds, "Birds");
		public static const TIN_CAN:int = registerSound(Sound_TinCan, "TinCan");
		public static const TV_NOISE:int = registerSound(Sound_TVNoise, "TVNoise");
		
		private static var _soundsById:Vector.<Sound>;
		private static var _soundsByName:Dictionary;
		
		
		public static function playSoundById(id:int):void
		{
			_soundsById[id].play();
		}
		public static function playSoundByName(name:String):void
		{
			if (_soundsByName[name] == null)
				throw new Error("Sounds: Can't find sound with name " + name);
			
			_soundsByName[name].play();
		}
		
		private static function registerSound(soundClass:Class, name:String):int
		{
			if (!_soundsByName) _soundsByName = new Dictionary();
			if (!_soundsById) _soundsById = new Vector.<Sound>();
			
			if (_soundsByName[name])
				throw new Error("Sounds: More than one sound with the same name: " + name);
			
			var sound:Sound = new soundClass() as Sound;
			
			_soundsById[_soundsById.length] = sound;
			_soundsByName[name] = sound;
			
			return _soundsById.length - 1;
		}
		
	}

}