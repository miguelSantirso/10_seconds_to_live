package ten_seconds_to_live.com.five_ants.ten_secs.HUD 
{
	import com.greensock.TweenLite
	import ten_seconds_to_live.com.five_ants.ten_secs.Dialog;
	/**
	 * ...
	 * @author 10 2  Live Team
	 */
	public class HUDDialog extends HUDComponent 
	{
		protected var _dialog:Dialog;
		
		protected var _hudDialogItems:Vector.<HUDDialogItem>;
		
		protected var _currentItems:Vector.<HUDDialogItem>;
		
		public function HUDDialog() 
		{
			_coreComponent = new CoreDialog();
			_hudDialogItems = new Vector.<HUDDialogItem>();
			_currentItems = new Vector.<HUDDialogItem>();
			
			super(_coreComponent);
		}
		
		public override function init():void
		{
			super.init();
		}
		
		public override function dispose():void
		{
			super.dispose();
			
			disposeItems();
			_hudDialogItems = null;
			_currentItems = null;
		}
		
		protected function disposeItems():void
		{
			TweenLite.killTweensOf(this,true);
			
			for (var i:int = 0; i < _hudDialogItems.length; i++) {
				if (contains(_hudDialogItems[i]))
					removeChild(_hudDialogItems[i]);
			}
			_hudDialogItems.splice(0, _hudDialogItems.length);
			
			for (var j:int = 0; j < _currentItems.length; j++) {
				TweenLite.killTweensOf(_currentItems[j]);
			}
			_currentItems.splice(0, _currentItems.length);
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
				
				disposeItems();
				
				var tempHUDDialogItem:HUDDialogItem;
				for (var i:int = 0; i < _dialog.dialogItems.length ; i++) {
					tempHUDDialogItem = new HUDDialogItem();
					tempHUDDialogItem.dialogItem = _dialog.dialogItems[i];
					
					_hudDialogItems.push(tempHUDDialogItem);
				}
				// start movement
				// dispatch event?
				TweenLite.delayedCall(3.0, nextDialogItem);
			}
		}
		
		protected function nextDialogItem():void
		{
			var nextItem:HUDDialogItem;
			
			if (_hudDialogItems.length > 0) {
				nextItem = _hudDialogItems.shift();
				
				_currentItems.unshift(nextItem);
				
				if (_currentItems.length >= 3)
					_currentItems.pop();
				
					//nextItem.
				addChild(nextItem);
			}else {
				// Dialog finished
			}
		}
	}

}