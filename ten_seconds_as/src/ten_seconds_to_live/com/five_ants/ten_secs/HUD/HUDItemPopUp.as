package ten_seconds_to_live.com.five_ants.ten_secs.HUD 
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import ten_seconds_to_live.com.five_ants.ten_secs.events.InventoryItemEvent;
	import ten_seconds_to_live.com.five_ants.ten_secs.Items;
	
	/**
	 * ...
	 * @author 10 2  Live Team
	 */
	public class HUDItemPopUp extends HUDComponent 
	{
		public static const CLOSE_REQUEST_EVENT:String = "closePopupRequestEvent";
		
		protected var _itemId:String;
		
		public function HUDItemPopUp() 
		{
			_coreComponent = new CoreItemPopUp();
			
			super(_coreComponent);
		}
		
		public override function init():void
		{
			super.init();
			
			coreComponent.addEventListener(MouseEvent.CLICK, onCloseClick, false, 0, true);
		}
		
		public override function dispose():void
		{
			coreComponent.removeEventListener(MouseEvent.CLICK, onCloseClick);	
			_itemId = null;
			
			super.dispose();
		}
		
		public function get coreComponent():CoreItemPopUp
		{
			return _coreComponent as CoreItemPopUp;
		}
		
		public function get type():String 
		{
			return _itemId;
		}
		
		public function set item(itemId:int):void
		{
			var iconContainer:MovieClip = _coreComponent.iconContainer;
			while (iconContainer.numChildren > 0)
				iconContainer.removeChildAt(0);
			
			var itemMc:MovieClip = Items.getItemById(itemId);
			iconContainer.addChild(itemMc);
		}
		public function set title(value:String):void
		{
			_coreComponent.title.text = value;
		}
		public function set description(value:String):void
		{
			_coreComponent.caption.text = value;
		}
		
		public function onCloseClick(event:MouseEvent):void
		{
			dispatchEvent(new InventoryItemEvent(_itemId, CLOSE_REQUEST_EVENT));
		}
	}

}