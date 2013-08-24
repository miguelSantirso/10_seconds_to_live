package ten_seconds_to_live.com.five_ants.ten_secs 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Miguel Santirso
	 */
	public class Entity extends Sprite 
	{
		protected var _gameplay:GameplayState;
		
		public function load(refToGameplay:GameplayState):void
		{
			_gameplay = refToGameplay;
		}
		
		public function dispose():void { }
		
		public function update():void { }
		
	}

}