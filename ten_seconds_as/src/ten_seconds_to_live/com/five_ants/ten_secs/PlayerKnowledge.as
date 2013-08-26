package ten_seconds_to_live.com.five_ants.ten_secs 
{
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Miguel Santirso
	 */
	public class PlayerKnowledge 
	{
		private static var _knownThings:Vector.<String> = new Vector.<String>();
		private static var _previousActions:Dictionary = new Dictionary();
		
		public static const ACTION_NOI_NOK:String = "noinok";
		public static const ACTION_NO_ITEM:String = "noitem";
		public static const ACTION_SUCCESS:String = "success";
		
		// -- Knowledge:
		
		public static function learnKnowledge(id:String):void
		{
			if (_knownThings.indexOf(id) < 0)
				_knownThings.push(id);
		}
		
		public static function getKnowledge(id:String):Boolean
		{
			return _knownThings.indexOf(id) >= 0;
		}
		
		public static function getEverythingThePlayerKnows():Vector.<String>
		{
			return _knownThings;
		}
		
		/*// --- Successfully done actions:
		public static function updateAction(id:String, action:String):void
		{
			_interactedItems[id] = action;
		}
		
		public static function getItemState(id:String):String
		{
			return _interactedItems[id];
		}*/
		
	}

}