package ten_seconds_to_live.com.five_ants.ten_secs 
{
	import flash.display.MovieClip;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Miguel Santirso
	 */
	public class Items 
	{
		public static const NOTE_AND_WATCH:int = registerItem(Item_NoteAndWatch, "NoteAndWatch");
		
		private static var _itemsById:Vector.<Class>;
		private static var _itemsByName:Dictionary;
		
		
		public static function getItemById(id:int):MovieClip
		{
			return new _itemsById[id]() as MovieClip;
		}
		public static function getItemByName(name:String):MovieClip
		{
			if (_itemsByName[name] == null)
				throw new Error("InventoryItems: Can't find item with name " + name);
			
			return new _itemsByName[name]() as MovieClip;
		}
		
		
		private static function registerItem(mcClass:Class, name:String):int
		{
			if (!_itemsByName) _itemsByName = new Dictionary();
			if (!_itemsById) _itemsById = new Vector.<MovieClip>();
			
			if (_itemsByName[name])
				throw new Error("InventoryItems: More than one inventory item with the same name: " + name);
			
			_itemsById[_itemsById.length] = item;
			_itemsByName[name] = mcClass;
			
			return _itemsById.length - 1;
		}
	}

}