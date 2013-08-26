package ten_seconds_to_live.com.five_ants.ten_secs.object_actions 
{
	import ten_seconds_to_live.com.five_ants.ten_secs.realities.AlternativeReality;
	
	/**
	 * ...
	 * @author Miguel Santirso
	 */
	public class ShowClock extends ObjectActionBase 
	{
		
		public override function execute():void
		{
			AlternativeReality._gameplay.hud.setClockVisibility(true);
		}
		
	}

}