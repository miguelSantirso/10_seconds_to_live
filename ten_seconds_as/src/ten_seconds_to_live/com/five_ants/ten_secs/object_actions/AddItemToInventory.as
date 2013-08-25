package ten_seconds_to_live.com.five_ants.ten_secs.object_actions 
{
	import ten_seconds_to_live.com.five_ants.ten_secs.GameplayState;
	/**
	 * ...
	 * @author Miguel Santirso
	 */
	public class AddItemToInventory extends ObjectActionBase 
	{
		private var _itemName:String;
		
		public function AddItemToInventory(itemToAdd:String, gamePlay:GameplayState):void
		{
			super(gamePlay);
			
			_itemName = itemToAdd;
		}
		
		
		public override function execute():void
		{
			_gameplay.hud.inventory.addItem(_itemName);
		}
		
	}

}