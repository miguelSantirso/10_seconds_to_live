package ten_seconds_to_live.com.five_ants.ten_secs.object_actions 
{
	import ten_seconds_to_live.com.five_ants.ten_secs.realities.AlternativeReality;
	/**
	 * ...
	 * @author Luis Miguel Blanco
	 */
	public class PlayFlashbackCinematic extends ObjectActionBase 
	{
		private var _cinematicId:String;
		
		public function PlayFlashbackCinematic(cinematicId:String) 
		{
			_cinematicId = cinematicId;
		}
		
		public override function execute():void
		{
			AlternativeReality._gameplay.hud.launchCinematic(_cinematicId);
		}
		
	}

}