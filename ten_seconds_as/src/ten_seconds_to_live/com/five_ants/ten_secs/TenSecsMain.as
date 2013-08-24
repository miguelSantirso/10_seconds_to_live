package ten_seconds_to_live.com.five_ants.ten_secs 
{
	import flash.display.Sprite;
	
	/**
	 * @author Miguel Santirso
	 */
	public class TenSecsMain extends Sprite 
	{
		private var _currentState:IGameState;
		
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
			
			_currentState.load(this);
			addChild(_currentState);
		}
	}

}