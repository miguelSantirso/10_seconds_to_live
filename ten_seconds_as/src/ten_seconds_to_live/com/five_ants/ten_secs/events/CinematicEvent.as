package ten_seconds_to_live.com.five_ants.ten_secs.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Luis Miguel Blanco
	 */
	public class CinematicEvent extends Event 
	{
		protected var _cinematicType:String;
		
		public function CinematicEvent(cinematicType:String, type:String, bubbles:Boolean = false, cancelable:Boolean = false) 
		{
			super(type, bubbles, cancelable);
			
			_cinematicType = cinematicType;
		}
		
		public function get cinematicType():String 
		{
			return _cinematicType;
		}
		
		public function set cinematicType(value:String):void 
		{
			_cinematicType = value;
		}
		
	}

}