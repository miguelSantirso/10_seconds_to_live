package ten_seconds_to_live.com.five_ants.ten_secs 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
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
		
		private var _sceneContainer:Sprite;
		private var _playerInput:IPlayerInput;
		private var _camera:Camera;
		protected var _gameMap:GameMap;
		private var _collisions:WallCollisions;
		private var _roomUtils:RoomUtils;
		
		protected override function init():void 
		{
			_playerInput = new KeyboardInput();
			_playerInput.init(_stage);
			
			_camera = new Camera();
			
			_collisions = new WallCollisions();
			var spCollisions:Sprite = new HouseCollisions();
			_collisions.setCollisions(spCollisions);
			
			var floors:Sprite = new Floors();
			_roomUtils = new RoomUtils();
			_roomUtils.setRoomShapes(floors);
			
			_player = new Player();
			_player.x = 300; _player.y = 400;
			
			_camera.target = _player;
			
			_entities.push(_player);
			
			for each (var entity:Entity in _entities)
				entity.load(this);
			
			_gameMap = new GameMap();
			_gameMap.init();
			_gameMap.addChild(_player);
			
			_sceneContainer = new Sprite();
			addChild(_sceneContainer);
			_camera.sceneContainer = _sceneContainer;
			
			_sceneContainer.addChild(floors);
			_sceneContainer.addChild(_gameMap);
			
			spCollisions.visible = false;
			addChild(spCollisions);// needs to be in the display list for the hit test to work
		}
		
		public override function update():void 
		{
			for each (var entity:Entity in _entities)
				entity.update();
				
			_gameMap.update();
			
			_camera.update();
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
		public function get collisions():WallCollisions
		{
			return _collisions;
		}
		public function get roomUtils():RoomUtils
		{
			return _roomUtils;
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