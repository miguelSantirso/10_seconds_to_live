package ten_seconds_to_live
{
	import flash.display.Sprite;
	import flash.events.Event;
	import ten_seconds_to_live.com.five_ants.ten_secs.GameplayState;
	import ten_seconds_to_live.com.five_ants.ten_secs.TenSecsMain;
	
	/**
	 * ...
	 * @author Miguel Santirso
	 */
	public class Main extends Sprite 
	{
		private var game:TenSecsMain;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			// entry point
			game = new TenSecsMain(stage);
			game.changeState(new GameplayState());
			addChild(game);
		}
		
		
		private function onEnterFrame(e:Event):void
		{
			game.update();
		}
		
	}
	
}