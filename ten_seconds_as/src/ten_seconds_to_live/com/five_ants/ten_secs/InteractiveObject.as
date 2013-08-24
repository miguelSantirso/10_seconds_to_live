package ten_seconds_to_live.com.five_ants.ten_secs 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;
	import ten_seconds_to_live.com.five_ants.ten_secs.interfaces.IInteractiveEntity;
	import ten_seconds_to_live.com.five_ants.ten_secs.object_actions.ObjectActionBase;
	/**
	 * ...
	 * @author ...
	 */
	public class InteractiveObject extends Entity implements IInteractiveEntity
	{
		private var _visualObject:MovieClip = new MovieClip();
		private var _visualRadius:Sprite = new Sprite();
		
		private static const INTERACTION_RADIUS:Number = 100;
		
		public function InteractiveObject()
		{
			super();
			
			_visualObject = new Object1_interactive();
			
			addChild(_visualObject);
			
			_visualRadius.graphics.beginFill(0xffff00);
			_visualRadius.graphics.drawCircle(0, 0, INTERACTION_RADIUS);
			_visualRadius.graphics.endFill();
		}
		
		public override function update():void
		{
			
		}
		
		public function checkPlayerCollision(player:Player, roomUtils:RoomUtils):void
		{
			// hacer lo de las rooms cuando el mapeado esté bien!
			var playerPosV:Point = new Point(player.x, player.y);
			var objectPosV:Point = new Point(x, y);
			
			var distance:Number = Point.distance(playerPosV, objectPosV);
			
			trace("DIST: " + distance);
		}
		
		public override function get name():String
		{
			return "nothing";
		}
		
		public function addAction(action:ObjectActionBase):void
		{
			
		}
		
		public function executeAllActions():void
		{
			
		}
		
		public function set showRadius(value:Boolean):void
		{
			if (value)
			{
				addChildAt(_visualRadius, 0);
			}
			else if(contains(_visualRadius))
			{
				removeChild(_visualRadius);
			}
		}
	}

}