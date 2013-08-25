package ten_seconds_to_live.com.five_ants.ten_secs 
{
	/**
	 * ...
	 * @author 10 2  Live Team
	 */
	public class DialogItem 
	{
		protected var _speecher:String;
		protected var _text:String;
		protected var _color:uint;
		
		public function DialogItem(speecher:String = "", text:String = "", color:uint = 0) 
		{
			_speecher = speecher;
			_text = text;
			_color = color;
		}
		
		public function get text():String 
		{
			return _text;
		}
		
		public function set text(value:String):void 
		{
			_text = value;
		}
		
		public function get color():uint 
		{
			return _color;
		}
		
		public function set color(value:uint):void 
		{
			_color = value;
		}
		
		public function get speecher():String 
		{
			return _speecher;
		}
		
		public function set speecher(value:String):void 
		{
			_speecher = value;
		}
		
		
	}

}