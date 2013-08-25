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
		private var _name:String;
		private var _interactionRadius:Number;
		
		private var _interactionEnabled:Boolean = true;
		
		private var _visualObject:MovieClip = new MovieClip();
		
		private static const STD_INTERACTION_RADIUS:Number = 100;
		
		private static const LABEL_FAR:String = "far";
		private static const LABEL_NEAR:String = "near";
		private static const LABEL_PRESSED:String = "pressed";
		
		public function InteractiveObject(visualObject:MovieClip, interactionRadius:Number = STD_INTERACTION_RADIUS)
		{
			super();
			
			_visualObject = visualObject;
			_name = visualObject.name;
			_interactionRadius = interactionRadius;
		}
		
		public override function update():void
		{
			enableInteractions = !_gameplay.hud.popupOpened;
		}
		
		public function checkPlayerCollision(player:Player, roomUtils:RoomUtils, playerInput:IPlayerInput):void
		{
			var interactionEvent:InteractiveObjectEvent;
			
			if (_interactionEnabled && 
				(roomUtils.getRoomByPosition(player.x, player.y) == roomUtils.getRoomByPosition(x, y)))
			{
				var p1:Point = new Point(player.x, player.y);
				var p2:Point = new Point(x, y);
				
				var distance:Number = Math.sqrt((p2.x - p1.x) * (p2.x - p1.x) + (p2.y - p1.y) * (p2.y - p1.y));
				
				if (distance <= _interactionRadius)
				{	
					if (_interactionEnabled && playerInput.ePressed)
					{
						_visualObject.gotoAndStop(LABEL_PRESSED);
						
						interactionEvent = new InteractiveObjectEvent(InteractiveObjectEvent.DO_ACTION, true);
						interactionEvent.actionType = "gatico"; // poner el tipo correcto
						
						dispatchEvent(interactionEvent);
						
						_gameplay.hud.openItemPopUp(interactionEvent.actionType);
					}
					else if (_visualObject.currentLabel != LABEL_NEAR) _visualObject.gotoAndStop(LABEL_NEAR);
				}
				else if (_visualObject.currentLabel != LABEL_FAR) _visualObject.gotoAndStop(LABEL_FAR);
			}
		}
		
		public function getName():String
		{
			return _name;
		}
		
		public override function get x():Number
		{
			return _visualObject.x;
		}
		
		public override function get y():Number
		{
			return _visualObject.y;
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
				_visualObject.graphics.beginFill(0xffff00, 0.2);
				_visualObject.graphics.drawCircle(0, 0, _interactionRadius);
				_visualObject.graphics.endFill();
			}
			else
			{
				_visualObject.graphics.clear();
			}
		}
		
		public function set enableInteractions(value:Boolean):void
		{
			_interactionEnabled = value;
		}
	}

}