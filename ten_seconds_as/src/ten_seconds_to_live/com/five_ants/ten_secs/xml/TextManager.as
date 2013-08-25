package ten_seconds_to_live.com.five_ants.ten_secs.xml 
{
	/**
	 * ...
	 * @author 10 2  Live Team
	 */
	public class TextManager 
	{
		[Embed("/xml_assets/knowledge.xml", mimeType="application/octet-stream")]
		private const XMLKnowledge:Class;
		
		[Embed("/xml_assets/dialogs.xml", mimeType="application/octet-stream")]
		private const XMLDialogs:Class;
		
		[Embed("/xml_assets/dialogs.xml", mimeType="application/octet-stream")]
		private const XMLDialogs:Class;
		
		private static var _instance:TextManager;
		
		public function TextManager() 
		{
			var knowledge:XML = XML(new XMLKnowledge());
			//setGroup(scenes.group);
			
			var dialogs:XML = XML(new XMLDialogs());
		}
		
		public static function get():TextManager
		{
			if (!_instance)
				_instance = new TextManager();
				
			return _instance;
		}
	}

}