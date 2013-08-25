package ten_seconds_to_live.com.five_ants.ten_secs.HUD 
{
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author 10 2  Live Team
	 */
	public class HUDInventory extends HUDComponent 
	{
		protected var _items:Vector.<HUDInventoryItem>;
		
		protected const _itemGap:int = 6;
		
		public function HUDInventory() 
		{
			_items = new Vector.<HUDInventoryItem>();
			
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
		
		public function addItem(itemType:String):void
		{
			if (getItemByType(itemType))
				return;
			
			var inventoryItem:HUDInventoryItem = new HUDInventoryItem(itemType);
		
			inventoryItem.x = _itemGap + (_itemGap + inventoryItem.width)*_items.length;
			inventoryItem.y = _itemGap;
			inventoryItem.init();
		
			addChild(inventoryItem);

			_items.push(inventoryItem);
		}
		
		public function removeItem(itemType:String):void
		{
			for (var i:int = 0; i < _items.length ; i++){
				if(_items[i].type == itemType){
					removeChild(_items[i]);
					_items.splice(i, 1);					
					return;
				}
			}
		}
		
		public function getItemByType(itemType:String):HUDInventoryItem
		{
			for each(var item:HUDInventoryItem in _items)
			{
				if(item.type == itemType)
					return item;
			}
			return null;
		}
	}

}