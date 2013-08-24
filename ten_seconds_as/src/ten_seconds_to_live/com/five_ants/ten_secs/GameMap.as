package ten_seconds_to_live.com.five_ants.ten_secs 
{
	import flash.display.MovieClip;
	import flash.utils.Dictionary;
	import ten_seconds_to_live.com.five_ants.ten_secs.interfaces.IInitializable;
	import ten_seconds_to_live.com.five_ants.ten_secs.interfaces.IDisposable;
	/**
	 * ...
	 * @author ...
	 */
	public class GameMap  extends VisualGameMap implements IInitializable, IDisposable 
	{
		protected var _rooms:Array;
		protected var _roomsDictionary:Dictionary;
		
		public function GameMap() 
		{
			_roomsDictionary = new Dictionary();
			
			_rooms = [room1];
		}
		
		public function dispose():void
		{
			for each(var roomVector:Vector.<MovieClip> in _roomsDictionary) {
				roomVector.splice(0, roomVector.length);
			}
			for (var key:Object in _roomsDictionary) {
				delete _roomsDictionary[key];
			}
			_roomsDictionary = null;	
		}
		
		public function init():void
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
		
	}

}