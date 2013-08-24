package ten_seconds_to_live.com.five_ants.ten_secs 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	import ten_seconds_to_live.com.five_ants.ten_secs.interfaces.IInitializable;
	import ten_seconds_to_live.com.five_ants.ten_secs.interfaces.IDisposable;
	import ten_seconds_to_live.com.five_ants.ten_secs.interfaces.IUpdateable;
	/**
	 * ...
	 * @author ...
	 */
	public class GameMap implements IInitializable, IDisposable, IUpdateable 
	{
		protected var _world:MovieClip;
		protected var _mapElements:Vector.<DisplayObject>;
		
		protected var _player:Player;
		protected var _previousPlayerY:Number;
		
		public function GameMap(world:MovieClip) 
		{
			_world = world;
			_mapElements = new Vector.<DisplayObject>();
			_previousPlayerY = Number.NaN;
		}
		
		public function dispose():void
		{
			_mapElements.splice(0, _mapElements.length);
			_mapElements = null;
			
			_player = null;
		}
		
		public function init():void
		{
			var tempElement:MovieClip
			
			for (var i:int = _world.numChildren - 1; i >= 0; i--) {
				_mapElements.push(_world.getChildAt(i));
			}
			_mapElements.sort(sortMapElementOnY);
			
			// hacer sorting en el display list de cada habitación
			for (var j:int = 0; j < _mapElements.length; j++) {
				tempElement = _world.getChildByName(_mapElements[j].name) as MovieClip;
				_world.setChildIndex(tempElement, j);
				trace(tempElement.name + " " + j + " " + tempElement.y);
			}
		}
		
		public function update():void
		{
			if (_player.y != _previousPlayerY) {
				sortPlayerIndex();
				_previousPlayerY = _player.y;
			}
		}
		
		public function addChild(child:DisplayObject):DisplayObject
		{
			if (child is Player) {
				_player = child as Player;
				_previousPlayerY = _player.y;
				return _world.addChildAt(child,initPlayerIndex);
			}else
				return _world.addChild(child);
		}
		
		protected function sortMapElementOnY(a:MovieClip, b:MovieClip):int
		{
			if (a.y < b.y){ 
				return -1; 
			}else if (a.y > b.y){ 
				return 1; 
			}else{ 
				return 0; 
			} 
		}
		
		protected function sortPlayerIndex():void
		{
			var newPlayerIndex:int = newPlayerIndex;
			
			if (newPlayerIndex != _world.getChildIndex(_player)){
				_world.setChildIndex(_player, newPlayerIndex);
			}
		}
		
		public function get world():MovieClip
		{
			return _world;
		}
		
		protected function get initPlayerIndex():int
		{
			var currY:Number;
			for (var i:int = 0; i < _mapElements.length; i++) {
				currY = _mapElements[i].y;
				if (_player.y < _mapElements[i].y){
					return i;
				}
			}
			return _mapElements.length - 1;
		}
		
		protected function get newPlayerIndex():int
		{
			var currentPlayerIndex:int = _world.getChildIndex(_player);
			
			if (_player.y < _previousPlayerY) {
				for (var i:int = currentPlayerIndex - 1; i >= 0; i--) {
					if (_player.y > _mapElements[i].y && _mapElements[i + 1] != _player)
						return i + 1;
				} 
			}else if (_player.y > _previousPlayerY) {
				for (var j:int = currentPlayerIndex; j < _mapElements.length; j++) {
					if (_player.y < _mapElements[j].y && _mapElements[j] != _player)
						return j;
				}
			}
			return currentPlayerIndex;
		}
	}

}