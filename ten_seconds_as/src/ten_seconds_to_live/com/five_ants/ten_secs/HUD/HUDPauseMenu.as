package ten_seconds_to_live.com.five_ants.ten_secs.HUD 
{
	/**
	 * ...
	 * @author 10 2  Live Team
	 */
	import flash.events.Event;
	import ten_seconds_to_live.com.five_ants.ten_secs.GameplayState;
	
	public class HUDPauseMenu extends HUDComponent 
	{
		public static const RESUME_REQUEST_EVENT:String = "resumeRequestEvent";
		public static const CREDITS_REQUEST_EVENT:String = "creditsRequestEvent";
		
		protected var _cPressed:Boolean = false;
		
		public function HUDPauseMenu() 
		{
			_coreComponent = new CorePauseMenu();
			
			super(_coreComponent);
		}
		
		public override function init():void
		{
			super.init();
		}
		
		public override function dispose():void
		{
			super.dispose();
		}
		
		public override function update():void
		{
			super.update();
			
			if (!_cPressed && GameplayState.playerInput.cPressed) {
				onCredits();
				_cPressed = true;
			}else if (!GameplayState.playerInput.cPressed)
				_cPressed = false;
		}
		
		protected function get coreComponent():CorePauseMenu
		{
			return _coreComponent as CorePauseMenu;
		}
		
		protected function onResumeClick():void
		{
			dispatchEvent(new Event(RESUME_REQUEST_EVENT));
		}
		
		protected function onCredits():void
		{
			dispatchEvent(new Event(CREDITS_REQUEST_EVENT));
		}
	}

}