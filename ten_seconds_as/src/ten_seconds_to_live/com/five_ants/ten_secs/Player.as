package ten_seconds_to_live.com.five_ants.ten_secs 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import ten_seconds_to_live.com.five_ants.ten_secs.interfaces.ICameraTarget;
	
	/**
	 * ...
	 * @author Miguel Santirso
	 */
	public class Player extends Entity implements ICameraTarget
	{
		private static const SPEED_HORIZONTAL:Number = 16;
		private static const SPEED_VERTICAL:Number = 20;
		
		private static const ANIM_IDLE:int = 0;
		private static const ANIM_WALK_UP:int = 1;
		private static const ANIM_WALK_RIGHT:int = 2;
		private static const ANIM_WALK_DOWN:int = 3;
		private static const ANIM_WALK_LEFT:int = 4;
		private static const ANIM_JUMP_WINDOW:int = 5;
		private static const ANIM_DIE:int = 6;
		
		private var _movement:Point = new Point();
		
		private var _animations:Vector.<MovieClip> = new Vector.<MovieClip>();
		private var _currentAnimation:int = -1;
		
		private var _cinematicAnimations:Vector.<int> = new Vector.<int>();
		private var _offsetsAfterCinematics:Dictionary = new Dictionary();
		private var _inCinematic:Boolean;
		
		public function Player()
		{
			super();
			
			// Movement
			_animations[ANIM_IDLE] = new MainCharacterIdle();
			_animations[ANIM_WALK_UP] = new MainCharacterRunUp();
			_animations[ANIM_WALK_RIGHT] = new MainCharacterRunRight();
			_animations[ANIM_WALK_DOWN] = new MainCharacterRunDown();
			_animations[ANIM_WALK_LEFT] = new MainCharacterRunLeft();
			// Cinematic
			registerCinematic(ANIM_JUMP_WINDOW, new MainCharacterJumpWindow(), new Point(0, -35));
			registerCinematic(ANIM_DIE, new MainCharacterDies(), new Point(0, 0));
			
			setAnimation(ANIM_IDLE);
		}
		
		public override function update():void
		{
			if (_currentAnimation == ANIM_IDLE && _gameplay.playerInput.testPressed)
				playCinematic (ANIM_JUMP_WINDOW);
			
			if (_inCinematic)
				return;
			
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
			
			if (_movement.x == 0 && _movement.y == 0)
				setAnimation(ANIM_IDLE);
			else if (_movement.x != 0 && _movement.y == 0)
				setAnimation(_movement.x > 0 ? ANIM_WALK_RIGHT : ANIM_WALK_LEFT);
			else if (_movement.y != 0 && _movement.x == 0)
				setAnimation(_movement.y > 0 ? ANIM_WALK_DOWN : ANIM_WALK_UP);
			/*else // x and y != 0 
			{
				
			}*/
			
			/*_movement.x *= SPEED_HORIZONTAL;
			_movement.y *= SPEED_VERTICAL;*/
			
			var collisions:WallCollisions = _gameplay.currentReality.collisions;
			
			var tentativeMovement:int = _movement.x * SPEED_HORIZONTAL;
			while (tentativeMovement != 0 && !collisions.isPositionNavigable(x + tentativeMovement, y))
			{
				tentativeMovement /= 2;
			}
			x += tentativeMovement;
			
			tentativeMovement = _movement.y * SPEED_VERTICAL;
			while (tentativeMovement != 0 && !collisions.isPositionNavigable(x, y + tentativeMovement))
			{
				tentativeMovement /= 2;
			}
			y += tentativeMovement;
			
		}
		
		
		private function setAnimation(newAnimation:int):void
		{
  			if (newAnimation == _currentAnimation)
				return;
			
			if (_currentAnimation >= 0)
			{
				_animations[_currentAnimation].stop();
				removeChild(_animations[_currentAnimation]);
			}
			
			_currentAnimation = newAnimation;
			
			addChild(_animations[_currentAnimation]);
			_animations[_currentAnimation].gotoAndPlay(1);
		}
		
		private function playCinematic(id:int):void
		{
			setAnimation(id);
			_inCinematic = true;
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
			
			setAnimation(ANIM_IDLE);
		}
		
	}

}