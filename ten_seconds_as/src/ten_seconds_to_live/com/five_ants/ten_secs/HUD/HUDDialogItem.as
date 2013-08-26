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
		
		public override function init():void
		{
			super.init();
		}
		
		public override function dispose():void
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
				coreComponent.speecher.textColor = _dialogItem.color;
				coreComponent.speecher.text = _dialogItem.speecher + ": ";
				coreComponent.line.text = _dialogItem.text;
				coreComponent.line.x = coreComponent.speecher.x + coreComponent.speecher.textWidth;
			}
		}
		
		
	}

}