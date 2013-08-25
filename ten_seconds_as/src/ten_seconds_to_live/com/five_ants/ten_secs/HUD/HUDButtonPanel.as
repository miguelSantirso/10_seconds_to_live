package ten_seconds_to_live.com.five_ants.ten_secs.HUD 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import ten_seconds_to_live.com.five_ants.ten_secs.GameplayState;
	/**
	 * ...
	 * @author 10 2  Live Team
	 */
	public class HUDButtonPanel extends HUDComponent 
	{
		public static const PAUSE_REQUEST_EVENT:String = "pauseEventRequest";
		public static const KNOWLEDGE_REQUEST_EVENT:String = "knowledgeEventRequest";
		
		protected var _pPressed:Boolean = false;
		protected var _fPressed:Boolean = false;
		
		public function HUDButtonPanel() 
		{
			_coreComponent = new CoreActionButtons();
			
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
			
			if (!_pPressed && GameplayState.playerInput.pPressed) {
				onPause();
				_pPressed = true;
			}else if (!_fPressed && GameplayState.playerInput.fPressed) {
				onKnowledge();
				_fPressed = true;
			} 
			
			if (_pPressed && !GameplayState.playerInput.pPressed)
				_pPressed = false;
						
			if (_fPressed && !GameplayState.playerInput.fPressed)
				_fPressed = false;
		}
		
		public function get coreComponent():CoreActionButtons
		{
			return _coreComponent as CoreActionButtons;
		}
		
		protected function onPause():void
		{
			dispatchEvent(new Event(PAUSE_REQUEST_EVENT));
		}
		
		protected function onKnowledge():void
		{
			dispatchEvent(new Event(KNOWLEDGE_REQUEST_EVENT));
		}
	}

}