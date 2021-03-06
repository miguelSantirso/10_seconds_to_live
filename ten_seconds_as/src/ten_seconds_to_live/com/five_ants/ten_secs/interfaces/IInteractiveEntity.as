package ten_seconds_to_live.com.five_ants.ten_secs.interfaces 
{
	import flash.events.IEventDispatcher;
	import ten_seconds_to_live.com.five_ants.ten_secs.events.InventoryItemEvent;
	import ten_seconds_to_live.com.five_ants.ten_secs.IPlayerInput;
	import ten_seconds_to_live.com.five_ants.ten_secs.object_actions.ObjectActionBase;
	import ten_seconds_to_live.com.five_ants.ten_secs.Player;
	import ten_seconds_to_live.com.five_ants.ten_secs.RoomUtils;
	
	/**
	 * ...
	 * @author Miguel Santirso
	 */
	public interface IInteractiveEntity extends IEventDispatcher, IDisposable
	{
		function getName():String;
		
		function setKnowledgeDependency(dependency:String):void;
		function setItemDependency(item:int):void;
		
		function addActionNoItemNoKnowledge(action:ObjectActionBase, repeteable:Boolean = false):void;
		function addActionNoItem(action:ObjectActionBase, repeteable:Boolean = false):void;
		function addActionSuccess(action:ObjectActionBase, repeteable:Boolean = false):void;
		
		function executeAllActions():void;
		
		function set enableInteractions(value:Boolean):void;
		
		function set showRadius(value:Boolean):void;
		
		function checkPlayerCollision(player:Player, playerInput:IPlayerInput):void;
		
		function get numActionsNoItemNoKnowledge():int;
		function get numActionsNoItem():int;
		function get numActionsSuccess():int;
	}
	
}