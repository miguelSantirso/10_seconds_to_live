package ten_seconds_to_live.com.five_ants.ten_secs 
{
	import flash.display.Sprite;
	import ten_seconds_to_live.com.five_ants.ten_secs.interfaces.ICameraTarget;
	import ten_seconds_to_live.com.five_ants.ten_secs.interfaces.IUpdateable;
	/**
	 * ...
	 * @author Miguel Santirso
	 */
	public class Camera implements IUpdateable
	{
		private var _sceneContainer:Sprite;
		
		private var _target:ICameraTarget;
		
		private var i:int = 0;
		
		public function update():void
		{
			if (_target == null)
				return;
			
			if (i++ % 60 == 0)
				_sceneContainer.x += 1;
			
			_sceneContainer.x = 400 - _target.x;
			_sceneContainer.y = 300 - _target.y;
		}
		
		
		public function set sceneContainer(value:Sprite):void
		{
			_sceneContainer = value;
		}
		
		public function set target(value:ICameraTarget):void
		{
			_target = value;
		}
		
	}

}