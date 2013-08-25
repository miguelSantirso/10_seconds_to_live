package ten_seconds_to_live.com.five_ants.ten_secs.object_actions 
{
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author Miguel Santirso
	 */
	public class ChangeEntityAnimation extends ObjectActionBase 
	{
		private var _entityName:String;
		private var _animationClass:Class;
		
		public function ChangeEntityAnimation(entityName:String, animationClass:Class) 
		{
			_entityName = entityName;
			_animationClass = animationClass;
		}
		
		public override function execute():void
		{
			_gameplay.currentReality.findInteractiveObject(_entityName).setAnimation(new _animationClass() as MovieClip);
		}
		
		
	}

}