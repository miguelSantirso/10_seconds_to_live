package ten_seconds_to_live.com.five_ants.ten_secs.HUD 
{
	import flash.events.Event;
	import ten_seconds_to_live.com.five_ants.ten_secs.GameplayState;
	import ten_seconds_to_live.com.five_ants.ten_secs.xml.TextManager;
	/**
	 * ...
	 * @author 10 2  Live Team
	 */
	public class HUDKnowledgeList extends HUDComponent 
	{
		public static const CLOSE_REQUEST_EVENT:String = "closeKnowledgeListRequestEvent";
		
		protected var _knowledgeItems:Vector.<HUDKnowledgeItem>
		
		protected const _itemGap:int = 6;
		
		protected var _ePressed:Boolean = false;
		
		public function HUDKnowledgeList() 
		{
			_coreComponent = new CoreKnowledgeList();
			
			super(_coreComponent);
		}
		
		public override function init():void
		{
			super.init();
		}
		
		public override function dispose():void
		{
			disposeItems();
		
			super.dispose();
		}
		
		protected function disposeItems():void
		{
			if(_knowledgeItems){
				for (var i:int = 0; i < _knowledgeItems.length; i++) {
					if(contains(_knowledgeItems[i]))
						removeChild(_knowledgeItems[i]);
				}
				_knowledgeItems.splice(0, _knowledgeItems.length);
				_knowledgeItems = null;
			}
		}
		
		public override function update():void
		{
			super.update();
			
			if (!_ePressed && GameplayState.playerInput.actionPressed) {
				onClose();
				_ePressed = true;
			}else if (!GameplayState.playerInput.actionPressed)
				_ePressed = false;
		}
		
		public function get coreComponent():CoreKnowledgeList
		{
			return _coreComponent as CoreKnowledgeList;
		}
		
		public function open(knowledgeVector:Vector.<String>):void
		{
			if (knowledgeVector) {
				if (_knowledgeItems)
					disposeItems();
					
				_knowledgeItems = new Vector.<HUDKnowledgeItem>();
				
				var tempKnowledgeItem:HUDKnowledgeItem;
				
				for (var i:int = 0; i < knowledgeVector.length; i++) {
					tempKnowledgeItem = new HUDKnowledgeItem(TextManager.get().getKnowledgeTextById(knowledgeVector[i]));
					tempKnowledgeItem.x = coreComponent.list_marker.x;
					tempKnowledgeItem.y = coreComponent.list_marker.y + (tempKnowledgeItem.height + _itemGap) * i;
					
					_knowledgeItems.push(tempKnowledgeItem);
					addChild(tempKnowledgeItem);
				}				
			}
		}
		
		public function close():void
		{
			disposeItems();
		}
		
		public function onClose():void
		{
			dispatchEvent(new Event(CLOSE_REQUEST_EVENT));
		}
	}

}