package ten_seconds_to_live.com.five_ants.ten_secs.HUD 
{
	import ten_seconds_to_live.com.five_ants.ten_secs.Items;
	
	/**
	 * ...
	 * @author 10 2  Live Team
	 */
	public class HUDInventoryItem extends HUDComponent 
	{
		protected var _type:String;
		
		public function HUDInventoryItem(itemType:String = null) 
		{
			_coreComponent = Items.getItemByName(itemType);
			
			super(_coreComponent);
			
			if(itemType)
				type = itemType;
		}
		
		public override function init():void
		{
			super.init();
		}
		
		public override function dispose():void
		{
			super.dispose();
			
			_type = null;
		}
		
		public function get coreComponent():CoreInventoryItem
		{
			return _coreComponent as CoreInventoryItem;
		}
		
		public function get type():String 
		{
			return _type;
		}
		
		public function set type(value:String):void 
		{
			_type = value;
			
			// show the right item
		}
	}

}