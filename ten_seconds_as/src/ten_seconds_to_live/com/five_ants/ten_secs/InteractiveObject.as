package ten_seconds_to_live.com.five_ants.ten_secs 
{
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author Miguel Santirso
	 */
	public class InteractiveObject extends Entity
	{
		private var _visualObject:MovieClip = new MovieClip();
		
		public function InteractiveObject() 
		{
			super();
			
			_visualObject = new Object1_interactive();
			_visualObject.play();
			
			addChild(_visualObject);
		}
		
		public override function update():void
		{
			//
		}
	}

}