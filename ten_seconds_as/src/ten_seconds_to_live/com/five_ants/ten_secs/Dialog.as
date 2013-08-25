package ten_seconds_to_live.com.five_ants.ten_secs 
{
	import ten_seconds_to_live.com.five_ants.ten_secs.interfaces.IDisposable;
	/**
	 * ...
	 * @author 10 2  Live Team
	 */
	public class Dialog implements IDisposable
	{
		protected var _dialogItems:Vector.<DialogItem>;
		
		public function Dialog() 
		{
			_dialogItems = new Vector.<DialogItem>();
		}
		
		public function populate(xmlObject:Object):void
		{
			_dialogItems.splice(0, _dialogItems.length);
			
			// fill
			
			// temp
			_dialogItems.push(new DialogItem("Albert", "Hola Andreu", 0x00ff00));
			_dialogItems.push(new DialogItem("Andreu", "Qué bonito", 0x000000));
			_dialogItems.push(new DialogItem("Albert", "Te gusta Boombang?", 0x00ff00));
			_dialogItems.push(new DialogItem("Andreu", "Claro, y Shakira también", 0x000000));
		}
		
		public function dispose():void
		{
			_dialogItems.splice(0, _dialogItems.length);
			_dialogItems = null;
		}
		
		public function get dialogItems():Vector.<DialogItem> 
		{
			return _dialogItems;
		}
		
	}

}