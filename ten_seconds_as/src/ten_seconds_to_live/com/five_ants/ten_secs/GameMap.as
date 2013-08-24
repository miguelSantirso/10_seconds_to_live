package ten_seconds_to_live.com.five_ants.ten_secs 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.utils.Dictionary;
	import ten_seconds_to_live.com.five_ants.ten_secs.interfaces.IInitializable;
	import ten_seconds_to_live.com.five_ants.ten_secs.interfaces.IDisposable;
	import ten_seconds_to_live.com.five_ants.ten_secs.interfaces.IUpdateable;
	/**
	 * ...
	 * @author ...
	 */
	public class GameMap  extends VisualGameMap implements IInitializable, IDisposable, IUpdateable 
	{
		//protected var _rooms:Array;
		//protected var _roomsDictionary:Dictionary;
		
		//protected var _currentRoom:MovieClip;
		
		protected var _mapElements:Vector.<MovieClip>;
		
		protected var _player:Player;
		protected var _previousPlayerY:Number;
		
		public function GameMap() 
		{
			_mapElements = new Vector.<MovieClip>();
			//_roomsDictionary = new Dictionary();
			
			//_rooms = [room1];
			//_currentRoom = room1;
		}
		
		public function dispose():void
		{
			/*for each(var roomVector:Vector.<MovieClip> in _roomsDictionary) {
				roomVector.splice(0, roomVector.length);
			}
			for (var key:Object in _roomsDictionary) {
				delete _roomsDictionary[key];
			}
			_roomsDictionary = null;*/	
		}
		
		public function init():void
		{
			// crear diccionario y vector de movieclips por habitación
			//var room:MovieClip;
			//var roomElements:Vector.<MovieClip>;
			var tempElement:MovieClip
			
			//for each(room in _rooms) {
				
				// filtrar objetos de colisión
				for (var i:int = 0; i < numChildren; i++) {
					_mapElements.push(getChildAt(i));
				}
				_mapElements.sort(sortMapElementOnY);
				//_roomsDictionary[room.name] = roomElements;
				
				// hacer sorting en el display list de cada habitación
				for (var j:int = 0; j < _mapElements.length; j++) {
					tempElement = getChildByName(_mapElements[j].name) as MovieClip;
					setChildIndex(tempElement, _mapElements.length - 1 - j);
				}
			//}
		}
		
		public function update():void
		{
			if (_player.y != _previousPlayerY) {
				sortPlayerIndex();
				_previousPlayerY = _player.y;
			}
		}
		
		public override function addChild(child:DisplayObject):DisplayObject
		{
			if (child is Player) {
				_player = child as Player;
				return addChildAt(child,0);
			}else
				return super.addChild(child);
		}
		
		protected function sortMapElementOnY(a:MovieClip, b:MovieClip):int
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
		
		protected function sortPlayerIndex():void
		{
			//remove player;
			
			
			//var _roomElements:Vector.<MovieClip> = _roomsDictionary[_currentRoom.name] as Vector.<MovieClip>;
			//var newPlayerIndex:int = binarySearchPlayerIndex(_roomElements, _player.y, 0, _roomElements.length - 1);
			
			//trace("new player index",newPlayerIndex);
			//_currentRoom.setChildIndex(_player, newPlayerIndex);
		}
		
		protected function getNewPlayerIndex():void
		{
			/*var currentPlayerIndex:int = _currentRoom.getChildIndex(_player);
			
			if (_player.y < _previousPlayerY) {
				for (var i:int = 0; i < currentPlayerIndex; i++) {
					if(_player.y > 
				} 
			}else if (_player.y > _previousPlayerY) {
				
			}*/
		}
	}

}