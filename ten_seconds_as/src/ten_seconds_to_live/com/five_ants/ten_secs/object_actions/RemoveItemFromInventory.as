package ten_seconds_to_live.com.five_ants.ten_secs.object_actions 
{
	import ten_seconds_to_live.com.five_ants.ten_secs.GameplayState;
	import ten_seconds_to_live.com.five_ants.ten_secs.realities.AlternativeReality;
	/**
	 * ...
	 * @author Miguel Santirso
	 */
	public class RemoveItemFromInventory extends ObjectActionBase 
	{
		private var _itemToRemove:int;
		
		public function RemoveItemFromInventory(itemToRemove:int) 
		{
			_itemToRemove = itemToRemove;
		}
		
		
		public override function execute():void
		{
			AlternativeReality._gameplay.hud.inventory.removeItem(_itemToRemove);
		}
		
	}

}