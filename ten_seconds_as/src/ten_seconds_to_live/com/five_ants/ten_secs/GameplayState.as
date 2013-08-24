package ten_seconds_to_live.com.five_ants.ten_secs 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.text.TextField;
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
		private var _gameTime:GameTime;
		private var _timeTextField:TextField;
		
		private var _playerInput:IPlayerInput;
		
		private var _player:Player;
		private var _interactiveObjects:Vector.<InteractiveObject> = new Vector.<InteractiveObject>();
		private var _entities:Vector.<Entity> = new Vector.<Entity>();

		private var _sceneContainer:Sprite;
		private var _camera:Camera;
		protected var _gameMap:GameMap;
		private var _collisions:WallCollisions;
		private var _roomUtils:RoomUtils;
		
		protected override function init():void 
		{
			_gameTime = new GameTime();
			_timeTextField = new TextField();
			
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
			
			// TEST:
			for (var i:int = 0; i < 10; ++i)
			{
				_interactiveObjects.push(new InteractiveObject());
				_interactiveObjects[i].x = 50;
				_interactiveObjects[i].y = 250;
			}
			// FIN TEST
			
			for (i = 0; i < _interactiveObjects.length; ++i)	
			{
				_entities.push(_interactiveObjects[i]);
			}
			
			for each (var entity:Entity in _entities)
				entity.load(this);
			
			_gameMap = new GameMap(new VisualGameMap());
			_gameMap.init();
			_gameMap.addChild(_player);
			for (i = 0; i < _interactiveObjects.length; ++i) _gameMap.addChild(_interactiveObjects[i]);
			
			_sceneContainer = new Sprite();
			addChild(_sceneContainer);
			_camera.sceneContainer = _sceneContainer;
			
			_sceneContainer.addChild(floors);
			_sceneContainer.addChild(_gameMap.world);
			
			spCollisions.visible = false;
			addChild(spCollisions);// needs to be in the display list for the hit test to work
			
			
			// HUD
			_timeTextField.x = _timeTextField.y = 10;
			addChild(_timeTextField);
		}
		
		public override function update():void 
		{
			for each (var entity:Entity in _entities)
				entity.update();
				
			_gameMap.update();
			
			_camera.update();
			
			_gameTime.update();
			_timeTextField.text = String(_gameTime.seconds);
			
			// test
			if (!_gameTime.slowmoActive && _playerInput.testPressed)
				_gameTime.startSlowmo();
		}
		
		public override function dispose():void 
		{
			_gameMap.dispose();
			removeChild(_gameMap.world);
			
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