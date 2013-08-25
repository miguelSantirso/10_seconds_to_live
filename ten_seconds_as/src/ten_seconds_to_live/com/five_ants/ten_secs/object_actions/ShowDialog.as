package ten_seconds_to_live.com.five_ants.ten_secs.object_actions 
{
	import ten_seconds_to_live.com.five_ants.ten_secs.Dialog;
	/**
	 * ...
	 * @author Miguel Santirso
	 */
	public class ShowDialog extends ObjectActionBase 
	{
		private var _dialog:Dialog;
		
		public function ShowDialog(dialog:Dialog) 
		{
			_dialog = dialog;
		}
		
		public override function execute():void
		{
			_gameplay.hud.openDialog(_dialog);
		}
		
	}

}