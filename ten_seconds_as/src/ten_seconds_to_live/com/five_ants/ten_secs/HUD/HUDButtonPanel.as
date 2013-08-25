package ten_seconds_to_live.com.five_ants.ten_secs.HUD 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author 10 2  Live Team
	 */
	public class HUDButtonPanel extends HUDComponent 
	{
		public static const PAUSE_REQUEST_EVENT:String = "pauseEventRequest";
		public static const KNOWLEDGE_REQUEST_EVENT:String = "knowledgeEventRequest";
		
		public function HUDButtonPanel() 
		{
			_coreComponent = new CoreActionButtons();
			
			super(_coreComponent);
		}
		
		public override function init():void
		{
			super.init();
			
			coreComponent.pauseButton.addEventListener(MouseEvent.CLICK, onPauseClick, false, 0, true);
			coreComponent.knowledgeButton.addEventListener(MouseEvent.CLICK, onKnowledgeClick, false, 0, true);
		}
		
		public override function dispose():void
		{
			coreComponent.pauseButton.removeEventListener(MouseEvent.CLICK, onPauseClick);
			coreComponent.knowledgeButton.removeEventListener(MouseEvent.CLICK, onKnowledgeClick);
			
			super.dispose();
		}
		
		public function get coreComponent():CoreActionButtons
		{
			return _coreComponent as CoreActionButtons;
		}
		
		protected function onPauseClick(event:MouseEvent):void
		{
			dispatchEvent(new Event(PAUSE_REQUEST_EVENT));
		}
		
		protected function onKnowledgeClick(event:MouseEvent):void
		{
			dispatchEvent(new Event(KNOWLEDGE_REQUEST_EVENT));
		}
	}

}