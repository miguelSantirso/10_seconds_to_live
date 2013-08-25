package ten_seconds_to_live.com.five_ants.ten_secs.HUD 
{
	/**
	 * ...
	 * @author 10 2  Live Team
	 */
	public class HUDKnowledgeList extends HUDComponent 
	{
		protected var _knowledgeVector:Vector.<String>;
		
		protected const _itemGap:int = 6;
		
		public function HUDKnowledgeList() 
		{
			_coreComponent = new CoreKnowledgeList();
			
			super(_coreComponent);
		}
		
		public function get coreComponent():CoreKnowledgeList
		{
			return _coreComponent as CoreKnowledgeList;
		}
		
		public function open(knowledgeVector:Vector.<String>):void
		{
			if (knowledgeVector) {
				_knowledgeVector = knowledgeVector;
				
				var tempKnowledgeItem:CoreKnowledgeListItem;
				
				for (var i:int = 0; i < _knowledgeVector.length; i++) {
					tempKnowledgeItem = new CoreKnowledgeListItem();
					
					// set the right text
					tempKnowledgeItem.label.text = "I know " + _knowledgeVector[i];
					tempKnowledgeItem.x = coreComponent.list_marker.x;
					tempKnowledgeItem.y = coreComponent.list_marker.y + (tempKnowledgeItem.height + _itemGap) * i;
					
					addChild(tempKnowledgeItem);
				}				
			}
		}
		
		public function close():void
		{
			if(_knowledgeVector)
				_knowledgeVector.splice(0, _knowledgeVector.length);
			_knowledgeVector = null;
		}
	}

}