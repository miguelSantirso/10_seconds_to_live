package ten_seconds_to_live.com.five_ants.ten_secs 
{
	import flash.display.Sprite;
	import flash.display.Stage;
	
	/**
	 * @author Miguel Santirso
	 */
	public class TenSecsMain extends Sprite 
	{
		private var _currentState:IGameState;
		
		private var _stage:Stage;
		
		public function TenSecsMain(stage:Stage):void
		{
			_stage = stage;
		}
		
		public function update():void
		{
			if (_currentState)
				_currentState.update();
		}
		
		
		public function changeState(newState:IGameState):void
		{
			if (_currentState)
			{
				removeChild(_currentState);
				_currentState.dispose();
			}
			
			_currentState = newState;
			
			_currentState.load(this, _stage);
			addChild(_currentState);
		}
	}

}