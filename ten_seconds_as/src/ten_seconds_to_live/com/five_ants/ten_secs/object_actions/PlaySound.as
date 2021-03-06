package ten_seconds_to_live.com.five_ants.ten_secs.object_actions 
{
	import ten_seconds_to_live.com.five_ants.ten_secs.Sounds;
	
	/**
	 * ...
	 * @author Miguel Santirso
	 */
	public class PlaySound extends ObjectActionBase 
	{
		private var _soundId:int;
		private var _loops:int;
		
		public function PlaySound(soundId:int, loops:int = 1) 
		{
			_soundId = soundId;
			_loops = loops;
		}
		
		
		public override function execute():void
		{
			Sounds.playSoundById(_soundId, _loops);
		}
	}

}