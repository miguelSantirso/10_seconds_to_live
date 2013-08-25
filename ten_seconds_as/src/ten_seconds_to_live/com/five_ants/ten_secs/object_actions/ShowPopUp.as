package ten_seconds_to_live.com.five_ants.ten_secs.object_actions 
{
	import ten_seconds_to_live.com.five_ants.ten_secs.GameplayState;
	import ten_seconds_to_live.com.five_ants.ten_secs.ItemPopUpData;
	import ten_seconds_to_live.com.five_ants.ten_secs.realities.AlternativeReality;
	import ten_seconds_to_live.com.five_ants.ten_secs.events.InventoryItemEvent;
	import ten_seconds_to_live.com.five_ants.ten_secs.HUD.HUD;
	/**
	 * ...
	 * @author Miguel Santirso
	 */
	public class ShowPopUp extends ObjectActionBase 
	{
		protected var _itemId:int;
		protected var _itemData:ItemPopUpData;
		
		public function ShowPopUp(itemId:int, itemData:ItemPopUpData) 
		{
			_itemId = itemId;
			
			if(_itemData)
				_itemData = itemData;
			else
				_itemData = new ItemPopUpData();
		}
		
		
		public override function execute():void
		{
			AlternativeReality._gameplay.hud.openItemPopUp(_itemId, _itemData.title, _itemData.caption);
			AlternativeReality._gameplay.playerInput.enabled = false;
			AlternativeReality._gameplay.hud.addEventListener(HUD.POPUP_CLOSED_EVENT, onClosePopup, false, 0, true);
		}
		
		private function onClosePopup(event:InventoryItemEvent):void
		{
			AlternativeReality._gameplay.playerInput.enabled = true;
		}
		
	}

}