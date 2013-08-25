package ten_seconds_to_live.com.five_ants.ten_secs.HUD 
{
	import ten_seconds_to_live.com.five_ants.ten_secs.Items;
	
	/**
	 * ...
	 * @author 10 2  Live Team
	 */
	public class HUDInventoryItem extends HUDComponent 
	{
		protected var _itemId:int;
		
		public function HUDInventoryItem(itemId:int) 
		{
			_coreComponent = Items.getItemById(itemId);
			_itemId = itemId;
			
			super(_coreComponent);
		}
		
		public function get coreComponent():CoreInventoryItem
		{
			return _coreComponent as CoreInventoryItem;
		}
		
		public function get itemId():int 
		{
			return _itemId;
		}
	}

}