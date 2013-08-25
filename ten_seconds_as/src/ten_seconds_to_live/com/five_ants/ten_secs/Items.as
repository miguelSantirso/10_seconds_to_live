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
		public static const MEDICATION:int = registerItem(Item_Medication, "Medication");
		public static const GUN:int = registerItem(Item_Gun, "Gun");
		public static const BOOK:int = registerItem(Item_Book, "Book");
		public static const SECRET_KEY:int = registerItem(Item_SecretCode, "SecretKey");
		public static const CATNIP:int = registerItem(Item_Catnip, "Catnip");
		public static const CAT:int = registerItem(Item_Cat, "Cat");
		public static const PICTURE:int = registerItem(Item_Picture, "Picture");
		public static const SECRET_DOOR:int = registerItem(Item_SecretDoor, "SecretDoor");
		public static const STATUE:int = registerItem(Item_Statue, "Statue");
		public static const CAMERA:int = registerItem(Item_Camera, "Camera");

		public static const DORM_DOOR:int = registerItem(Item_Placeholder, "x");
		public static const BOOKSHELF:int = registerItem(Item_Placeholder, "y");
		public static const CAR:int = registerItem(Item_Placeholder, "z");
		
		public static const NONE:int = registerItem(MovieClip, "None");
		
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
			if (!_itemsById) _itemsById = new Vector.<Class>();
			
			if (_itemsByName[name])
				throw new Error("InventoryItems: More than one inventory item with the same name: " + name);
			
			_itemsById[_itemsById.length] = mcClass;
			_itemsByName[name] = mcClass;
			
			return _itemsById.length - 1;
		}
	}

}