package ten_seconds_to_live.com.five_ants.ten_secs.HUD 
{
	/**
	 * ...
	 * @author 10 2  Live Team
	 */
	public class HUDItemPopUp extends HUDComponent 
	{
		protected var _type:String;
		
		public function HUDItemPopUp() 
		{
			_coreComponent = new CoreItemPopUp();
			
			super(_coreComponent);
		}
		
		public override function dispose():void
		{
			super.dispose();
			
			_type = null;
		}
		
		public function get coreComponent():CoreItemPopUp
		{
			return _coreComponent as CoreItemPopUp;
		}
		
		public function get type():String 
		{
			return _type;
		}
		
		public function open(itemType:String):void
		{
			_type = itemType;
			
			// show the right item icon and description
			coreComponent.title.text = type + " title";
			coreComponent.caption.text = type + " description";
		}
		
		public function close():void
		{
			_type = null;
			
			// show the right item icon and description
			coreComponent.title.text = "";
			coreComponent.caption.text = "";
		}
	}

}