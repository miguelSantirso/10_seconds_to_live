package ten_seconds_to_live.com.five_ants.ten_secs.HUD 
{
	/**
	 * ...
	 * @author 10 2  Live Team
	 */
	public class HUDKnowledgeItem extends HUDComponent 
	{
		protected var _type:String;
		
		public function HUDKnowledgeItem(knowledgeType:String = null) 
		{
			_coreComponent = new CoreKnowledgeListItem();
						
			super(_coreComponent);
		
			if (knowledgeType)
				type = knowledgeType;
		}
		
		public override function init():void
		{
			super.init();
		}
		
		public override function dispose():void
		{
			super.dispose();
		}
		
		protected function get coreComponent():CoreKnowledgeListItem
		{
			return _coreComponent as CoreKnowledgeListItem;
		}
		
		public function get type():String
		{
			return _type;
		}
		
		public function set type(value:String):void
		{
			if (value) {				
				_type = value;
				
				// set the right text
				coreComponent.label.text = "I know " + _type + ".";
			}
		}
		
	}

}