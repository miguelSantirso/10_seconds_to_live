package ten_seconds_to_live.com.five_ants.ten_secs.HUD 
{
	import com.greensock.TweenLite
	import flash.events.Event;
	import ten_seconds_to_live.com.five_ants.ten_secs.Dialog;
	import ten_seconds_to_live.com.five_ants.ten_secs.GameplayState;
	/**
	 * ...
	 * @author 10 2  Live Team
	 */
	public class HUDDialog extends HUDComponent 
	{
		public static const DIALOG_COMPLETE_EVENT:String = "dialogCompleteEvent";
		
		protected var _dialog:Dialog;
		
		protected var _hudDialogItems:Vector.<HUDDialogItem>;
		
		protected var _currentItems:Vector.<HUDDialogItem>;
		
		protected var _textMoving:Boolean = false;
		protected var _complete:Boolean = false;
		
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
			
			coreComponent.continueLabel.visible = false;
			coreComponent.skipLabel.visible = false;
		}
		
		public override function dispose():void
		{
			super.dispose();
			
			disposeItems();
			
			_hudDialogItems = null;
			_currentItems = null;
		}
		
		public override function update():void
		{
			if (!_textMoving && GameplayState.playerInput.spacebarPressed)
				nextDialogItem();
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
			
			
			_textMoving = false;
			_complete = false;
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
			if (value) {
				_dialog = value;
				
				disposeItems();
				
				var tempHUDDialogItem:HUDDialogItem;
				for (var i:int = 0; i < _dialog.dialogItems.length ; i++) {
					tempHUDDialogItem = new HUDDialogItem();
					tempHUDDialogItem.dialogItem = _dialog.dialogItems[i];
					
					_hudDialogItems.push(tempHUDDialogItem);
				}
				
				coreComponent.skipLabel.visible = true;
				
				// start dialogs
				TweenLite.delayedCall(1.0, nextDialogItem);
			}
		}
		
		protected function nextDialogItem():void
		{
			if (_complete)
				return;
				
			var nextItem:HUDDialogItem;
			
			if (_hudDialogItems.length > 0) {
				coreComponent.continueLabel.visible = false;
				_textMoving = true;
				
				nextItem = _hudDialogItems.shift();
				nextItem.x = coreComponent.listMarker.x;
				nextItem.y = coreComponent.listMarker.y;
				nextItem.visible = false;
				addChild(nextItem);
				
				_currentItems.unshift(nextItem);

				checkDialogItemToRemove();
				
				TweenLite.from(nextItem, 0.5, 
					{ y : nextItem.y + nextItem.height, onComplete : 
						function():void {
							nextItem.visible = true;
							_textMoving = false;
							coreComponent.continueLabel.visible = true;
						} 
					});
									
				for (var i:int = 1; i < _currentItems.length ; i++) {
					TweenLite.to(_currentItems[i], 0.5, { y : coreComponent.listMarker.y - nextItem.height*i});	
				}
			}else {
				_complete = true;
				dispatchEvent(new Event(DIALOG_COMPLETE_EVENT));
				trace("dialog finished");
			}
		}
		
		protected function checkDialogItemToRemove():void
		{
			if (_currentItems.length > 3){
				var removingItem:HUDDialogItem = _currentItems.pop();
				if (contains(removingItem))
				removeChild(removingItem);
			}
		}
	}

}