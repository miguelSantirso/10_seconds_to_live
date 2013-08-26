package ten_seconds_to_live.com.five_ants.ten_secs 
{
	import flash.display.MovieClip;
	import ten_seconds_to_live.com.five_ants.ten_secs.object_actions.ObjectActionBase;
	import ten_seconds_to_live.com.five_ants.ten_secs.object_actions.ShowDialog;
	import ten_seconds_to_live.com.five_ants.ten_secs.object_actions.ShowPopUp;
	
	import ten_seconds_to_live.com.five_ants.ten_secs.xml.TextManager;
	
	/**
	 * ...
	 * @author Miguel Santirso
	 */
	public class SimpleCat extends InteractiveObject 
	{
		private var _finished:Boolean;
		
		public function SimpleCat(visualObject:MovieClip, roomUtils:RoomUtils)
		{
			super(visualObject, roomUtils);
		}
		
		public override function executeAllActions():void
		{
			if (_gameplay.hud.inventory.checkItemByID(Items.CATNIP) &&
				PlayerKnowledge.getKnowledge("cat_has_antidote"))
			{
				(new ShowDialog(TextManager.get().getDialogById("final_dialog"))).execute();
				_gameplay.disableTime();
			}
			else if (_gameplay.hud.inventory.checkItemByID(Items.CATNIP))
			{
				(new ShowPopUp(Items.CAT, "cat_noK")).execute();
			}
			else
			{
				(new ShowPopUp(Items.CAT, "cat_noI_noK")).execute();
			}
		}
	}

}