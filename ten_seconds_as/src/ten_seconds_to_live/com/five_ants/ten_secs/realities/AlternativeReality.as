package ten_seconds_to_live.com.five_ants.ten_secs.realities 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import org.osflash.signals.OnceSignal;
	import ten_seconds_to_live.com.five_ants.ten_secs.Camera;
	import ten_seconds_to_live.com.five_ants.ten_secs.events.Cat;
	import ten_seconds_to_live.com.five_ants.ten_secs.Entity;
	import ten_seconds_to_live.com.five_ants.ten_secs.events.PlayerEvent;
	import ten_seconds_to_live.com.five_ants.ten_secs.GameMap;
	import ten_seconds_to_live.com.five_ants.ten_secs.GameplayState;
	import ten_seconds_to_live.com.five_ants.ten_secs.InteractiveObject;
	import ten_seconds_to_live.com.five_ants.ten_secs.Player;
	import ten_seconds_to_live.com.five_ants.ten_secs.RealityLogic;
	import ten_seconds_to_live.com.five_ants.ten_secs.RoomUtils;
	import ten_seconds_to_live.com.five_ants.ten_secs.WallCollisions;
	import ten_seconds_to_live.com.five_ants.ten_secs.events.InteractiveObjectEvent;
	/**
	 * ...
	 * @author Miguel Santirso
	 */
	public class AlternativeReality extends Sprite
	{
		private var _config:IRealityConfig;
		
		private var _player:Player;
		//private var _cat:Cat; // TEMP ALBERT
		private var _entities:Vector.<Entity> = new Vector.<Entity>();
		private var _interactiveObjects:Dictionary = new Dictionary();
		public static var _gameplay:GameplayState;
		private var _camera:Camera;
		private var _gameMap:GameMap;
		private var _collisions:WallCollisions;
		public static var _roomUtils:RoomUtils;
		private var _firstUpdate:Boolean = true;
		
		private var _sceneContainer:Sprite;
		
		private var _realityLogic:RealityLogic;
		
		private var _playerWokeUp:OnceSignal = new OnceSignal();
		
		public function AlternativeReality(config:IRealityConfig)
		{
			_config = config;
		}
		
		public function init(refToGameplay:GameplayState):void
		{
			_camera = new Camera();
			
			_gameplay = refToGameplay;
			
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
			_player.x = 230; _player.y = 1036;
			_camera.target = _player;
			_player.animationComplete.addOnce(function(anim:int):void { _playerWokeUp.dispatch(); } );
			_player.addEventListener(PlayerEvent.CHANGED_ROOM, onPlayerChangedRoom, false, 0, true);
			_entities.push(_player);
			
			_realityLogic = new RealityLogic();
			
			_gameMap = new GameMap(_config.constructVisualGameMap());
			_gameMap.init();
			_gameMap.addChild(_player);
			
			initInteractiveObjects();
			
			_config.scriptEntities(_realityLogic);
			
			// muestra los radios de todos los objetos interactivos:
			_realityLogic.showInteractionRadiuses = true;
			_realityLogic.enableAllInteractions = true;
			
			for each (var entity:Entity in _entities)
				entity.load(_gameplay);
			
			_sceneContainer = new Sprite();
			addChild(_sceneContainer);
			_camera.sceneContainer = _sceneContainer;
			
			var visualRoomFloors:Sprite = _config.constructFloors();
			_sceneContainer.addChild(visualRoomFloors);
			_roomUtils.setRoomVisuals(visualRoomFloors);
			_sceneContainer.addChild(_gameMap.world);
		}
		
		private function initInteractiveObjects():void
		{
			var child:MovieClip;
			var interactiveObject:InteractiveObject;
			var forcedRadius:Number;
			
			for (var i:int = 0; i < _gameMap.world.numChildren; i++)
			{
				child = _gameMap.world.getChildAt(i) as MovieClip;
				
				if (child != null)
				{
					if (child.name.charAt(0) == "_")
					{
						if (child.name.indexOf("$") >= 0)
						{
							if (child.name.substr(child.name.indexOf("$") + 1) == "cat")
							{
								interactiveObject = new Cat(child, _roomUtils) as InteractiveObject;
							}
							else
							{
								forcedRadius = int(child.name.substr(child.name.indexOf("$") + 1));
								interactiveObject = new InteractiveObject(child, _roomUtils, forcedRadius);
							}
						}
						else interactiveObject = new InteractiveObject(child, _roomUtils);
						
						_realityLogic.registerInteractiveEntity(child.name, interactiveObject);
						
						_entities.push(interactiveObject);
						
						trace(">> ADDED INTERACTIVE OBJECT: " + child.name);
					}
					else
					{
						_entities.push(new Entity(child));
					}
				}
			}
		}
		
		public function update():void
		{
			for each (var entity:Entity in _entities)
			{
				entity.update();
			}

			_gameMap.update();
			
			_camera.update();
			
			_realityLogic.update(_player, _gameplay.playerInput);
			
			if (_firstUpdate) setUpRoom();
			
			if (_firstUpdate) setUpRoom("room");
		}

		public function dispose():void
		{
			_gameMap.dispose();
			
			for each (var entity:Entity in _entities)
				entity.dispose();
				
			_player.removeEventListener(PlayerEvent.CHANGED_ROOM, onPlayerChangedRoom);
			
			for each(var interactive:InteractiveObject in _interactiveObjects)
				interactive.dispose();
		}
		
		
		public function findInteractiveObject(name:String):InteractiveObject
		{
			if (!_interactiveObjects[name])
				throw new Error("AlternativeReality: Can't find interactive object with name " + name);
			
			return _interactiveObjects[name];
		}
		public function removeInteractiveObject(name:String):void
		{
			var intObj:InteractiveObject = _realityLogic.removeEntityByName(name) as InteractiveObject;
			intObj.visualObject.visible = false;
			_entities.splice(_entities.indexOf(intObj), 1);
		}
		
		private function onPlayerChangedRoom(event:PlayerEvent = null):void
		{
			_firstUpdate = false;
			
			setUpRoom();
		}
		
		private function setUpRoom(forceRoom:String = null):void
		{
			for each (var entity:Entity in _entities)
			{
				if (entity.getMyRoom() != _player.getMyRoom())
				{
					entity.visualObject.visible = false;
				}
				else if (entity.visualObject)
				{
					entity.visualObject.visible = true;
					if (_firstUpdate)
					{
						entity.glowInteractionPointer();
					}
				}
			}
			
			for each(var roomName:String in _roomUtils.allRoomNames)
			{
				if(roomName != (forceRoom ? forceRoom : _player.getMyRoom()))
					_roomUtils.hideRoom(roomName);
				else
					_roomUtils.showRoom(roomName);
			}
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
		
		public function get playerWokeUp():OnceSignal 
		{
			return _playerWokeUp;
		}
	}

}