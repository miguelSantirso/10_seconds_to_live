package ten_seconds_to_live.com.five_ants.ten_secs 
{
	import flash.display.MovieClip;
	import flash.utils.Dictionary;
	import ten_seconds_to_live.com.five_ants.ten_secs.interfaces.IInitializable;
	import ten_seconds_to_live.com.five_ants.ten_secs.interfaces.IDisposable;
	import ten_seconds_to_live.com.five_ants.ten_secs.interfaces.IUpdateable;
	/**
	 * ...
	 * @author Miguel Santirso
	 */
	public class GameplayState extends IGameState implements IDisposable, IUpdateable
	{
		private var _player:Player;
		private var _entities:Vector.<Entity> = new Vector.<Entity>();
		
		private var _playerInput:IPlayerInput;
		protected var _gameMap:GameMap;
		
		protected override function init():void 
		{
			_playerInput = new KeyboardInput();
			_playerInput.init(_stage);
			
			_player = new Player();
			_player.x = 300; _player.y = 300;
			
			_entities.push(_player);
			
			for each (var entity:Entity in _entities)
				entity.load(this);
			
			_gameMap = new GameMap();
			_gameMap.init();
				
			addChild(_player);
			addChild(_gameMap);
		}
		
		public override function update():void 
		{
			for each (var entity:Entity in _entities)
				entity.update();
		}
		
		public override function dispose():void 
		{
			_gameMap.dispose();
			removeChild(_gameMap);
			
			// player
			_playerInput.dispose();
			
			for each (var entity:Entity in _entities)
				entity.dispose();
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