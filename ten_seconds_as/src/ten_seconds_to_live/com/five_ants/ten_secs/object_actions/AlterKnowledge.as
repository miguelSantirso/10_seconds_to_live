package ten_seconds_to_live.com.five_ants.ten_secs.object_actions 
{
	import ten_seconds_to_live.com.five_ants.ten_secs.GameplayState;
	import ten_seconds_to_live.com.five_ants.ten_secs.PlayerKnowledge;
	import ten_seconds_to_live.com.five_ants.ten_secs.realities.AlternativeReality;
	
	/**
	 * ...
	 * @author Miguel Santirso
	 */
	public class AlterKnowledge extends ObjectActionBase 
	{
		private var _knowledgeItem:String;
		
		public function AlterKnowledge(knowledgeItem:String)
		{
			_knowledgeItem = knowledgeItem;
		}
		
		
		public override function execute():void
		{
			PlayerKnowledge.learnKnowledge(_knowledgeItem);
		}
		
	}

}