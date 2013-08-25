package ten_seconds_to_live.com.five_ants.ten_secs 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import ten_seconds_to_live.com.five_ants.ten_secs.HUD.HUD;
	import ten_seconds_to_live.com.five_ants.ten_secs.events.InteractiveObjectEvent;
	import ten_seconds_to_live.com.five_ants.ten_secs.events.InventoryItemEvent;
	import ten_seconds_to_live.com.five_ants.ten_secs.interfaces.IInteractiveEntity;
	import ten_seconds_to_live.com.five_ants.ten_secs.object_actions.ObjectActionBase;
	/**
	 * ...
	 * @author ...
	 */
	public class InteractiveObject extends Entity implements IInteractiveEntity
	{
		protected var _name:String;
		protected var _roomName:String;
		protected var _roomUtils:RoomUtils;
		protected var _interactionRadius:Number;
		
		protected var _interactionEnabled:Boolean = true;
		
		protected var _visualObject:MovieClip = new MovieClip();
		
		protected var _itemDependency:int = -1;
		protected var _knowledgeDependency:String = null;
		
		protected var _actionsNoItemNoKnowledge:Vector.<ObjectActionBase> = new Vector.<ObjectActionBase>();
		protected var _actionsNoItem:Vector.<ObjectActionBase> = new Vector.<ObjectActionBase>();
		protected var _actionsSuccess:Vector.<ObjectActionBase> = new Vector.<ObjectActionBase>();
		
		protected static const STD_INTERACTION_RADIUS:Number = 100;
		
		protected static const LABEL_FAR:String = "far";
		protected static const LABEL_NEAR:String = "near";
		protected static const LABEL_PRESSED:String = "pressed";
		
		public function InteractiveObject(visualObject:MovieClip, roomUtils:RoomUtils, interactionRadius:Number = STD_INTERACTION_RADIUS)
		{
			super();
			
			_visualObject = visualObject;
			_name = visualObject.name;
			_interactionRadius = interactionRadius;
			_roomUtils = roomUtils;
		}
		
		public override function update():void
		{
			_roomName = _roomUtils.getRoomByPosition(_visualObject.x, _visualObject.y);
			enableInteractions = _interactionEnabled && !_gameplay.hud.popupOpened;
		}
		
		public function checkPlayerCollision(player:Player, playerInput:IPlayerInput):void
		{
			var interactionEvent:InteractiveObjectEvent;
			
			_interactionEnabled = true;
			
			if (_interactionEnabled && 
				(_roomUtils.getRoomByPosition(player.x, player.y) == _roomUtils.getRoomByPosition(x, y)))
			{
				var p1:Point = new Point(player.x, player.y);
				var p2:Point = new Point(x, y);
				
				var distance:Number = Math.sqrt((p2.x - p1.x) * (p2.x - p1.x) + (p2.y - p1.y) * (p2.y - p1.y));
				
				if (distance <= _interactionRadius)
				{	
					if (playerInput.ePressed)
					{
						_visualObject.gotoAndStop(LABEL_PRESSED);
						
						executeAllActions();
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
		
		public function setKnowledgeDependency(knowledge:String):void
		{
			_knowledgeDependency = knowledge;
		}
		
		public function setItemDependency(item:int):void
		{
			_itemDependency = item;
		}
		
		public function addActionNoItemNoKnowledge(action:ObjectActionBase):void
		{
			_actionsNoItemNoKnowledge.push(action);
		}
		
		public function addActionNoItem(action:ObjectActionBase):void
		{
			_actionsNoItem.push(action);
		}
		
		public function addActionSuccess(action:ObjectActionBase):void
		{
			_actionsSuccess.push(action);
		}
		
		public function executeAllActions():void
		{
			var action:ObjectActionBase;
			
			var itemVerified:Boolean = true;
			var knowledgeVerified:Boolean = true;
			
			if (_itemDependency > -1)
			{
				itemVerified = _gameplay.hud.inventory.checkItemByID(_itemDependency);
			}
			
			if (_knowledgeDependency)
			{
				knowledgeVerified = PlayerKnowledge.getKnowledge(_knowledgeDependency);
			}
			
			if (!itemVerified && !knowledgeVerified)
			{
				for each(action in _actionsNoItemNoKnowledge)
				{
					action.execute();
				}
			}
			
			if (!itemVerified)
			{
				for each(action in _actionsNoItem)
				{
					action.execute();
				}
			}
			
			if (itemVerified && knowledgeVerified)
			{
				for each(action in _actionsSuccess)
				{
					action.execute();
				}
				
				//enableInteractions = false;
			}
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