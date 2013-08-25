package ten_seconds_to_live.com.five_ants.ten_secs.object_actions 
{
	/**
	 * ...
	 * @author Miguel Santirso
	 */
	public class StartSlowMotion extends ObjectActionBase 
	{
		
		public function StartSlowMotion() 
		{
		}
		
		public override function execute()
		{
			_gameplay.gameTime.startSlowmo();
		}
		
	}

}