package ten_seconds_to_live.com.five_ants.ten_secs 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Miguel Santirso
	 */
	public class RoomUtils 
	{
		private var _roomShapesByName:Dictionary = new Dictionary();
		private var _roomVisuals:Sprite;
		
		
		public function getRoomByPosition(x:int, y:int):String
		{
			var roomShape:Sprite;
			for (var key:String in _roomShapesByName)
			{
				roomShape = _roomShapesByName[key];
				
				if (roomShape.hitTestPoint(x, y, true))
					return key;
			}
			
			return null;
		}
		
		
		public function setRoomShapes(roomShapes:Sprite):void
		{
			var roomShape:Sprite;
			var roomName:String;
			for (var i:int = 0; i < roomShapes.numChildren; ++i)
			{
				roomShape = roomShapes.getChildAt(i) as Sprite;
				roomName = roomShape.name;
				
				if (roomName)
				{
					if (_roomShapesByName[roomName])
						throw new Error("RoomUtils: More than one room with the same name!");
						
					_roomShapesByName[roomShape.name] = roomShape;
				}
			}
		}
		
		public function get allRoomNames():Vector.<String>
		{
			var roomNames:Vector.<String> = new Vector.<String>();
			
			for (var i:int = 0; i < _roomVisuals.numChildren; i++)
				roomNames.push(_roomVisuals.getChildAt(i).name);
			
			return roomNames;
		}
		
		public function hideRoom(roomName:String):void
		{
			(_roomVisuals.getChildByName(roomName)).visible = false;
		}
		public function showRoom(roomName:String):void
		{
			(_roomVisuals.getChildByName(roomName)).visible = true;
		}
		
		public function setRoomVisuals(object:Sprite):void 
		{
			_roomVisuals = object;
		}
		
	}

}