package ten_seconds_to_live.com.five_ants.ten_secs.HUD 
{
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author 10 2  Live Team
	 */
	public class HUDInventory extends HUDComponent 
	{
		protected var _items:Dictionary;
		
		protected const _itemGap:int = 6;
		
		public function HUDInventory() 
		{
			_items = new Dictionary();
			
			_coreComponent = new CoreInventory();
			
			super(_coreComponent);
		}
		
		public override function init():void
		{
			super.init();
		}
		
		public override function dispose():void
		{
			super.dispose();
			
			for (var i:int = 0; i < _items.length ; i++) {
				removeChild(_items[i]);
			}
			_items.splice(0, _items.length);
			_items = null;
		}
		
		public function get coreComponent():CoreInventory
		{
			return _coreComponent as CoreInventory;
		}
		
		public function addItem(itemId:int):void
		{
			if (_items[itemId])
				return;
			
			var inventoryItem:HUDInventoryItem = new HUDInventoryItem(itemId);
			
			inventoryItem.x = _itemGap + inventoryItem.width * 0.5 + (_itemGap + inventoryItem.width * 1.5)*_items.length;
			inventoryItem.y = _itemGap + inventoryItem.height * 0.5;
			inventoryItem.init();
			
			addChild(inventoryItem);
			_items[itemId] = inventoryItem;
		}
		
		public function removeItem(itemId:int):void
		{
			removeChild(_items[itemId]);
			_items[itemId] = null;
		}
		
		public function checkItemByID(itemId:int):Boolean
		{
			return _items[itemId];
		}
	}

}