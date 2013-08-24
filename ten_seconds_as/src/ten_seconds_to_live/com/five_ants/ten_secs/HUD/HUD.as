package ten_seconds_to_live.com.five_ants.ten_secs.HUD 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import ten_seconds_to_live.com.five_ants.ten_secs.interfaces.IInitializable;
	import ten_seconds_to_live.com.five_ants.ten_secs.interfaces.IDisposable;
	import ten_seconds_to_live.com.five_ants.ten_secs.interfaces.IUpdateable;
	/**
	 * ...
	 * @author 10 2  Live Team
	 */
	public class HUD extends Sprite implements IInitializable, IDisposable, IUpdateable
	{
		public static const POPUP_OPENED_EVENT:String = "popupOpenedEvent";
		public static const POPUP_CLOSED_EVENT:String = "popupClosedEvent";
		
		protected var _hudClock:HUDClock;
		protected var _hudInventory:HUDInventory;
		protected var _hudItemPopUp:HUDItemPopUp;
		
		public function HUD() 
		{
			_hudClock = new HUDClock();
			_hudInventory = new HUDInventory();
			_hudItemPopUp = new HUDItemPopUp();
		}
		
		public function init():void
		{
			_hudClock.x = _hudClock.y = 6;
			
			_hudInventory.x = 6;
			_hudInventory.y = 494;
			
			_hudItemPopUp.x = (800 - _hudItemPopUp.width) * 0.5;
			_hudItemPopUp.y = (600 - _hudItemPopUp.height) * 0.5;
			
			addChild(_hudClock);
			addChild(_hudInventory);
		}
		
		public function dispose():void
		{
			_hudClock.dispose();
			_hudInventory.dispose();
			
			_hudClock = null;
			_hudInventory = null;
		}
		
		public function update():void
		{
			
		}
		
		public function set slowmo(isActive:Boolean):void
		{
			_hudClock.slowmo = isActive;
		}
		
		public function set time(seconds:String):void
		{
			_hudClock.time = seconds;
		}
		
		public function get inventory():HUDInventory
		{
			return _hudInventory;
		}
		
		public function openItemPopUp(itemType:String):void
		{
			_hudItemPopUp.type = itemType;
			
			addChild(_hudItemPopUp);
			dispatchEvent(new Event(POPUP_OPENED_EVENT));
		}
		
		public function closeItemPopUp():void
		{
			removeChild(_hudItemPopUp);
			dispatchEvent(new Event(POPUP_CLOSED_EVENT));
		}
	}

}