package ten_seconds_to_live.com.five_ants.ten_secs 
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import ten_seconds_to_live.com.five_ants.ten_secs.interfaces.IUpdateable;
	
	/**
	 * ...
	 * @author Miguel Santirso
	 */
	public class IGameState extends Sprite implements IUpdateable
	{
		protected var _main:TenSecsMain;
		protected var _stage:Stage;
		
		public function load(refToMain:TenSecsMain, stage:Stage):void
		{
			_main = refToMain;
			_stage = stage;
			
			init();
		}
		
		public function update():void {}
		
		public function dispose():void { }
		
		
		protected function init():void { }
	}
	
}