package ten_seconds_to_live.com.five_ants.ten_secs.HUD 
{
	/**
	 * ...
	 * @author 10 2  Live Team
	 */
	public class HUDKnowledgeList extends HUDComponent 
	{
		protected var _knowledgeVector:Vector.<String>;
		
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
			_knowledgeVector = knowledgeVector;
		}
		
		public function close():void
		{
			if(_knowledgeVector)
				_knowledgeVector.splice(0, _knowledgeVector.length);
			_knowledgeVector = null;
		}
	}

}