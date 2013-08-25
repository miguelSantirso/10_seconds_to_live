package ten_seconds_to_live.com.five_ants.ten_secs 
{
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Miguel Santirso
	 */
	public class KeyboardInput implements IPlayerInput 
	{
		private var _stage:Stage;
		
		private var _keysState:Dictionary = new Dictionary();
		
		public function init(stage:Stage):void
		{
			_stage = stage;
	
			_stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			
			enabled = true;
		}
		
		public function dispose():void
		{
			_stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			
			enabled = false;
		}
		
		public function get upPressed():Boolean 
		{
			return _keysState[38];
		}
		
		public function get downPressed():Boolean 
		{
			return _keysState[40];
		}
		
		public function get leftPressed():Boolean 
		{
			return _keysState[37];
		}
		
		public function get rightPressed():Boolean 
		{
			return _keysState[39];
		}
		
		public function get ePressed():Boolean
		{
			return _keysState[69]; //e
		}
		
		public function get spacebarPressed():Boolean
		{
			return _keysState[32];
		}
		
		public function get testPressed():Boolean 
		{
			return _keysState[84];//t
		}
		
		private function onKeyDown(e:KeyboardEvent):void
		{
			_keysState[e.keyCode] = true;
		}
		
		private function onKeyUp(e:KeyboardEvent):void
		{
			_keysState[e.keyCode] = false;
		}
		
		public function set enabled(value:Boolean):void
		{
			if (value)
			{
				_stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			}
			else
			{
				_stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			}
		}
		
	}

}