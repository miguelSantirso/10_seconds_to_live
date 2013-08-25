package ten_seconds_to_live.com.five_ants.ten_secs.object_actions 
{
	/**
	 * ...
	 * @author Miguel Santirso
	 */
	public class StartSlowMotion extends ObjectActionBase 
	{
		private var _slowMoRate:Number;
		private var _slowMoDuration:Number;
		
		public function StartSlowMotion(rate:Number, duration:Number) 
		{
			_slowMoRate = rate;
			_slowMoDuration = duration;
		}
		
		public override function execute():void
		{
			_gameplay.gameTime.startSlowmo(_slowMoRate, _slowMoDuration);
		}
		
	}

}