package ten_seconds_to_live.com.five_ants.ten_secs.events 
{
	import com.greensock.plugins.Positions2DPlugin;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import ten_seconds_to_live.com.five_ants.ten_secs.Entity;
	import ten_seconds_to_live.com.five_ants.ten_secs.InteractiveObject;
	import ten_seconds_to_live.com.five_ants.ten_secs.interfaces.IInteractiveEntity;
	import ten_seconds_to_live.com.five_ants.ten_secs.RoomUtils;
	import ten_seconds_to_live.com.five_ants.ten_secs.WallCollisions;
	/**
	 * ...
	 * @author ...
	 */
	public class Cat extends InteractiveObject
	{
		private var _currentState:String;
	
		public static const STATE_IDLE:String = "idle";
		public static const STATE_WANDER_DECIDE:String = "wanderDecide";
		public static const STATE_WANDER_WALK:String = "wanderWalk";
		
		private static const WANDER_SPEED:Number = 3;
		
		private var _wanderDir:Point;
		private var _previousWanderAngle:Number;
		private var _wallCollisions:WallCollisions;
		
		public function Cat(visualObject:MovieClip, roomUtils:RoomUtils) 
		{
			super(visualObject, roomUtils);
			
			changeState(STATE_WANDER_DECIDE);
		}
		
		public function changeState(newState:String):void
		{
			_currentState = newState;
			
			trace(">> CAT'S STATE CHANGED TO: " + newState);
		}
		
		private function idle():void
		{
			//
		}
		
		private function wanderDecide():void
		{
			var randAngle:Number = randAngle = Math.random() * 360;
			
			while (Math.abs(randAngle - _previousWanderAngle) < 180)
			{
				randAngle = Math.random() * 360;
			}
			
			_wanderDir = new Point(Math.cos(randAngle), Math.sin(randAngle));
			
			_previousWanderAngle = randAngle;
			
			changeState(STATE_WANDER_WALK);
		}
		
		private function wanderWalk():void
		{
			var tentativeMovement:Point = new Point(WANDER_SPEED * _wanderDir.x, WANDER_SPEED * _wanderDir.y);
			
			_wallCollisions = _gameplay.currentReality.collisions;
			
			if (!_wallCollisions.isPositionNavigable(_visualObject.x + tentativeMovement.x, _visualObject.y + tentativeMovement.y))
				changeState(STATE_WANDER_DECIDE);
			else
			{
				if (Math.round(Math.random() * 50) == 0)
				{
					changeState(STATE_WANDER_DECIDE);
				}
				else
				{
					_visualObject.x += tentativeMovement.x;
					_visualObject.y += tentativeMovement.y;
				}
			}
		}
		
		public override function update():void 
		{
			super.update();
			
			this[_currentState]();
		}
	}

}