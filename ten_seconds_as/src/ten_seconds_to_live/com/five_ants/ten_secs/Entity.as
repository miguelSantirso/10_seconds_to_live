package ten_seconds_to_live.com.five_ants.ten_secs 
{
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
		
		public function load(refToGameplay:GameplayState):void
		{
			_gameplay = refToGameplay;
		}
		
		public function dispose():void { }
		
		public function update():void { }
		
	}

}