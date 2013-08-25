package ten_seconds_to_live.com.five_ants.ten_secs.object_actions 
{
	import ten_seconds_to_live.com.five_ants.ten_secs.GameplayState;
	/**
	 * ...
	 * @author Miguel Santirso
	 */
	public class RemoveItemFromInventory extends ObjectActionBase 
	{
		private var _itemToRemove:String;
		
		public function RemoveItemFromInventory(itemName:String, gamePlay:GameplayState) 
		{
			super(gamePlay);
			
			_itemToRemove = itemName;
		}
		
		
		public override function execute():void
		{
			_gameplay.hud.inventory.removeItem(_itemToRemove);
		}
		
	}

}