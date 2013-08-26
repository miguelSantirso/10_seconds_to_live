package ten_seconds_to_live.com.five_ants.ten_secs 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.media.ID3Info;
	import flash.utils.Dictionary;
	import org.osflash.signals.Signal;
	import ten_seconds_to_live.com.five_ants.ten_secs.interfaces.ICameraTarget;
	import ten_seconds_to_live.com.five_ants.ten_secs.interfaces.IDisposable;
	import ten_seconds_to_live.com.five_ants.ten_secs.object_actions.PlaySound;
	import ten_seconds_to_live.com.five_ants.ten_secs.object_actions.StopSound;
	import ten_seconds_to_live.com.five_ants.ten_secs.realities.AlternativeReality;
	import ten_seconds_to_live.com.five_ants.ten_secs.events.PlayerEvent;
	
		import com.greensock.TweenMax;
		
	/**
	 * ...
	 * @author Miguel Santirso
	 */
	public class Player extends Entity implements ICameraTarget
	{
		private static const SPEED_HORIZONTAL:Number = 16;
		private static const SPEED_VERTICAL:Number = 20;
		
		public static const ANIM_IDLE_DOWN:int = 0;
		public static const ANIM_WALK_UP:int = 1;
		public static const ANIM_WALK_RIGHT:int = 2;
		public static const ANIM_WALK_DOWN:int = 3;
		public static const ANIM_WALK_LEFT:int = 4;
		public static const ANIM_JUMP_WINDOW:int = 5;
		public static const ANIM_DIE:int = 6;
		public static const ANIM_WAKE_UP:int = 7;
		public static const ANIM_IDLE_UP:int = 8;
		public static const ANIM_IDLE_RIGHT:int = 9;
		public static const ANIM_IDLE_LEFT:int = 10;
		public static const ANIM_SHOOTING:int = 11;
		
		private var _movement:Point = new Point();
		private var _prevMovement:Point = new Point();
		
		private var _animations:Vector.<MovieClip> = new Vector.<MovieClip>(30);
		private var _currentAnimation:int = -1;
		
		private var _cinematicAnimations:Vector.<int> = new Vector.<int>();
		private var _offsetsAfterCinematics:Dictionary = new Dictionary();
		private var _inCinematic:Boolean;
		
		private var _animationComplete:Signal = new Signal(int);
		private var _loopCinematic:Boolean;
		private var _animationBeforeCinematic:int;
		
		private var _currentRoom:String = "room";
		
		public function Player()
		{
			super();
			
			// Movement
			_animations[ANIM_IDLE_UP] = new MainCharacterIdleUp();
			_animations[ANIM_IDLE_RIGHT] = new MainCharacterIdleRight;
			_animations[ANIM_IDLE_DOWN] = new MainCharacterIdleDown();
			_animations[ANIM_IDLE_LEFT] = new MainCharacterIdleLeft();
			_animations[ANIM_WALK_UP] = new MainCharacterRunUp();
			_animations[ANIM_WALK_RIGHT] = new MainCharacterRunRight();
			_animations[ANIM_WALK_DOWN] = new MainCharacterRunDown();
			_animations[ANIM_WALK_LEFT] = new MainCharacterRunLeft();
			// Cinematic
			registerCinematic(ANIM_JUMP_WINDOW, new MainCharacterJumpWindow(), new Point(0, -45));
			registerCinematic(ANIM_DIE, new MainCharacterDies(), new Point(0, 0));
			registerCinematic(ANIM_WAKE_UP, new MainCharacterWakesUp(), new Point(0, 0));
			registerCinematic(ANIM_SHOOTING, new MainCharacterShooting(), new Point( -20, 0));
			
			
			setAnimation(ANIM_IDLE_DOWN);
		}
		
		public override function dispose():void
		{
			super.dispose();
			
			_animationComplete.removeAll();
		}
		
		public override function update():void
		{
			if (_inCinematic)
				return;
			
			_prevMovement.x = _movement.x;
			_prevMovement.y = _movement.y;
			_movement.x = 0;
			_movement.y = 0;
			
			if (_gameplay.playerInput.leftPressed)
				_movement.x -= 1;
			if (_gameplay.playerInput.rightPressed)
				_movement.x += 1;
			if (_gameplay.playerInput.upPressed)
				_movement.y -= 1;
			if (_gameplay.playerInput.downPressed)
				_movement.y += 1;
			
			
			var collisions:WallCollisions = _gameplay.currentReality.collisions;
			
			var tentativeMovement:int = _movement.x * SPEED_HORIZONTAL;
			while (tentativeMovement != 0 && !collisions.isPositionNavigable(x + tentativeMovement, y))
			{
				tentativeMovement /= 2;
			}
			_movement.x = tentativeMovement;
			x += tentativeMovement;
			
			tentativeMovement = _movement.y * SPEED_VERTICAL;
			while (tentativeMovement != 0 && !collisions.isPositionNavigable(x, y + tentativeMovement))
			{
				tentativeMovement /= 2;
			}
			_movement.y = tentativeMovement;
			y += tentativeMovement;
			
			
			if (_movement.x == 0 && _movement.y == 0)
			{
				if (_prevMovement.y > 0)
					setAnimation(ANIM_IDLE_DOWN);
				else if (_prevMovement.y < 0)
					setAnimation(ANIM_IDLE_UP)
				else if (_prevMovement.x > 0)
					setAnimation(ANIM_IDLE_RIGHT);
				else if (_prevMovement.x < 0)
					setAnimation(ANIM_IDLE_LEFT);
			}
			else if (_movement.x != 0 && _movement.y == 0)
				setAnimation(_movement.x > 0 ? ANIM_WALK_RIGHT : ANIM_WALK_LEFT);
			else if (_movement.y != 0/* && _movement.x == 0*/)
				setAnimation(_movement.y > 0 ? ANIM_WALK_DOWN : ANIM_WALK_UP);
			/*else // x and y != 0 
			{
				
			}*/
			
			var _newRoom:String = AlternativeReality._roomUtils.getRoomByPosition(x, y);
			if (_newRoom != _currentRoom)
			{
				dispatchEvent(new PlayerEvent(PlayerEvent.CHANGED_ROOM, true));
				_currentRoom = _newRoom;
				
				playFootstepsSound(_currentAnimation);
			}
		}
		
		
		private function setAnimation(newAnimation:int):void
		{
			if (newAnimation == _currentAnimation)
				return;
				
				playFootstepsSound(newAnimation);
			
			if (_currentAnimation >= 0)
			{
				_animations[_currentAnimation].stop();
				removeChild(_animations[_currentAnimation]);
			}
			
			_currentAnimation = newAnimation;
			
			addChild(_animations[_currentAnimation]);
			_animations[_currentAnimation].gotoAndPlay(1);
		}
		
		private function playFootstepsSound(animation:int):void
		{
			(_currentRoom == "garden")
					? (new StopSound(Sounds.FOOTSTEPS_GARDEN)).execute()
					: (new StopSound(Sounds.FOOTSTEPS_INHOUSE)).execute();
				
			if (animation == ANIM_WALK_DOWN || animation == ANIM_WALK_UP ||
				animation == ANIM_WALK_LEFT || animation == ANIM_WALK_RIGHT)
			{
				(_currentRoom == "garden")
					? (new PlaySound(Sounds.FOOTSTEPS_GARDEN, 0)).execute()
					: (new PlaySound(Sounds.FOOTSTEPS_INHOUSE, 0)).execute();
			}
		}
		
		public function playCinematic(id:int, loop:Boolean = false):void
		{
			if (_inCinematic)
				return;
			
			if (id == ANIM_JUMP_WINDOW)
			{
				_gameplay.currentReality.setUpRoom("garden");
			}
			//	TweenMax.to(this, 1, { y: y - 45 } );
			
			_animationBeforeCinematic = _currentAnimation;
			setAnimation(id);
			_inCinematic = true;
			_loopCinematic = loop;
		}
		
		private function registerCinematic(id:int, mc:MovieClip, offset:Point):void
		{
			mc.stop();
			
			_animations[id] = mc;
			FrameScriptInjector.injectStopAtEnd(mc);
			FrameScriptInjector.injectFunction(mc, mc.totalFrames, onCinematicComplete);
			_offsetsAfterCinematics[id] = offset;
		}
		
		private function onCinematicComplete():void
		{
			_inCinematic = false;
			
			var offset:Point = _offsetsAfterCinematics[_currentAnimation];
			x += offset.x;
			y += offset.y;
			
			_animationComplete.dispatch(_currentAnimation);
			
			if (!_loopCinematic)
				setAnimation(_animationBeforeCinematic);
			else
				_animations[_currentAnimation].stop();
		}
		
		public function get animationComplete():Signal
		{
			return _animationComplete;
		}
		
	}

}