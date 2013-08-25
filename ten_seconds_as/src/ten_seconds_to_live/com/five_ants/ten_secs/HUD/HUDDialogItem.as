package ten_seconds_to_live.com.five_ants.ten_secs.HUD 
{
	import ten_seconds_to_live.com.five_ants.ten_secs.DialogItem;
	/**
	 * ...
	 * @author 10 2  Live Team
	 */
	public class HUDDialogItem extends HUDComponent 
	{
		protected var _dialogItem:DialogItem;
		
		public function HUDDialogItem() 
		{
			_coreComponent = new CoreDialogItem();
			
			super(_coreComponent);
		}
		
		protected override function init():void
		{
			super.init();
		}
		
		protected override function dispose():void
		{
			super.dispose();
		}
		
		protected function get coreComponent():CoreDialogItem
		{
			return _coreComponent as CoreDialogItem;
		}
		
		public function set dialogItem(value:DialogItem):void 
		{
			if(value){
				_dialogItem = value;
				coreComponent.label.text = _dialogItem.text;
				coreComponent.label.textColor = _dialogItem.color;
			}
		}
		
		
	}

}