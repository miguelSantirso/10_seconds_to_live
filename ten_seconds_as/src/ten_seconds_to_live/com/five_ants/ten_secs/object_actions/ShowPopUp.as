package ten_seconds_to_live.com.five_ants.ten_secs.object_actions 
{
	import ten_seconds_to_live.com.five_ants.ten_secs.GameplayState;
	import ten_seconds_to_live.com.five_ants.ten_secs.ItemPopUpData;
	import ten_seconds_to_live.com.five_ants.ten_secs.realities.AlternativeReality;
	import ten_seconds_to_live.com.five_ants.ten_secs.events.InventoryItemEvent;
	import ten_seconds_to_live.com.five_ants.ten_secs.HUD.HUD;
	import ten_seconds_to_live.com.five_ants.ten_secs.Items;
	import ten_seconds_to_live.com.five_ants.ten_secs.xml.TextManager;
	import ten_seconds_to_live.com.five_ants.ten_secs.object_actions.PlaySound;
	import ten_seconds_to_live.com.five_ants.ten_secs.Sounds;
	
	/**
	 * ...
	 * @author Miguel Santirso
	 */
	public class ShowPopUp extends ObjectActionBase 
	{
		protected var _itemId:int;
		protected var _itemData:ItemPopUpData;
		
		public function ShowPopUp(itemId:int, itemTag:String) 
		{
			_itemId = itemId;
			
			if(itemTag)
				_itemData = TextManager.get().getInventoryItemById(itemTag);
			else
				_itemData = new ItemPopUpData();
		}
		
		
		public override function execute():void
		{
			AlternativeReality._gameplay.hud.openItemPopUp(_itemId, _itemData.title, _itemData.caption);
			//AlternativeReality._gameplay.hud.addEventListener(HUD.POPUP_CLOSED_EVENT, onClosePopup, false, 0, true);
			
			//(new PlaySound(Sounds.AMBIENT_LOOP_2)).execute();
		}
		
		private function onClosePopup(event:InventoryItemEvent):void
		{
			AlternativeReality._gameplay.hud.removeEventListener(HUD.POPUP_CLOSED_EVENT, onClosePopup);
			
			//(new StopSound(Sounds.AMBIENT_LOOP_2)).execute();
		}
		
	}

}