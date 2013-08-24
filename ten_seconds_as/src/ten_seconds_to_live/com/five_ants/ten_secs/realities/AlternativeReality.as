package ten_seconds_to_live.com.five_ants.ten_secs.realities 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import ten_seconds_to_live.com.five_ants.ten_secs.Camera;
	import ten_seconds_to_live.com.five_ants.ten_secs.Entity;
	import ten_seconds_to_live.com.five_ants.ten_secs.GameMap;
	import ten_seconds_to_live.com.five_ants.ten_secs.GameplayState;
	import ten_seconds_to_live.com.five_ants.ten_secs.Player;
	import ten_seconds_to_live.com.five_ants.ten_secs.RoomUtils;
	import ten_seconds_to_live.com.five_ants.ten_secs.WallCollisions;
	/**
	 * ...
	 * @author Miguel Santirso
	 */
	public class AlternativeReality extends Sprite
	{
		private var _config:IRealityConfig;
		private var _gameplay:GameplayState;
		
		private var _player:Player;
		private var _entities:Vector.<Entity> = new Vector.<Entity>();
		private var _camera:Camera;
		private var _gameMap:GameMap;
		private var _collisions:WallCollisions;
		private var _roomUtils:RoomUtils;
		
		private var _sceneContainer:Sprite;
		
		public function AlternativeReality(config:IRealityConfig)
		{
			_config = config;
		}
		
		public function init(refToGameplay:GameplayState):void
		{
			_gameplay = refToGameplay;
			
			_camera = new Camera();
			
			_collisions = new WallCollisions();
			var collisionsSprite:Sprite = _config.constructHouseCollisions();
			_collisions.setCollisions(collisionsSprite);
			collisionsSprite.visible = false;
			addChild(collisionsSprite); // needs to be in the display list for the hit test to work
			
			var floors:Sprite = _config.constructFloors();
			_roomUtils = new RoomUtils();
			_roomUtils.setRoomShapes(floors);
			
			_player = _config.constructPlayer();
			_player.x = 300; _player.y = 400;
			_camera.target = _player;
			_entities.push(_player);
			
			_gameMap = new GameMap(_config.constructVisualGameMap());
			_gameMap.init();
			_gameMap.addChild(_player);
			
			for each (var entity:Entity in _entities)
				entity.load(_gameplay);
			
			_sceneContainer = new Sprite();
			addChild(_sceneContainer);
			_camera.sceneContainer = _sceneContainer;
			
			_sceneContainer.addChild(floors);
			_sceneContainer.addChild(_gameMap.world);
		}
		
		
		public function update():void
		{
			for each (var entity:Entity in _entities)
				entity.update();
			
			_gameMap.update();
			
			_camera.update();
		}
		
		
		public function dispose():void
		{
			_gameMap.dispose();
			
			for each (var entity:Entity in _entities)
				entity.dispose();
		}
		
		public function get roomUtils():RoomUtils 
		{
			return _roomUtils;
		}
		public function get collisions():WallCollisions 
		{
			return _collisions;
		}
		public function get gameMap():GameMap 
		{
			return _gameMap;
		}
		public function get camera():Camera 
		{
			return _camera;
		}
		public function get entities():Vector.<Entity> 
		{
			return _entities;
		}
		public function get player():Player 
		{
			return _player;
		}
	}

}