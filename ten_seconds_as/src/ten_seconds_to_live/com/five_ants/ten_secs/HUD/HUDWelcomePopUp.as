package ten_seconds_to_live.com.five_ants.ten_secs.HUD 
{
	/**
	 * ...
	 * @author 10 2  Live Team
	 */
	import flash.events.Event;
	import ten_seconds_to_live.com.five_ants.ten_secs.GameplayState;
	
	public class HUDWelcomePopUp extends HUDComponent 
	{
		public static const CLOSE_REQUEST_EVENT:String = "closeWelcomeRequestEvent";

		protected var _ePressed:Boolean = false;
		
		public function HUDWelcomePopUp() 
		{
			_coreComponent = new CoreWelcomePopUp();
			
			super(_coreComponent);
		}
		
		public override function update():void
		{
			super.update();
			
			if (!_ePressed && GameplayState.playerInput.shouldTakeAction()) {
				onClose();
				_ePressed = true;
			}else if (!GameplayState.playerInput.shouldTakeAction())
				_ePressed = false;
		}
		
		protected function get coreComponent():CoreWelcomePopUp
		{
			return _coreComponent as CoreWelcomePopUp;
		}
		
		public function onClose():void
		{
			dispatchEvent(new Event(CLOSE_REQUEST_EVENT));
		}
	}

}