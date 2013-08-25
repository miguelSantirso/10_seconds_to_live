package ten_seconds_to_live.com.five_ants.ten_secs 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import ten_seconds_to_live.com.five_ants.ten_secs.interfaces.IUpdateable;
	/**
	 * ...
	 * @author 10 2  Live Team
	 */
	public class GameTime extends EventDispatcher implements IUpdateable
	{
		public static const TIMEUP_EVENT:String = "timeupEvent";
		public static const SLOWMO_START_EVENT:String = "slowmoStartEvent";
		public static const SLOWMO_END_EVENT:String = "slowmoEndEvent";
		
		protected var _time:Number;
		protected var _timeDefault:Number;
		
		protected var _timeSpeed:Number;
		protected var _timeSpeedDefault:Number;
		protected var _timeSpeedSlowmo:Number;
		
		protected var _slowmoTime:Number;
		protected var _slowmoDefault:Number;
		protected var _slowmoSpeed:Number;
		
		public function GameTime(timeDefault:Number = 10.0, slowmoRate:Number = 0.1, slowmoDefault:Number = 10.0) 
		{
			_timeDefault = timeDefault;
			_time = _timeDefault;
			
			// speed
			_timeSpeedDefault = 1.0 / 30.0; // fps
			_timeSpeedSlowmo =  _timeSpeedDefault * slowmoRate;
			_timeSpeed = _timeSpeedDefault;
			
			// slowmo
			_slowmoDefault = slowmoDefault;
			_slowmoSpeed = 1.0 / 30.0;
			_slowmoTime = 0.0;
			
			restart();
		}
		
		public function restart():void 
		{
			_time = _timeDefault;
			_timeSpeed = _timeSpeedDefault;
			_slowmoTime = 0.0;
		}
		
		public function update():void
		{
			if(_time > 0.0)
				_time -= _timeSpeed;
			
			if (_slowmoTime > 0) {
				if (_slowmoTime >= _slowmoDefault)
					_timeSpeed = _timeSpeedSlowmo;
					
				_slowmoTime -= _slowmoSpeed;
				
				if (_slowmoTime <= 0) {
					_slowmoTime = 0;
					_timeSpeed = _timeSpeedDefault;
					dispatchEvent(new Event(SLOWMO_END_EVENT));
				}
			}
			
			if (_time <= 0.0) {
				_time = 0.0;
				dispatchEvent(new Event(TIMEUP_EVENT));
			}
		}
		
		public function startSlowmo():void
		{
			_slowmoTime = _slowmoDefault;
			dispatchEvent(new Event(SLOWMO_START_EVENT));
		}
		
		public function get seconds():String
		{
			return _time.toPrecision(2);
		}
		
		public function get slowmoActive():Boolean
		{
			return _slowmoTime > 0.0;
		}
	}

}