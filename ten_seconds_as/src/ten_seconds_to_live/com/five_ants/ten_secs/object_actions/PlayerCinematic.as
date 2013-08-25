package ten_seconds_to_live.com.five_ants.ten_secs.object_actions 
{
	import ten_seconds_to_live.com.five_ants.ten_secs.GameplayState;
	import ten_seconds_to_live.com.five_ants.ten_secs.realities.AlternativeReality;
	/**
	 * ...
	 * @author Miguel Santirso
	 */
	public class PlayerCinematic extends ObjectActionBase
	{
		private var _animation:int;
		
		public function PlayerCinematic(animationId:int) 
		{
			_animation = animationId;
		}
		
		
		public override function execute():void
		{
			AlternativeReality._gameplay.currentReality.player.playCinematic(_animation);
		}
		
	}

}