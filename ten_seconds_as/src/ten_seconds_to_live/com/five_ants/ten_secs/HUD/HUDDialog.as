package ten_seconds_to_live.com.five_ants.ten_secs.HUD 
{
	import ten_seconds_to_live.com.five_ants.ten_secs.Dialog;
	/**
	 * ...
	 * @author 10 2  Live Team
	 */
	public class HUDDialog extends HUDComponent 
	{
		protected var _dialog:Dialog;
		
		public function HUDDialog() 
		{
			_coreComponent = new CoreDialog();
			
			super(_coreComponent);
		}
		
		public override function init():void
		{
			super.init();
		}
		
		public override function dispose():void
		{
			super.dispose();
		}
		
		protected function get coreComponent():CoreDialog
		{
			return _coreComponent as CoreDialog;
		}
		
		public function get dialog():Dialog 
		{
			return _dialog;
		}
		
		public function set dialog(value:Dialog):void 
		{
			if(value){
				_dialog = value;
				// start movement
				// dispatch event?
			}
		}
	}

}