package ten_seconds_to_live.com.five_ants.ten_secs 
{
	import flash.display.MovieClip;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Miguel Santirso
	 */
	public class GameplayState extends IGameState 
	{
		private var _player:Player;
		private var _entities:Vector.<Entity> = new Vector.<Entity>();
		
		private var _playerInput:IPlayerInput;
		
		// map visuals
		protected var _map:VisualGameMap;
		// map logic
		protected var _rooms:Array;
		protected var _roomsDictionary:Dictionary;
		
		protected override function init():void 
		{
			_playerInput = new KeyboardInput();
			_playerInput.init(_stage);
			
			_player = new Player();
			_player.x = 300; _player.y = 300;
			
			_entities.push(_player);
			
			for each (var entity:Entity in _entities)
				entity.load(this);
				
			// map
			_roomsDictionary = new Dictionary();
			_map = new VisualGameMap();
			_rooms = [_map.room1];
			
			initRooms();
			
			addChild(_player);
			addChild(_map);
		}
		
		public override function update():void 
		{
			for each (var entity:Entity in _entities)
				entity.update();
		}
		
		public override function dispose():void 
		{
			// map
			removeChild(_map);
			
			for each(var roomVector:Vector.<MovieClip> in _roomsDictionary) {
				roomVector.splice(0, roomVector.length);
			}
			for (var key:Object in _roomsDictionary) {
				delete _roomsDictionary[key];
			}
			_roomsDictionary = null;
			
			// player
			_playerInput.dispose();
			
			for each (var entity:Entity in _entities)
				entity.dispose();
		}
		
		protected function initRooms():void
		{
			// crear diccionario y vector de movieclips por habitación
			var room:MovieClip;
			var roomElements:Vector.<MovieClip>;
			var tempElement:MovieClip
			
			for each(room in _rooms) {
				roomElements = new Vector.<MovieClip>();
				
				// filtrar objetos de colisión
				for (var i:int = 0; i < room.numChildren; i++) {
					roomElements.push(room.getChildAt(i));
				}
				roomElements.sort(sortOnYCoordinate);
				_roomsDictionary[room.name] = roomElements;
				
				// hacer sorting en el display list de cada habitación
				for (var j:int = 0; j < roomElements.length; j++) {
					tempElement = room.getChildByName(roomElements[j].name) as MovieClip;
					room.setChildIndex(tempElement, roomElements.length - 1 - j);
				}
			}
		}
		
		protected function sortOnYCoordinate(a:MovieClip, b:MovieClip):int
		{
			if (a.y > b.y) 
			{ 
				return -1; 
			} 
			else if (a.y < b.y) 
			{ 
				return 1; 
			} 
			else 
			{ 
				return 0; 
			} 
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