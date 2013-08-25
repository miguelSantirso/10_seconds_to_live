package ten_seconds_to_live.com.five_ants.ten_secs.HUD 
{
	/**
	 * ...
	 * @author 10 2  Live Team
	 */
	
	import flash.events.Event;
	import ten_seconds_to_live.com.five_ants.ten_secs.GameplayState;
	
	public class HUDCreditsPopUp extends HUDComponent 
	{	
		public static const CLOSE_REQUEST_EVENT:String = "closeCreditsRequestEvent";

		protected var _ePressed:Boolean = false;
		
		public function HUDCreditsPopUp() 
		{
			_coreComponent = new CoreCreditsPopUp();
			
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
			
			if (!_ePressed && GameplayState.playerInput.ePressed) {
				onClose();
				_ePressed = true;
			}else if (!GameplayState.playerInput.ePressed)
				_ePressed = false;
		}
		
		protected function get coreComponent():CoreCreditsPopUp
		{
			return _coreComponent as CoreCreditsPopUp;
		}
		
		public function onClose():void
		{
			dispatchEvent(new Event(CLOSE_REQUEST_EVENT));
		}
	}

}