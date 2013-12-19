package ten_seconds_to_live.com.five_ants.ten_secs.HUD 
{
	/**
	 * ...
	 * @author 10 2  Live Team
	 */
	import flash.events.Event;
	import ten_seconds_to_live.com.five_ants.ten_secs.GameplayState;
	
	public class HUDFreeWalkPopUp extends HUDComponent 
	{
		public static const CLOSE_REQUEST_EVENT:String = "closeFreewalkRequestEvent";

		protected var _ePressed:Boolean = false;
		
		public function HUDFreeWalkPopUp() 
		{
			_coreComponent = new CoreFreeWalkPopUp();
			
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
		
		protected function get coreComponent():CoreFreeWalkPopUp
		{
			return _coreComponent as CoreFreeWalkPopUp;
		}
		
		public function onClose():void
		{
			dispatchEvent(new Event(CLOSE_REQUEST_EVENT));
		}
	}

}