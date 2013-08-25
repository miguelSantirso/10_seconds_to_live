package ten_seconds_to_live.com.five_ants.ten_secs.object_actions 
{
	import ten_seconds_to_live.com.five_ants.ten_secs.GameplayState;
	/**
	 * ...
	 * @author Miguel Santirso
	 */
	public class TriggerFlashback extends ObjectActionBase
	{
		private var _flashbackId:int;
		
		public function TriggerFlashback(flashbackToTrigger:int, gamePlay:GameplayState)
		{
			super(gamePlay);
			
			_flashbackId = flashbackToTrigger;
		}
		
		public override function execute():void 
		{
			_gameplay.changeToReality(_flashbackName);
		}
		
	}

}