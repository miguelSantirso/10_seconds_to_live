package ten_seconds_to_live.com.five_ants.ten_secs.HUD 
{
	/**
	 * ...
	 * @author 10 2  Live Team
	 */
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class HUDCreditsPopUp extends HUDComponent 
	{	
		public static const CLOSE_REQUEST_EVENT:String = "closeCreditsRequestEvent";

		public function HUDCreditsPopUp() 
		{
			_coreComponent = new CoreCreditsPopUp();
			
			super(_coreComponent);
		}
		
		public override function init():void
		{
			super.init();
			
			coreComponent.closeButton.addEventListener(MouseEvent.CLICK, onCloseClick, false, 0, true);
		}
		
		public override function dispose():void
		{
			coreComponent.closeButton.removeEventListener(MouseEvent.CLICK, onCloseClick);
			
			super.dispose();
		}
		
		protected function get coreComponent():CoreCreditsPopUp
		{
			return _coreComponent as CoreCreditsPopUp;
		}
		
		public function onCloseClick(event:MouseEvent):void
		{
			dispatchEvent(new Event(CLOSE_REQUEST_EVENT));
		}
	}

}