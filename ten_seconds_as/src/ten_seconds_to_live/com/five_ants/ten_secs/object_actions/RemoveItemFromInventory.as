package ten_seconds_to_live.com.five_ants.ten_secs.object_actions 
{
	import ten_seconds_to_live.com.five_ants.ten_secs.GameplayState;
	/**
	 * ...
	 * @author Miguel Santirso
	 */
	public class RemoveItemFromInventory extends ObjectActionBase 
	{
		private var _itemToRemove:int;
		
		public function RemoveItemFromInventory(itemToRemove:int, gamePlay:GameplayState) 
		{
			super(gamePlay);
			
			_itemToRemove = itemToRemove;
		}
		
		
		public override function execute():void
		{
			_gameplay.hud.inventory.removeItem(_itemToRemove);
		}
		
	}

}