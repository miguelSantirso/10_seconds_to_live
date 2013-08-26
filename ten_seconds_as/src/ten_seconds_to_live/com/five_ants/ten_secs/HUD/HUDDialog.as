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
		
		protected var _currentItem:HUDDialogItem;
		
		protected var _textMoving:Boolean = false;
		protected var _complete:Boolean = false;
				
		protected var _continuing:Boolean = false;
		
		public function HUDDialog() 
		{
			_coreComponent = new CoreDialog();
			_hudDialogItems = new Vector.<HUDDialogItem>();
			
			super(_coreComponent);
		}
		
		public override function init():void
		{
			super.init();
			
			coreComponent.continueLabel.visible = false;
			//coreComponent.skipLabel.visible = false;
			coreComponent.endLabel.visible = false;
		}
		
		public override function dispose():void
		{
			super.dispose();
			
			disposeItems();
			
			_hudDialogItems = null;
			_currentItem = null;
		}
		
		public override function update():void
		{
			if (!_continuing && !_textMoving && GameplayState.playerInput.escapePressed) {
				_continuing = true;
				nextDialogItem();
			}else if (!GameplayState.playerInput.escapePressed){
				_continuing = false;
			}
		}
		
		protected function disposeItems():void
		{
			TweenLite.killTweensOf(this,true);
			
			for (var i:int = 0; i < _hudDialogItems.length; i++) {
				if (contains(_hudDialogItems[i]))
					removeChild(_hudDialogItems[i]);
			}
			_hudDialogItems.splice(0, _hudDialogItems.length);
			
			if (_currentItem && contains(_currentItem))
				removeChild(_currentItem);
			
			_currentItem = null;
			
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
				
				//coreComponent.skipLabel.visible = true;
				
				// start dialogs
				_textMoving = true;
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
				//if (_hudDialogItems.length <= 1)
				//	coreComponent.skipLabel.visible = false;
				_textMoving = true;
				
				if (_currentItem && contains(_currentItem))
					removeChild(_currentItem);
				
				_currentItem = nextItem = _hudDialogItems.shift();
				_currentItem.x = coreComponent.listMarker.x;
				_currentItem.y = coreComponent.listMarker.y;
				
				addChild(nextItem);
			
				TweenLite.from(_currentItem, 0.5, 
					{ y : coreComponent.listMarker.y + _currentItem.height , onComplete :
						function():void {
							_textMoving = false;
							
							if(_hudDialogItems.length > 0){
								coreComponent.continueLabel.visible = true;							
							}else{
								coreComponent.endLabel.visible = true;
							}
						} 
					});
					
			}else {
				_complete = true;
				
				dispatchEvent(new Event(DIALOG_COMPLETE_EVENT));
			}
		}
	}

}