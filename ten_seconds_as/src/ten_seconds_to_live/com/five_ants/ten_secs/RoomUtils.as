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
		
		
		public function hideRoom(roomName:String):void
		{
			(_roomShapesByName[roomName] as Sprite).visible = false;
		}
		public function showRoom(roomName:String):void
		{
			(_roomShapesByName[roomName] as Sprite).visible = true;
		}
		
		
	}

}