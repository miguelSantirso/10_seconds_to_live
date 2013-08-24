package ten_seconds_to_live.com.five_ants.ten_secs 
{
	/**
	 * ...
	 * @author Miguel Santirso
	 */
	public class GameplayState extends IGameState 
	{
		private var _main:TenSecsMain;
		
		public override function load(refToMain:TenSecsMain):void 
		{
			_main = refToMain;
		}
		
		public override function update():void 
		{
			
		}
		
		public override function dispose():void 
		{
			
		}
		
	}

}