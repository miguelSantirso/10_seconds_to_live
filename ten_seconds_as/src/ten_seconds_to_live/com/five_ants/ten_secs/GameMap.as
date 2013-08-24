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
		protected var _mapElements:Vector.<DisplayObject>;
		
		protected var _player:Player;
		protected var _previousPlayerY:Number;
		
		public function GameMap() 
		{
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
			
			for (var i:int = numChildren - 1; i >= 0; i--) {
				_mapElements.push(getChildAt(i));
			}
			_mapElements.sort(sortMapElementOnY);
			
			// hacer sorting en el display list de cada habitación
			for (var j:int = 0; j < _mapElements.length; j++) {
				tempElement = getChildByName(_mapElements[j].name) as MovieClip;
				setChildIndex(tempElement, j);
			}
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
				_previousPlayerY = _player.y;
				return addChildAt(child,initPlayerIndex);
			}else
				return super.addChild(child);
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
			
			if (newPlayerIndex != getChildIndex(_player)){
				setChildIndex(_player, newPlayerIndex);
			}
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
			var currentPlayerIndex:int = getChildIndex(_player);
			
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