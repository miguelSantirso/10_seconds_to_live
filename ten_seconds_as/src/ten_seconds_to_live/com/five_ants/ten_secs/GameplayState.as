package ten_seconds_to_live.com.five_ants.ten_secs 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.utils.Dictionary;
	import ten_seconds_to_live.com.five_ants.ten_secs.interfaces.IInitializable;
	import ten_seconds_to_live.com.five_ants.ten_secs.interfaces.IDisposable;
	import ten_seconds_to_live.com.five_ants.ten_secs.interfaces.IUpdateable;
	import ten_seconds_to_live.com.five_ants.ten_secs.realities.MainReality;
	
	import ten_seconds_to_live.com.five_ants.ten_secs.realities.AlternativeReality;
	
	/**
	 * ...
	 * @author Miguel Santirso
	 */
	public class GameplayState extends IGameState implements IDisposable, IUpdateable
	{
		public static const REALITY_MAIN:int = 0;
		
		private var _playerInput:IPlayerInput;
		
		private var _realities:Vector.<AlternativeReality> = new Vector.<AlternativeReality>();
		private var _currentReality:int = -1;
		
		private var _gameTime:GameTime;
		private var _timeTextField:TextField;
		
		private var _interactiveObjects:Vector.<InteractiveObject> = new Vector.<InteractiveObject>();
		
		protected override function init():void 
		{
			_gameTime = new GameTime();
			_timeTextField = new TextField();
			
			_playerInput = new KeyboardInput();
			_playerInput.init(_stage);
			
			// Set up realities, push in order to vector
			_realities.push(new AlternativeReality(new MainReality()));
			
			for (var reality:AlternativeReality in _realities)
				reality.init(this);
			
			changeToReality(REALITY_MAIN);
			
			
			// HUD
			_timeTextField.x = _timeTextField.y = 10;
			addChild(_timeTextField);
		}
		
		public override function update():void 
		{
			currentReality.update();
			
			_gameTime.update();
			_timeTextField.text = String(_gameTime.seconds);
			
			// test
			if (!_gameTime.slowmoActive && _playerInput.testPressed)
				_gameTime.startSlowmo();
		}
		
		public override function dispose():void 
		{
			_playerInput.dispose();
			
			for each (var reality:AlternativeReality in _realities)
				reality.dispose();
		}
		
		public function changeToReality(reality:int):void
		{
			if (_currentReality >= 0)
			{
				removeChild(currentReality);
				//currentReality.dispose();
			}
			
			_currentReality = reality;
			
			//currentReality.init(this);
			addChild(currentReality);
		}
		
		public function get currentReality():AlternativeReality
		{
			return _realities[_currentReality];
		}
		
		public function get playerInput():IPlayerInput
		{
			return _playerInput;
		}
		
		// Temp
		protected function traceRoomElements(roomElements:Vector.<MovieClip>):void
		{
			for (var j:int = 0; j < roomElements.length; j++) {
				trace(roomElements[j].name);
			}
		}
	}

}