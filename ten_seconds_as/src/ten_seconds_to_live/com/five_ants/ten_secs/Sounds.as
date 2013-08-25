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
		public static const GUN_SHOT:int = registerSound(Sound_GunShot, "GunShot");
		public static const GIRL_LAUGH_REVERB:int = registerSound(Sound_GirlLaughReverb, "Sound_GirlLaughReverb");
		
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