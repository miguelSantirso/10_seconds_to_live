package ten_seconds_to_live.com.five_ants.ten_secs.HUD 
{
	/**
	 * ...
	 * @author 10 2  Live Team
	 */
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class HUDPauseMenu extends HUDComponent 
	{
		public static const RESUME_REQUEST_EVENT:String = "resumeRequestEvent";
		public static const CREDITS_REQUEST_EVENT:String = "creditsRequestEvent";
		
		public function HUDPauseMenu() 
		{
			_coreComponent = new CorePauseMenu();
			
			super(_coreComponent);
		}
		
		public override function init():void
		{
			super.init();
			
			coreComponent.resumeButton.addEventListener(MouseEvent.CLICK, onResumeClick, false, 0, true);
			coreComponent.creditsButton.addEventListener(MouseEvent.CLICK, onCreditsClick, false, 0, true);
		}
		
		public override function dispose():void
		{
			coreComponent.resumeButton.removeEventListener(MouseEvent.CLICK, onResumeClick);
			coreComponent.creditsButton.removeEventListener(MouseEvent.CLICK, onCreditsClick);
			
			super.dispose();
		}
		
		protected function get coreComponent():CorePauseMenu
		{
			return _coreComponent as CorePauseMenu;
		}
		
		protected function onResumeClick(event:MouseEvent):void
		{
			dispatchEvent(new Event(RESUME_REQUEST_EVENT));
		}
		
		protected function onCreditsClick(event:MouseEvent):void
		{
			dispatchEvent(new Event(CREDITS_REQUEST_EVENT));
		}
	}

}