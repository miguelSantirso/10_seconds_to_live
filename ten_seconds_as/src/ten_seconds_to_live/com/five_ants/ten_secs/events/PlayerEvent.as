package ten_seconds_to_live.com.five_ants.ten_secs.events 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author ...
	 */
	public class PlayerEvent extends Event
	{
		public static const CHANGED_ROOM:String = "changedRoom";
		
		public function PlayerEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false):void
		{
			super(type, bubbles, cancelable);
		}
		
	}

}