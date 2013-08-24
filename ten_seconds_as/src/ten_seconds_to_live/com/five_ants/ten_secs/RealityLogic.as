package ten_seconds_to_live.com.five_ants.ten_secs 
{
	import flash.display.InteractiveObject;
	import flash.utils.Dictionary;
	import ten_seconds_to_live.com.five_ants.ten_secs.interfaces.IInteractiveEntity;
	/**
	 * ...
	 * @author Miguel Santirso
	 */
	public class RealityLogic 
	{
		private var _entitiesByName:Dictionary = new Dictionary();
		
		public function registerInteractiveEntity(name:String, entity:IInteractiveObject):void
		{
			if (_entitiesByName[name])
				throw new Error("RealityLogic: More than one entity with the same name");
			
			_entitiesByName[name] = entity;
		}
		
		
		public function findEntityByName(name:String):IInteractiveEntity
		{
			if (!_entitiesByName[name])
				throw new Error("RealityLogic: There is no entity with name: " + name);
			
			return _entitiesByName[name];
		}
		
		public function onEntityInteraction(entityName:String):void
		{
			findEntityByName(entityName).executeAllActions();
		}
		
		
		
		
	}

}