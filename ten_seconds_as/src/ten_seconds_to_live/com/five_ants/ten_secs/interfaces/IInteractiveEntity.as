package ten_seconds_to_live.com.five_ants.ten_secs.interfaces 
{
	import flash.events.IEventDispatcher;
	import ten_seconds_to_live.com.five_ants.ten_secs.object_actions.ObjectActionBase;
	
	/**
	 * ...
	 * @author Miguel Santirso
	 */
	public interface IInteractiveEntity extends IEventDispatcher
	{
		function getName():String;
		
		function addAction(action:ObjectActionBase):void;
		
		function executeAllActions():void;
		
		function set enableInteractions(value:Boolean):void;
	}
	
}