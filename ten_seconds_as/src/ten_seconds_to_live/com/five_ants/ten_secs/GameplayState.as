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
			_realities.push(new AlternativeReality(new MainReality()));
			
			for each (var reality:AlternativeReality in _realities)
				reality.init(this);
			
			changeToReality(REALITY_MAIN);
			
			_hud = new HUD();
			_hud.init();
			addChild(_hud);
		}
		
		public override function update():void 
		{
			if (_paused)
				return;
			
			currentReality.update();
			
			_gameTime.update();
			
			_hud.time = _gameTime.seconds;
			
			if(_playerInput.testPressed){
				var testKnowledge:Vector.<String> = new Vector.<String>();
				testKnowledge.push("kung fu.");
				testKnowledge.push("Ubuntu.");
				testKnowledge.push("I just had sex.");
				_hud.openKnowledgeList(testKnowledge);
				//_hud.openKnowledgeList(PlayerKnowledge.getEverythingThePlayerKnows());
			}
		}
		
		public override function dispose():void 
		{
			_playerInput.dispose();
			
			for each (var reality:AlternativeReality in _realities)
				reality.dispose();
				
			// hud
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
		
		// Temp
		protected function traceRoomElements(roomElements:Vector.<MovieClip>):void
		{
			for (var j:int = 0; j < roomElements.length; j++) {
				trace(roomElements[j].name);
			}
		}
	}

}