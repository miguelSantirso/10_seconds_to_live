package ten_seconds_to_live.com.five_ants.ten_secs.realities 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import ten_seconds_to_live.com.five_ants.ten_secs.Camera;
	import ten_seconds_to_live.com.five_ants.ten_secs.Entity;
	import ten_seconds_to_live.com.five_ants.ten_secs.GameMap;
	import ten_seconds_to_live.com.five_ants.ten_secs.GameplayState;
	import ten_seconds_to_live.com.five_ants.ten_secs.InteractiveObject;
	import ten_seconds_to_live.com.five_ants.ten_secs.Player;
	import ten_seconds_to_live.com.five_ants.ten_secs.RealityLogic;
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
		
		private var _realityLogic:RealityLogic;
		
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
			floors.visible = false;
			addChild(floors);
			
			_player = _config.constructPlayer();
			_player.x = 300; _player.y = 400;
			_camera.target = _player;
			_entities.push(_player);
			
			/// ALBERT TEST:
			_realityLogic = new RealityLogic();
			
			var testObject:InteractiveObject;
			for (var i:int = 0; i < 10; ++i)
			{
				testObject = new InteractiveObject("paco" + i, 100 * (i+1));
				
				_realityLogic.registerInteractiveEntity(testObject.getName(), testObject);
				_entities.push(testObject);
			}
			// FIN ALBERT TEST
			
			_gameMap = new GameMap(_config.constructVisualGameMap());
			_gameMap.init();
			_gameMap.addChild(_player);
			
			initInteractiveObjects();
			
			// TEST ALBERT:
			_gameMap.addChild(_realityLogic.findEntityByName("paco0"));
			_realityLogic.findEntityByName("paco0").x = 75;
			_realityLogic.findEntityByName("paco0").y = 250;
			_gameMap.addChild(_realityLogic.findEntityByName("paco1"));
			_realityLogic.findEntityByName("paco1").x = 1200;
			_realityLogic.findEntityByName("paco1").y = 450;
			
			// muestra los radios de todos los objetos interactivos:
			_realityLogic.showInteractionRadiuses = true;
			_realityLogic.enableAllInteractions = true;
			
			for each (var entity:Entity in _entities)
				entity.load(_gameplay);
			
			_sceneContainer = new Sprite();
			addChild(_sceneContainer);
			_camera.sceneContainer = _sceneContainer;
			
			_sceneContainer.addChild(_config.constructFloors());
			_sceneContainer.addChild(_gameMap.world);
		}
		
		private function initInteractiveObjects():void
		{
			for each(var object:MovieClip in _gameMap.world)
			{
				trace("OBJECT: " + object.name);
			}
		}
		
		public function update():void
		{
			for each (var entity:Entity in _entities)
				entity.update();
			
			_gameMap.update();
			
			_camera.update();
			
			_realityLogic.update(_player, _roomUtils, _gameplay.playerInput);
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