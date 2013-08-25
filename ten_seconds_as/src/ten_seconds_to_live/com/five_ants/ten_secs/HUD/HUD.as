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
		public static const KNOWLEDGE_OPENED_EVENT:String = "knowledgeOpenedEvent";
		public static const KNOWLEDGE_CLOSED_EVENT:String = "knowledgeClosedEvent";
		
		protected var _hudClock:HUDClock;
		protected var _hudInventory:HUDInventory;
		protected var _hudItemPopUp:HUDItemPopUp;
		protected var _hudKnowledgeList:HUDKnowledgeList;
		
		protected var _enabled:Boolean;
		
		public function HUD() 
		{
			_hudClock = new HUDClock();
			_hudInventory = new HUDInventory();
			_hudItemPopUp = new HUDItemPopUp();
			_hudKnowledgeList = new HUDKnowledgeList();
			
			_enabled = true;
		}
		
		public function init():void
		{
			_hudClock.x = _hudClock.y = 6;
			
			_hudInventory.x = 6;
			_hudInventory.y = 494;
			
			_hudItemPopUp.x = (800 - _hudItemPopUp.width) * 0.5;
			_hudItemPopUp.y = (600 - _hudItemPopUp.height) * 0.5;
			
			_hudKnowledgeList.x = (800 - _hudKnowledgeList.width) * 0.5;
			_hudKnowledgeList.y = 600 - _hudKnowledgeList.height;
			
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
		
		public function get enabled():Boolean 
		{
			return _enabled;
		}
		
		public function set enabled(value:Boolean):void 
		{
			if (value && !_enabled) {
				// enable
				_hudClock.visible = true;
				_hudInventory.visible = true;
				_hudItemPopUp.visible = true;
				_hudKnowledgeList.visible = true;
			}else if (!value && _enabled) {
				// disable
				_hudClock.visible = false;
				_hudInventory.visible = false;
				_hudItemPopUp.visible = false;
				_hudKnowledgeList.visible = false;
			}
			
			_enabled = value;
		}
		
		public function openItemPopUp(itemType:String):void
		{
			_hudItemPopUp.open(itemType);
			
			addChild(_hudItemPopUp);
			
			dispatchEvent(new Event(POPUP_OPENED_EVENT));
		}
		
		public function closeItemPopUp():void
		{
			_hudItemPopUp.close();
			
			removeChild(_hudItemPopUp);
			
			dispatchEvent(new Event(POPUP_CLOSED_EVENT));
		}
		
		public function openKnowledgeList(knowledgeVector:Vector.<String>):void
		{
			_hudKnowledgeList.open(knowledgeVector);
			
			addChild(_hudKnowledgeList);
			
			dispatchEvent(new Event(KNOWLEDGE_OPENED_EVENT));
		}
		
		public function closeKnowledgeList():void
		{
			_hudKnowledgeList.close();
			
			removeChild(_hudKnowledgeList);
			
			dispatchEvent(new Event(KNOWLEDGE_CLOSED_EVENT));
		}
	}

}