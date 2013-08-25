package ten_seconds_to_live.com.five_ants.ten_secs 
{
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Miguel Santirso
	 */
	public class PlayerKnowledge 
	{
		public static const KNOL_ss:int = "";
		
		private static var _knowledge:Dictionary = new Dictionary();
		
		public static function learnKnowledge(id:int):void
		{
			_knowledge[id] = true;
		}
		
		public static function getKnowledge(id:int):Boolean
		{
			return _knowledge[id];
		}
	}

}