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
		
		public override function init():void
		{
			super.init();
			
			coreComponent.background.gotoAndStop("normal");
		}
		
		public function set time(seconds:String):void
		{
			coreComponent.seconds.text = seconds;
		}
		
		public function get coreComponent():CoreClock
		{
			return _coreComponent as CoreClock;
		}
		
		public function set slowmo(isActive:Boolean):void
		{
			if (isActive)
				coreComponent.background.gotoAndStop("slowmo");
			else
				coreComponent.background.gotoAndStop("normal");
		}
	}

}