package ten_seconds_to_live.com.five_ants.ten_secs 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.utils.Dictionary;
	
	import com.greensock.TweenMax;
	
	import ten_seconds_to_live.com.five_ants.ten_secs.events.InteractiveObjectEvent;
	import ten_seconds_to_live.com.five_ants.ten_secs.HUD.HUD;
	import ten_seconds_to_live.com.five_ants.ten_secs.HUD.HUDClock;
	import ten_seconds_to_live.com.five_ants.ten_secs.HUD.HUDInventory;
	import ten_seconds_to_live.com.five_ants.ten_secs.HUD.HUDItemPopUp;
	import ten_seconds_to_live.com.five_ants.ten_secs.HUD.HUDPauseMenu;
	import ten_seconds_to_live.com.five_ants.ten_secs.interfaces.IInitializable;
	import ten_seconds_to_live.com.five_ants.ten_secs.interfaces.IDisposable;
	import ten_seconds_to_live.com.five_ants.ten_secs.interfaces.IUpdateable;
	import ten_seconds_to_live.com.five_ants.ten_secs.realities.MainReality;
	
	import ten_seconds_to_live.com.five_ants.ten_secs.realities.AlternativeReality;
	
	/**
	 * ...
	 * @author Miguel Santirso
	 */
	public class GameplayState extends IGameState implements IDisposable, IUpdateable
	{
		public static const REALITY_MAIN:int = 0;
		
		private var _playerInput:IPlayerInput;
		
		private var _realities:Vector.<AlternativeReality> = new Vector.<AlternativeReality>();
		private var _currentReality:int = -1;
		
		protected var _hud:HUD;
		
		private var _paused:Boolean = false;
		
		// time
		private var _gameTime:GameTime;
		
		private var _interactiveObjects:Vector.<InteractiveObject> = new Vector.<InteractiveObject>();
		
		private var _realityLogic:RealityLogic;
		private var _wakingUp:Boolean = true;
		
		protected override function init():void 
		{
			// time
			_gameTime = new GameTime();
			_gameTime.addEventListener(GameTime.TIMEUP_EVENT, onTimeUp, false, 0, true);
			_gameTime.addEventListener(GameTime.SLOWMO_START_EVENT, onSlowmoStart, false, 0, true);
			_gameTime.addEventListener(GameTime.SLOWMO_END_EVENT, onSlowmoEnd, false, 0, true);
			
			_playerInput = new KeyboardInput();
			_playerInput.init(_stage);
			
			// Set up realities, push in order to vector
			var initialReality:AlternativeReality = new AlternativeReality(new MainReality());
			initialReality.playerWokeUp.addOnce(function ():void { _wakingUp = false; } );
			_realities.push(initialReality);
			
			for each (var reality:AlternativeReality in _realities)
				reality.init(this);
			
			changeToReality(REALITY_MAIN);
			
			_hud = new HUD();
			_hud.init();
			_hud.addEventListener(HUD.TOGGLE_PAUSE_EVENT, onPauseToggle, false, 0, true);
			_hud.addEventListener(HUD.TOGGLE_KNOWLEDGE_EVENT, onKnowledgeToggle, false, 0, true);
			_hud.addEventListener(HUD.KNOWLEDGE_OPENED_EVENT, onKnowledgeOpened, false, 0, true);
			_hud.addEventListener(HUD.KNOWLEDGE_CLOSED_EVENT, onKnowledgeClosed, false, 0, true);
			_hud.addEventListener(HUD.PAUSEMENU_OPENED_EVENT, onPauseMenuOpened, false, 0, true);
			_hud.addEventListener(HUD.PAUSEMENU_CLOSED_EVENT, onPauseMenuClosed, false, 0, true);
			//_hud.addEventListener(HUD.CREDITS_OPENED_EVENT, onCreditsOpened, false, 0, true);
			//_hud.addEventListener(HUD.CREDITS_CLOSED_EVENT, onCreditsClosed, false, 0, true);
			_hud.addEventListener(HUDPauseMenu.RESUME_REQUEST_EVENT, onHUDResume, false, 0, true);
			_hud.addEventListener(HUDPauseMenu.CREDITS_REQUEST_EVENT, onHUDCredits, false, 0, true);
			
			addChild(_hud);
			
			currentReality.collisions.removeCollisionBlock("door");
			
			Sounds.playSoundById(Sounds.GIRL_LAUGH_REVERB);
		}
		
		public override function update():void 
		{
			if (_paused)
				return;
			
			currentReality.update();
			
			/*if (!_wakingUp)
				_gameTime.update();*/
			
			_hud.time = _gameTime.seconds;
			
			// temp
			if(_playerInput.testPressed){
				//_hud.openItemPopUp("kitty");
			}
		}
		
		public override function dispose():void 
		{
			_playerInput.dispose();
			
			for each (var reality:AlternativeReality in _realities)
				reality.dispose();
				
			_hud.removeEventListener(HUD.TOGGLE_PAUSE_EVENT, onPauseToggle);
			_hud.removeEventListener(HUD.TOGGLE_KNOWLEDGE_EVENT, onKnowledgeToggle);
			_hud.removeEventListener(HUD.KNOWLEDGE_OPENED_EVENT, onKnowledgeOpened);
			_hud.removeEventListener(HUD.KNOWLEDGE_CLOSED_EVENT, onKnowledgeClosed);
			_hud.removeEventListener(HUD.PAUSEMENU_OPENED_EVENT, onPauseMenuOpened);
			_hud.removeEventListener(HUD.PAUSEMENU_CLOSED_EVENT, onPauseMenuClosed);
			//_hud.removeEventListener(HUD.CREDITS_OPENED_EVENT, onCreditsOpened);
			//_hud.removeEventListener(HUD.CREDITS_CLOSED_EVENT, onCreditsClosed);
			_hud.removeEventListener(HUDPauseMenu.RESUME_REQUEST_EVENT, onHUDResume);
			_hud.removeEventListener(HUDPauseMenu.CREDITS_REQUEST_EVENT, onHUDCredits);
			_hud.dispose();
			
			_gameTime.removeEventListener(GameTime.TIMEUP_EVENT, onTimeUp);
			_gameTime.removeEventListener(GameTime.SLOWMO_START_EVENT, onSlowmoStart);
			_gameTime.removeEventListener(GameTime.SLOWMO_END_EVENT, onSlowmoEnd);
		}
		
		public function changeToReality(reality:int):void
		{
			if (_currentReality >= 0)
			{
				removeChild(currentReality);
				//currentReality.dispose();
			}
			
			_currentReality = reality;
			
			//currentReality.init(this);
			addChild(currentReality);
		}
		
		public function get currentReality():AlternativeReality
		{
			return _realities[_currentReality];
		}
		
		public function get playerInput():IPlayerInput
		{
			return _playerInput;
		}
		public function get hud():HUD 
		{
			return _hud;
		}
		public function get gameTime():GameTime 
		{
			return _gameTime;
		}
		
		public function get paused():Boolean 
		{
			return _paused;
		}
		public function set paused(value:Boolean):void 
		{
			_paused = value;
		}
		
		protected function onTimeUp(e:Event):void 
		{
			// Game Over
			trace("time up");
			currentReality.player.playCinematic(Player.ANIM_DIE, true);
			
			TweenMax.delayedCall(3.3, onDeathComplete);
		}
		private function onDeathComplete():void
		{
			trace("death complete");
			TweenMax.to(this, 0.3, { "alpha": 0, onComplete: onFadeOutComplete } );
		}
		private function onFadeOutComplete():void
		{
			_main.changeState(new GameplayState());
		}
		
		public function onSlowmoStart(e:Event):void
		{
			_hud.slowmo = true;
		}
		
		public function onSlowmoEnd(e:Event):void
		{
			_hud.slowmo = false;
			
			_hud.closeKnowledgeList();
		}
		
		protected function onPauseToggle(event:Event):void
		{
			if (!_hud.pauseMenuOpened){
				_hud.closeKnowledgeList();
				_hud.closeCreditsPopUp();
				
				_hud.openPauseMenu();
			}else{
				_hud.closeCreditsPopUp();
				_hud.closePauseMenu();
			}
		}
		
		protected function onKnowledgeToggle(event:Event):void
		{
			if (!_hud.knowledgeListOpen){
				_hud.closePauseMenu();
				_hud.closeCreditsPopUp();
				
				_hud.openKnowledgeList(PlayerKnowledge.getEverythingThePlayerKnows());
			}else{
				_hud.closeKnowledgeList();
			}
		}
		
		protected function onKnowledgeOpened(event:Event):void
		{
			paused = true;
		}
		
		protected function onKnowledgeClosed(event:Event):void
		{
			paused = false;
		}
		
		protected function onPauseMenuOpened(event:Event):void
		{
			paused = true;
		}
		
		protected function onPauseMenuClosed(event:Event):void
		{
			paused = false;
		}
		
		// TODO remove
		protected function onHUDResume(event:Event):void
		{
			_hud.closePauseMenu();
		}
		
		protected function onHUDCredits(event:Event):void
		{
			_hud.openCreditsPopUp();
		}		
		
		// Temp
		protected function traceRoomElements(roomElements:Vector.<MovieClip>):void
		{
			for (var j:int = 0; j < roomElements.length; j++) {
				trace(roomElements[j].name);
			}
		}
	}

}