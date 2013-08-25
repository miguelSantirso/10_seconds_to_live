package ten_seconds_to_live.com.five_ants.ten_secs 
{
	import ten_seconds_to_live.com.five_ants.ten_secs.interfaces.IDisposable;
	/**
	 * ...
	 * @author 10 2  Live Team
	 */
	public class Dialog implements IDisposable
	{
		protected var _dialogItems:Vector.<DialogItem>;
		
		public function Dialog() 
		{
			_dialogItems = new Vector.<DialogItem>();
		}
		
		public function dispose():void
		{
			_dialogItems.splice(0, _dialogItems.length);
			_dialogItems = null;
		}
		
		public function get dialogItems():Vector.<DialogItem> 
		{
			return _dialogItems;
		}
		
		public function addDialogItem(dialogItem:DialogItem):void
		{
			_dialogItems.push(dialogItem);
		}
		
	}

}