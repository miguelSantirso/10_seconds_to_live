package ten_seconds_to_live.com.five_ants.ten_secs.interfaces 
{
	import ten_seconds_to_live.com.five_ants.ten_secs.object_actions.ObjectActionBase;
	
	/**
	 * ...
	 * @author Miguel Santirso
	 */
	public interface IInteractiveEntity 
	{
		function get name():String;
		
		function addAction(action:ObjectActionBase):void;
		
		function executeAllActions():void;
	}
	
}