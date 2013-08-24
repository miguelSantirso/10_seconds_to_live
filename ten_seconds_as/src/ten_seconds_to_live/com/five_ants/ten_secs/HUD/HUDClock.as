package ten_seconds_to_live.com.five_ants.ten_secs.HUD 
{
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author 10 2  Live Team
	 */
	public class HUDClock extends HUDComponent 
	{
		public function HUDClock() 
		{
			_coreComponent = new CoreClock();
			
			super(_coreComponent);
		}
		
	}

}