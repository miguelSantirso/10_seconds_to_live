package ten_seconds_to_live.com.five_ants.ten_secs.HUD 
{
	import flash.events.MouseEvent;
	import ten_seconds_to_live.com.five_ants.ten_secs.events.InventoryItemEvent;
	/**
	 * ...
	 * @author 10 2  Live Team
	 */
	public class HUDItemPopUp extends HUDComponent 
	{
		public static const CLOSE_REQUEST_EVENT:String = "closePopupRequestEvent";
		
		protected var _type:String;
		
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
			_type = null;
			
			super.dispose();
		}
		
		public function get coreComponent():CoreItemPopUp
		{
			return _coreComponent as CoreItemPopUp;
		}
		
		public function get type():String 
		{
			return _type;
		}
		
		public function open(itemType:String):void
		{
			_type = itemType;
			
			// show the right item icon and description
			coreComponent.title.text = type + " title";
			coreComponent.caption.text = type + " description";
		}
		
		public function close():void
		{
			_type = null;
			
			coreComponent.title.text = "";
			coreComponent.caption.text = "";
		}
		
		public function onCloseClick(event:MouseEvent):void
		{
			dispatchEvent(new InventoryItemEvent(_type,CLOSE_REQUEST_EVENT));
		}
	}

}