package ten_seconds_to_live.com.five_ants.ten_secs.object_actions 
{
	import ten_seconds_to_live.com.five_ants.ten_secs.GameplayState;
	/**
	 * ...
	 * @author Miguel Santirso
	 */
	public class TriggerFlashback extends ObjectActionBase
	{
		private var _flashbackName:String;
		
		public function TriggerFlashback(flashbackToTrigger:String, gamePlay:GameplayState)
		{
			super(gamePlay);
			
			_flashbackName = flashbackToTrigger;
		}
		
		public override function execute():void 
		{
			//_gameplay.changeToRealityWithName(_flashbackName);
		}
		
	}

}