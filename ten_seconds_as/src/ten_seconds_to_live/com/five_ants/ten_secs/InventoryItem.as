package ten_seconds_to_live.com.five_ants.ten_secs 
{
	/**
	 * ...
	 * @author 10 2  Live Team
	 */
	public class InventoryItem
	{
		protected var _id:int;
		protected var _title:String;
		protected var _caption:String;
		
		public function InventoryItem() 
		{
			
		}
		
		public function get id():int 
		{
			return _id;
		}
		
		public function set id(value:int):void 
		{
			_id = value;
		}
		
		public function get title():String 
		{
			return _title;
		}
		
		public function set title(value:String):void 
		{
			_title = value;
		}
		
		public function get caption():String 
		{
			return _caption;
		}
		
		public function set caption(value:String):void 
		{
			_caption = value;
		}
		
	}

}