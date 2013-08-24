package ten_seconds_to_live.com.five_ants.ten_secs 
{
	
	/**
	 * ...
	 * @author Miguel Santirso
	 */
	public interface IGameState 
	{
		function load(refToMain:TenSecsMain):void;
		
		function update():void;
		
		function dispose():void;
	}
	
}