package ten_seconds_to_live.com.five_ants.ten_secs.object_actions 
{
	import ten_seconds_to_live.com.five_ants.ten_secs.GameplayState;
	import ten_seconds_to_live.com.five_ants.ten_secs.realities.AlternativeReality;
	/**
	 * ...
	 * @author Miguel Santirso
	 */
	public class AddItemToInventory extends ObjectActionBase 
	{
		private var _itemId:int;
		
		public function AddItemToInventory(itemToAdd:int):void
		{
			_itemId = itemToAdd;
		}
		
		
		public override function execute():void
		{
			AlternativeReality._gameplay.hud.inventory.addItem(_itemId);
		}
		
	}

}