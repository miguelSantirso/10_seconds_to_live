package ten_seconds_to_live.com.five_ants.ten_secs.xml 
{
	import flash.utils.Dictionary;
	import ten_seconds_to_live.com.five_ants.ten_secs.Dialog;
	import ten_seconds_to_live.com.five_ants.ten_secs.DialogItem;
	import ten_seconds_to_live.com.five_ants.ten_secs.HUD.HUDInventoryItem;
	import ten_seconds_to_live.com.five_ants.ten_secs.ItemPopUpData;
	/**
	 * ...
	 * @author 10 2  Live Team
	 */
	public class TextManager 
	{
		[Embed("/xml_assets/knowledge.xml", mimeType="application/octet-stream")]
		private const XMLKnowledge:Class;
		
		[Embed("/xml_assets/dialogs.xml", mimeType="application/octet-stream")]
		private const XMLDialogs:Class;
		
		[Embed("/xml_assets/inventory_items.xml", mimeType="application/octet-stream")]
		private const XMLInventoryItems:Class;
		
		private static var _instance:TextManager;
		
		protected var _knowledgeDictionary:Dictionary;
		protected var _dialogsDictionary:Dictionary;
		protected var _inventoryItemDictionary:Dictionary;
		
		public function TextManager() 
		{
			_knowledgeDictionary = new Dictionary();
			_dialogsDictionary = new Dictionary();
			_inventoryItemDictionary = new Dictionary();
			
			var knowledge:XML = XML(new XMLKnowledge());
			createKnowledgeDictionary(knowledge.fact)
			//setGroup(scenes.group);
			
			var dialogs:XML = XML(new XMLDialogs());
			createDialogsDictionary(dialogs.dialog)
			
			var inventoryItems:XML = XML(new XMLInventoryItems());
			createInventoryItemsDictionary(inventoryItems.item);
		}
		
		public static function get():TextManager
		{
			if (!_instance)
				_instance = new TextManager();
				
			return _instance;
		}
		
		protected function createKnowledgeDictionary(xmlList:XMLList):void
		{
			var id:String;
			var text:String;
			for (var i:int = 0; i <  xmlList.length(); i ++)
			{	
				id = xmlList[i].@id;
				text = xmlList[i].@text;
				_knowledgeDictionary[id] = text;
			}
		}
		
		protected function createDialogsDictionary(xmlList:XMLList):void
		{
			var lineList:XMLList;
			var dialog:Dialog;
			var dialogItem:DialogItem;
			var id:String;
			for (var i:int = 0; i <  xmlList.length(); i ++) {
				dialog = new Dialog();
				lineList =  xmlList[i].line;
				
				for (var j:int = 0; j < lineList.length(); j++) {
					dialogItem = new DialogItem(lineList[j].@speecher, lineList[j].@text, uint(lineList[j].@color));
					dialog.addDialogItem(dialogItem);
				}
				
				id = xmlList[i].@id;
				_dialogsDictionary[id] = dialog;
			}
		}
		
		protected function createInventoryItemsDictionary(xmlList:XMLList):void
		{
			var itemData:ItemPopUpData;
			var id:String;
			for (var i:int = 0; i <  xmlList.length(); i ++)
			{	
				itemData = new ItemPopUpData();
				itemData.title =  xmlList[i].@title;
				itemData.caption =  xmlList[i].@caption;
				id = xmlList[i].@id;
				_inventoryItemDictionary[id] = itemData;
			}
		}
		
		public function getKnowledgeTextById(id:String):String
		{
			return _knowledgeDictionary[id] as String;
		}
		
		public function getDialogById(id:String):Dialog
		{
			return _dialogsDictionary[id] as Dialog;
		}
		
		public function getInventoryItemById(id:String):ItemPopUpData
		{
			return _inventoryItemDictionary[id] as ItemPopUpData;
		}
	}

}