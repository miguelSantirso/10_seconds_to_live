package ten_seconds_to_live.com.five_ants.ten_secs 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.utils.Dictionary;
	import ten_seconds_to_live.com.five_ants.ten_secs.events.InteractiveObjectEvent;
	import ten_seconds_to_live.com.five_ants.ten_secs.HUD.HUD;
	import ten_seconds_to_live.com.five_ants.ten_secs.HUD.HUDClock;
	import ten_seconds_to_live.com.five_ants.ten_secs.HUD.HUDInventory;
	import ten_seconds_to_live.com.five_ants.ten_secs.HUD.HUDItemPopUp;
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
		
		protected var _hud:HUD;
		
		// time
		private var _gameTime:GameTime;
		
		private var _interactiveObjects:Vector.<InteractiveObject> = new Vector.<InteractiveObject>();
		
		private var _realityLogic:RealityLogic;
		private var _currentRoom:String;
		private var newRoom:String;
		
		protected override function init():void 
		{
			// time
			_gameTime = new GameTime();
			_gameTime.addEventListener(GameTime.TIMEUP_EVENT, onTimeUp, false, 0, true);
			_gameTime.addEventListener(GameTime.SLOWMO_START_EVENT, onSlowmoStart, false, 0, true);
			_gameTime.addEventListener(GameTime.SLOWMO_END_EVENT, onSlowmoEnd, false, 0, true);
			
			_playerInput = new KeyboardInput();
			_playerInput.init(_stage);
			
			// Set up realities, push in order to vector
			_realities.push(new AlternativeReality(new MainReality()));
			
			for each (var reality:AlternativeReality in _realities)
				reality.init(this);
			
			changeToReality(REALITY_MAIN);
			
			_hud = new HUD();
			_hud.init();
			addChild(_hud);
		}
		
		public override function update():void 
		{
			currentReality.update();
			
			_gameTime.update();
			
			_hud.time = _gameTime.seconds;
			_hud.update();
			
			newRoom = currentReality.roomUtils.getRoomByPosition(currentReality.player.x, currentReality.player.y);
			if (newRoom != _currentRoom)
			{
				trace("** room: " + newRoom);
			}
			_currentRoom = newRoom;
			
			/*// test
			if (!_gameTime.slowmoActive && _playerInput.testPressed){
				_gameTime.startSlowmo();
				_hud.openKnowledgeList(null);
			}*/
		}
		
		public override function dispose():void 
		{
			_playerInput.dispose();
			
			for each (var reality:AlternativeReality in _realities)
				reality.dispose();
				
			// hud
			_hud.dispose();
			
			_gameTime.removeEventListener(GameTime.TIMEUP_EVENT, onTimeUp);
			_gameTime.removeEventListener(GameTime.SLOWMO_START_EVENT, onSlowmoStart);
			_gameTime.removeEventListener(GameTime.SLOWMO_END_EVENT, onSlowmoEnd);
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
		public function get hud():HUD 
		{
			return _hud;
		}
		public function get gameTime():GameTime 
		{
			return _gameTime;
		}
		
		
		
		protected function onTimeUp(e:Event):void 
		{
			// game over
		}
		
		public function onSlowmoStart(e:Event):void
		{
			_hud.slowmo = true;
		}
		
		public function onSlowmoEnd(e:Event):void
		{
			_hud.slowmo = false;
			
			_hud.closeKnowledgeList();
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