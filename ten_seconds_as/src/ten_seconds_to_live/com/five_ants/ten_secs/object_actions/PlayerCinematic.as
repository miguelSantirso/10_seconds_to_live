package ten_seconds_to_live.com.five_ants.ten_secs.object_actions 
{
	/**
	 * ...
	 * @author Miguel Santirso
	 */
	public class PlayerCinematic extends ObjectActionBase 
	{
		private var _animation:String;
		
		public function PlayerCinematic(animationName:String) 
		{
			_animation = animationName;
		}
		
		
		public override function execute():void
		{
			_gameplay.currentReality.player.playCinematic(_animation);
		}
		
	}

}