package ten_seconds_to_live.com.five_ants.ten_secs.object_actions 
{
	/**
	 * ...
	 * @author Miguel Santirso
	 */
	public class RemoveItemFromInventory extends ObjectActionBase 
	{
		private var _itemToRemove:String;
		
		public function RemoveItemFromInventory(itemName:String) 
		{
			_itemToRemove = itemName;
		}
		
		
		public override function execute():void
		{
			//_gameplay.currentReality.removeItemFromInventory(_itemToRemove);
		}
		
	}

}