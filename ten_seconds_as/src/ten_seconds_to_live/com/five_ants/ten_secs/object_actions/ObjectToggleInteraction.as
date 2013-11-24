package ten_seconds_to_live.com.five_ants.ten_secs.object_actions 
{
	import ten_seconds_to_live.com.five_ants.ten_secs.realities.AlternativeReality;
	
	/**
	 * ...
	 * @author Miguel Santirso
	 */
	public class ObjectToggleInteraction extends ObjectActionBase 
	{
		private var _objName:String;
		private var _valueToSet:Boolean;
		
		public function ObjectToggleInteraction(intObjName:String, setInteractionEnabled:Boolean)
		{
			_objName = intObjName;
			_valueToSet = setInteractionEnabled;
		}
		
		public override function execute():void
		{
			AlternativeReality._gameplay.currentReality.findInteractiveObject(_objName).enableInteractions = _valueToSet;
		}
		
	}

}