package ten_seconds_to_live.com.five_ants.ten_secs.object_actions 
{
	/**
	 * ...
	 * @author Miguel Santirso
	 */
	public class ChangeCollision extends ObjectActionBase 
	{
		private var _collisionBlock:String;
		
		private var _toEnabled:Boolean;
		
		public function ChangeCollision(collisionBlockName:String, toEnabled:Boolean) 
		{
			_collisionBlock = collisionBlockName;
			_toEnabled = toEnabled;
		}
		
		
		public override function execute():void
		{
			_gameplay.collisions.changeCollision(_collisionBlock, _toEnabled);
		}
		
	}

}