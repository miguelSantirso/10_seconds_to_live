package ten_seconds_to_live.com.five_ants.ten_secs.events 
{
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author ...
	 */
	public class Cat extends Entity
	{
		private var _visualObject:MovieClip = new cat();
		
		private var _currentState:String;
	
		public static const STATE_IDLE:String = "idle";
		public static const STATE_WANDER:String = "wander";
		
		public function Cat() 
		{
			addChild(_visualObject);
			
			_visualObject.x = 0;
			_visualObject.y = 0;
			
			changeState(STATE_WANDER);
		}
		
		public function changeState(newState:String):void
		{
			this[newState]();
			_currentState = newState;
			
			trace(">> CAT'S STATE CHANGED TO: " + newState);
		}
		
		private function idle():void
		{
			trace("idle");
		}
		
		private function wander():void
		{
			trace("wander");
		}
		
		override public function update():void 
		{
			super.update();
			
			switch(_currentState)
			{
				case STATE_WANDER:
					{
						_visualObject.x += 1;
						break;
					}
			}
		}
	}

}