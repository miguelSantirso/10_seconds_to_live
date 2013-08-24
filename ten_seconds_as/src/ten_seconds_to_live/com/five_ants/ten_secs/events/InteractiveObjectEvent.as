package ten_seconds_to_live.com.five_ants.ten_secs.events 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author ...
	 */
	public class InteractiveObjectEvent extends Event
	{
		public static const DO_ACTION:String = "do_action";
		
		public function InteractiveObjectEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false):void
		{
			super(type, bubbles, cancelable);
			
			
		}
		
	}

}