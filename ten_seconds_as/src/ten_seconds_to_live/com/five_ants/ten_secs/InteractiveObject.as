package ten_seconds_to_live.com.five_ants.ten_secs 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;
	import ten_seconds_to_live.com.five_ants.ten_secs.events.InteractiveObjectEvent;
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
		
		private static const LABEL_FAR:String = "far";
		private static const LABEL_NEAR:String = "near";
		private static const LABEL_PRESSED:String = "pressed";
		
		public function InteractiveObject()
		{
			super();
			
			_visualObject = new Object1_interactive();
			_visualObject.stop();
			
			addChild(_visualObject);
			
			_visualRadius.graphics.beginFill(0xffff00, 0.2);
			_visualRadius.graphics.drawCircle(0, 0, INTERACTION_RADIUS);
			_visualRadius.graphics.endFill();
		}
		
		public override function update():void
		{
			//
		}
		
		public function checkPlayerCollision(player:Player, roomUtils:RoomUtils, playerInput:IPlayerInput):void
		{
			var interactionEvent:InteractiveObjectEvent;
			
			if (roomUtils.getRoomByPosition(player.x, player.y) == roomUtils.getRoomByPosition(x, y))
			{
				var p1:Point = new Point(player.x, player.y);
				var p2:Point = new Point(x, y);
				
				var distance:Number = Math.sqrt((p2.x - p1.x) * (p2.x - p1.x) + (p2.y - p1.y) * (p2.y - p1.y))
				
				if (distance <= INTERACTION_RADIUS)
				{
					if (playerInput.ePressed) 
					{
						_visualObject.gotoAndStop(LABEL_PRESSED);
						
						interactionEvent = new InteractiveObjectEvent(InteractiveObjectEvent.DO_ACTION);
						dispatchEvent(interactionEvent);
					}
					else if (_visualObject.currentLabel != LABEL_NEAR) _visualObject.gotoAndStop(LABEL_NEAR);
				}
				else if (_visualObject.currentLabel != LABEL_FAR) _visualObject.gotoAndStop(LABEL_FAR);
			}
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