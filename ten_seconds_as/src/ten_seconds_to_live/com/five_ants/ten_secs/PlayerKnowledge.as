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
	}

}