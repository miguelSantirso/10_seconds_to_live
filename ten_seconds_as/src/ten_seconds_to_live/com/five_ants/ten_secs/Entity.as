package ten_seconds_to_live.com.five_ants.ten_secs 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import ten_seconds_to_live.com.five_ants.ten_secs.interfaces.IDisposable;
	import ten_seconds_to_live.com.five_ants.ten_secs.interfaces.IUpdateable;
	
	/**
	 * ...
	 * @author Miguel Santirso
	 */
	public class Entity extends Sprite implements IDisposable, IUpdateable
	{
		public var _gameplay:GameplayState;
		
		protected var _visualObject:MovieClip;
		
		public function Entity(visualObject:MovieClip = null):void
		{
			_visualObject = visualObject;
			
			if (_visualObject)
			{
				x = _visualObject.x;
				y = _visualObject.y;
			}
		}
		
		public function load(refToGameplay:GameplayState):void
		{
			_gameplay = refToGameplay;
		}
		
		public function dispose():void { }
		
		public function update():void { }
		
		public function getMyRoom(roomUtils:RoomUtils):String
		{
			return roomUtils.getRoomByPosition(x, y);
		}
		
		public function get visualObject():MovieClip
		{
			return _visualObject;
		}
		
	}

}