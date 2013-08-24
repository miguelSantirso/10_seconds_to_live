package ten_seconds_to_live.com.five_ants.ten_secs 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;
	import ten_seconds_to_live.com.five_ants.ten_secs.interfaces.IInitializable;
	import ten_seconds_to_live.com.five_ants.ten_secs.interfaces.IUpdateable;
	
	/**
	 * ...
	 * @author Miguel Santirso
	 */
	public class WallCollisions
	{
		private var _collisions:Sprite;
		
		public function isPointNavigable(point:Point):Boolean
		{
			return isPositionNavigable(point.x, point.y);
		}
		public function isPositionNavigable(x:int, y:int):Boolean
		{
			return ! _collisions.hitTestPoint(x, y, true);
		}
		
		
		public function setCollisions(collisions:Sprite):void
		{
			_collisions = collisions;
		}
		
	}

}