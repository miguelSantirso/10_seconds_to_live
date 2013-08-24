package ten_seconds_to_live.com.five_ants.ten_secs.HUD 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import ten_seconds_to_live.com.five_ants.ten_secs.interfaces.IInitializable;
	import ten_seconds_to_live.com.five_ants.ten_secs.interfaces.IDisposable;
	/**
	 * ...
	 * @author 10 2  Live Team
	 */
	public class HUDComponent extends Sprite implements IInitializable, IDisposable
	{
		protected var _coreComponent:MovieClip;
		
		public function HUDComponent(coreComponent:MovieClip) 
		{
			_coreComponent = coreComponent;
			
			init();
		}
		
		public function init():void
		{
			addChild(_coreComponent);
		}
		
		public function dispose():void 
		{
			removeChild(_coreComponent);
			_coreComponent = null;
		}
	}

}