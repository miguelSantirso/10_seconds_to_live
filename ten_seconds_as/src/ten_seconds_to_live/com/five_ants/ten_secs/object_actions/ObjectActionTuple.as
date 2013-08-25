package ten_seconds_to_live.com.five_ants.ten_secs.object_actions 
{
	/**
	 * ...
	 * @author ...
	 */
	public class ObjectActionTuple
	{
		private var _action:ObjectActionBase;
		private var _repeteable:Boolean;
		
		private var _repeated:Boolean;
		
		public function ObjectActionTuple(action:ObjectActionBase, repeteable:Boolean = false) 
		{
			_action = action;
			_repeteable = repeteable;
			
			_repeated = false;
		}
		
		public function set repeated(value:Boolean):void
		{
			_repeated = value;
		}
		
		public function get action():ObjectActionBase
		{
			return _action;
		}
		
		public function get repeteable():Boolean
		{
			return _repeteable;
		}
		
		public function get repeated():Boolean
		{
			return _repeated;
		}
	}

}