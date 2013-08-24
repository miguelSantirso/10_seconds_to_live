package ten_seconds_to_live.com.five_ants.ten_secs.object_actions 
{
	import ten_seconds_to_live.com.five_ants.ten_secs.GameplayState;
	/**
	 * ...
	 * @author Miguel Santirso
	 */
	public class ObjectActionBase
	{
		protected var _gameplay:GameplayState;
		
		public function set gameplay(value:GameplayState):void
		{
			_gameplay = value;
		}
		
		public function execute():void {}
		
	}

}