package ten_seconds_to_live.com.five_ants.ten_secs.object_actions 
{
	import ten_seconds_to_live.com.five_ants.ten_secs.GameplayState;
	/**
	 * ...
	 * @author Miguel Santirso
	 */
	public class ShowPopUp extends ObjectActionBase 
	{
		private var _description:String;
		private var _item:String;
		private var _title:String;
		
		public function ShowPopUp(itemId:String, title:String, description:String, gamePlayer:GameplayState) 
		{
			super(gamePlayer);
			
			_item = itemId;
			_title = title;
			_description = description;
		}
		
		
		public override function execute():void
		{
			_gameplay.hud.openItemPopUp(_item, _title, _description);
		}
		
	}

}