package ten_seconds_to_live.com.five_ants.ten_secs.object_actions 
{
	import ten_seconds_to_live.com.five_ants.ten_secs.GameplayState;
	import ten_seconds_to_live.com.five_ants.ten_secs.realities.AlternativeReality;
	/**
	 * ...
	 * @author Miguel Santirso
	 */
	public class ShowPopUp extends ObjectActionBase 
	{
		private var _description:String;
		private var _item:int;
		private var _title:String;
		
		public function ShowPopUp(itemId:int, title:String, description:String) 
		{
			_item = itemId;
			_title = title;
			_description = description;
		}
		
		
		public override function execute():void
		{
			AlternativeReality._gameplay.hud.openItemPopUp(_item, _title, _description);
		}
		
	}

}