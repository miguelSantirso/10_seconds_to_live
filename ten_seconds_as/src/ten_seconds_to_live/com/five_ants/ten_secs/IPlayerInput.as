package ten_seconds_to_live.com.five_ants.ten_secs 
{
	import flash.display.Stage;
	
	/**
	 * ...
	 * @author Miguel Santirso
	 */
	public interface IPlayerInput 
	{
		function init(stage:Stage):void
		function dispose():void;
		
		function get upPressed():Boolean;
		function get downPressed():Boolean;
		function get leftPressed():Boolean;
		function get rightPressed():Boolean;
		function get ePressed():Boolean;
		function get spacebarPressed():Boolean;
		
		function get testPressed():Boolean;
	}
	
}