package ten_seconds_to_live.com.five_ants.ten_secs 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import ten_seconds_to_live.com.five_ants.ten_secs.HUD.HUD;
	import ten_seconds_to_live.com.five_ants.ten_secs.events.InteractiveObjectEvent;
	import ten_seconds_to_live.com.five_ants.ten_secs.events.InventoryItemEvent;
	import ten_seconds_to_live.com.five_ants.ten_secs.interfaces.IInteractiveEntity;
	import ten_seconds_to_live.com.five_ants.ten_secs.object_actions.ObjectActionBase;
	import ten_seconds_to_live.com.five_ants.ten_secs.object_actions.ObjectActionTuple;
	import ten_seconds_to_live.com.five_ants.ten_secs.object_actions.RemoveInteractiveObject;
	import ten_seconds_to_live.com.five_ants.ten_secs.realities.AlternativeReality;
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
		
		protected var _itemDependency:int = -1;
		protected var _knowledgeDependency:String = null;
		
		protected var _actionsNoItemNoKnowledge:Vector.<ObjectActionTuple> = new Vector.<ObjectActionTuple>();
		protected var _actionsNoItem:Vector.<ObjectActionTuple> = new Vector.<ObjectActionTuple>();
		protected var _actionsSuccess:Vector.<ObjectActionTuple> = new Vector.<ObjectActionTuple>();
		
		protected var _visualInteractionPointer:MovieClip = new InteractionPointer();
		
		protected static const STD_INTERACTION_RADIUS:Number = 100;
		
		protected static const LABEL_FAR:String = "far";
		protected static const LABEL_NEAR:String = "near";
		protected static const LABEL_PRESSED:String = "pressed";
		
		protected static const LABEL_POINTER_BEGIN:String = "begin";
		protected static const LABEL_POINTER_END:String = "end";
		
		public function InteractiveObject(visualObject:MovieClip, roomUtils:RoomUtils, interactionRadius:Number = STD_INTERACTION_RADIUS)
		{
			super(visualObject);
			
			_name = visualObject.name;
			_interactionRadius = interactionRadius;
			_roomUtils = roomUtils;
			
			x = _visualObject.x;
			y = _visualObject.y;
			
			_visualObject.addChild(_visualInteractionPointer);
			
			_visualInteractionPointer.x = 0;
			_visualInteractionPointer.y = 0;
			
			_visualInteractionPointer.stop();
			_visualInteractionPointer.visible = false;
		}
		
		public override function update():void
		{
			super.update();
			
			_roomName = _roomUtils.getRoomByPosition(_visualObject.x, _visualObject.y);
			//enableInteractions = !_gameplay.hud.popupOpened;
		}
		
		public override function dispose():void
		{
			super.dispose();
			
			_roomUtils = null;
			_itemDependency = -1;
			_knowledgeDependency = null;
			
			for (var i:int = 0; i < _actionsNoItemNoKnowledge.length; i++) _actionsNoItemNoKnowledge.pop();
			_actionsNoItemNoKnowledge = null;
			
			for (i = 0; i < _actionsNoItem.length; i++) _actionsNoItem.pop();
			_actionsNoItem = null;
			
			for (i = 0; i < _actionsSuccess.length; i++) _actionsSuccess.pop();
			_actionsSuccess = null;
			 
			_visualInteractionPointer = null;
		}
		
		public function checkPlayerCollision(player:Player, playerInput:IPlayerInput):void
		{
			var interactionEvent:InteractiveObjectEvent;
			
			if (_interactionEnabled && 
				(_roomUtils.getRoomByPosition(player.x, player.y) == _roomUtils.getRoomByPosition(x, y)))
			{
				var p1:Point = new Point(player.x, player.y);
				var p2:Point = new Point(x, y);
				
				var distance:Number = Math.sqrt((p2.x - p1.x) * (p2.x - p1.x) + (p2.y - p1.y) * (p2.y - p1.y));
				
				if (distance <= _interactionRadius)
				{
					if (playerInput.actionPressed)
					{
						_visualObject.gotoAndStop(LABEL_PRESSED);
						
						player.stopFootstepsSound();

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
		
		public function addActionNoItemNoKnowledge(action:ObjectActionBase, repeteable:Boolean = false):void
		{
			var actionTuple:ObjectActionTuple = new ObjectActionTuple(action, repeteable);
			
			_actionsNoItemNoKnowledge.push(actionTuple);
		}
		
		public function addActionNoItem(action:ObjectActionBase, repeteable:Boolean = false):void
		{
			var actionTuple:ObjectActionTuple = new ObjectActionTuple(action, repeteable);
			
			_actionsNoItem.push(actionTuple);
		}
		
		public function addActionSuccess(action:ObjectActionBase, repeteable:Boolean = false):void
		{
			var actionTuple:ObjectActionTuple = new ObjectActionTuple(action, repeteable);
			
			_actionsSuccess.push(actionTuple);
		}
		
		public function executeAllActions():void
		{
			var action:ObjectActionTuple;
			
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
			
			if ((!itemVerified && !knowledgeVerified) || (!knowledgeVerified && itemVerified))
			{
				for each(action in _actionsNoItemNoKnowledge)
				{
					//if (action.repeteable || (!action.repeteable && !action.repeated))
					{ 
						action.action.execute();
						//action.repeated = true;
					}
				}
			}
			
			if (!itemVerified && knowledgeVerified)
			{
				for each(action in _actionsNoItem)
				{
					//if (action.repeteable || (!action.repeteable && !action.repeated))
					{
						action.action.execute();
						//action.repeated = true;
					}
				}
			}
			
			if (itemVerified && knowledgeVerified)
			{
				var repeatedActionCounter:int = 0;
				for each(action in _actionsSuccess)
				{
					if (action.repeteable || (!action.repeteable && !action.repeated))
					{
						action.action.execute();
						action.repeated = true;
						if (!action.repeteable)
						{
							unglowInteractionPointer();
							
							if (action.repeated) repeatedActionCounter++;
						}
					}
				}
				
				if (repeatedActionCounter == numActionsSuccess)
				{
					enableInteractions = false;
				}
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
			
			value ? glowInteractionPointer() : unglowInteractionPointer();
		}
		
		public function get numActionsNoItemNoKnowledge():int
		{
			return _actionsNoItemNoKnowledge.length;
		}
		
		public function get numActionsNoItem():int
		{
			return _actionsNoItem.length;
		}
		
		public function get numActionsSuccess():int
		{
			return _actionsSuccess.length;
		}
		
		public override function glowInteractionPointer():void
		{
			if (_interactionEnabled && !_visualInteractionPointer.visible)
			{
				_visualInteractionPointer.visible = true;
				_visualInteractionPointer.gotoAndPlay(LABEL_POINTER_BEGIN);
			}
		}
		
		public function unglowInteractionPointer():void
		{
			if (_visualInteractionPointer.visible)
			{
				_visualInteractionPointer.visible = false;
				_visualInteractionPointer.stop();
			}
		}
	}

}