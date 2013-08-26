package ten_seconds_to_live.com.five_ants.ten_secs.object_actions 
{
	import ten_seconds_to_live.com.five_ants.ten_secs.Sounds;
	
	/**
	 * ...
	 * @author Miguel Santirso
	 */
	public class StopSound extends ObjectActionBase 
	{
		private var _soundId:int;
		
		public function StopSound(soundId:int) 
		{
			_soundId = soundId;
		}
		
		
		public override function execute():void
		{
			Sounds.stopSoundById(_soundId);
		}
	}

}