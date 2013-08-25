package ten_seconds_to_live.com.five_ants.ten_secs.object_actions 
{
	import ten_seconds_to_live.com.five_ants.ten_secs.realities.AlternativeReality;
	
	/**
	 * ...
	 * @author Miguel Santirso
	 */
	public class RemoveInteractiveObject extends ObjectActionBase 
	{
		private var _objName:String;
		
		public function RemoveInteractiveObject(intObjName:String) 
		{
			_objName = intObjName;
		}
		
		
		public override function execute():void
		{
			AlternativeReality._gameplay.currentReality.removeInteractiveObject(_objName);
		}
		
	}

}