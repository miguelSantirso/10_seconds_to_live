package ten_seconds_to_live.com.five_ants.ten_secs.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 10 2  Live Team
	 */
	public class InventoryItemEvent extends Event 
	{
		public static const ITEM_EVENT:String = "inventoryItemEvent";
		
		protected var _itemType:String;
		
		public function InventoryItemEvent(itemType:String, type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			_itemType = itemType;
			
			super(type, bubbles, cancelable);
		}
		
		public function get itemType():String 
		{
			return _itemType;
		}
		
	}

}