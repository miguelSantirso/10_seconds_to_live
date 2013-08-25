package ten_seconds_to_live.com.five_ants.ten_secs 
{
	import flash.events.Event;
	import flash.utils.Dictionary;
	import ten_seconds_to_live.com.five_ants.ten_secs.HUD.HUDItemPopUp;
	import ten_seconds_to_live.com.five_ants.ten_secs.interfaces.IInteractiveEntity;
	import ten_seconds_to_live.com.five_ants.ten_secs.events.InteractiveObjectEvent;
	/**
	 * ...
	 * @author Miguel Santirso
	 */
	public class RealityLogic 
	{
		private var _entitiesByName:Dictionary = new Dictionary();
		
		public function registerInteractiveEntity(name:String, entity:IInteractiveEntity):void
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
		public function removeEntityByName(name:String):IInteractiveEntity
		{
			var entity:IInteractiveEntity = findEntityByName(name);
			
			delete _entitiesByName[name];
			
			return entity;
		}
		
		public function onEntityInteraction(entityName:String):void
		{
			findEntityByName(entityName).executeAllActions();
		}
		
		public function set showInteractionRadiuses(value:Boolean):void
		{
			for each(var entity:IInteractiveEntity in _entitiesByName)
			{
				entity.showRadius = value;
			}
		}
		
		public function set enableAllInteractions(value:Boolean):void
		{
			for each(var entity:IInteractiveEntity in _entitiesByName)
			{
				entity.enableInteractions = value;
			}
		}
	
		public function update(player:Player, playerInput:IPlayerInput):void
		{
			for each(var entity:IInteractiveEntity in _entitiesByName)
			{
				entity.checkPlayerCollision(player, playerInput);
			}
		}
		
	}

}