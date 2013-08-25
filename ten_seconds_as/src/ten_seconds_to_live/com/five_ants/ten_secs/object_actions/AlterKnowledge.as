package ten_seconds_to_live.com.five_ants.ten_secs.object_actions 
{
	import ten_seconds_to_live.com.five_ants.ten_secs.PlayerKnowledge;
	
	/**
	 * ...
	 * @author Miguel Santirso
	 */
	public class AlterKnowledge extends ObjectActionBase 
	{
		private var _knowledgeItem:int;
		
		public function AlterKnowledge(knowledgeItem:int)
		{
			_knowledgeItem = knowledgeItem;
		}
		
		
		public override function execute():void
		{
			PlayerKnowledge.learnKnowledge(_knowledgeItem);
		}
		
	}

}