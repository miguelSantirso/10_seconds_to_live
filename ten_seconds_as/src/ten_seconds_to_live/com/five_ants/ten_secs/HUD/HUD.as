package ten_seconds_to_live.com.five_ants.ten_secs.HUD 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import ten_seconds_to_live.com.five_ants.ten_secs.Dialog;
	import ten_seconds_to_live.com.five_ants.ten_secs.events.CinematicEvent;
	import ten_seconds_to_live.com.five_ants.ten_secs.events.InventoryItemEvent;
	import ten_seconds_to_live.com.five_ants.ten_secs.interfaces.IInitializable;
	import ten_seconds_to_live.com.five_ants.ten_secs.interfaces.IDisposable;
	import ten_seconds_to_live.com.five_ants.ten_secs.interfaces.IUpdateable;
	import com.greensock.TweenLite;
	import ten_seconds_to_live.com.five_ants.ten_secs.FrameScriptInjector;
	
	/**
	 * ...
	 * @author 10 2  Live Team
	 */
	public class HUD extends Sprite implements IInitializable, IDisposable, IUpdateable
	{
		public static const TOGGLE_PAUSE_EVENT:String = "togglePauseEvent";
		public static const TOGGLE_KNOWLEDGE_EVENT:String = "toggleKnowledgeEvent";
		
		public static const POPUP_OPENED_EVENT:String = "popupOpenedEvent";
		public static const POPUP_CLOSED_EVENT:String = "popupClosedEvent";
		
		public static const KNOWLEDGE_OPENED_EVENT:String = "knowledgeOpenedEvent";
		public static const KNOWLEDGE_CLOSED_EVENT:String = "knowledgeClosedEvent";

		public static const DIALOG_OPENED_EVENT:String = "dialogOpenedEvent";
		public static const DIALOG_CLOSED_EVENT:String = "dialogClosedEvent";

		public static const PAUSEMENU_OPENED_EVENT:String = "pauseMenuOpenedEvent";
		public static const PAUSEMENU_CLOSED_EVENT:String = "pauseMenuClosedEvent";
		
		public static const CREDITS_OPENED_EVENT:String = "creditsOpenedEvent";
		public static const CREDITS_CLOSED_EVENT:String = "creditsClosedEvent";
		
		public static const WELCOME_OPENED_EVENT:String = "welcomeOpenedEvent";
		public static const WELCOME_CLOSED_EVENT:String = "welcomeClosedEvent";
		
		public static const CINEMATIC_OPENED_EVENT:String = "cinematicOpenedEvent";
		public static const CINEMATIC_CLOSED_EVENT:String = "cinematicClosedEvent";
		
		protected var _hudClock:HUDClock;
		protected var _hudButtonPanel:HUDButtonPanel;
		protected var _hudInventory:HUDInventory;
		protected var _hudItemPopUp:HUDItemPopUp;
		protected var _hudKnowledgeList:HUDKnowledgeList;
		protected var _hudPauseMenu:HUDPauseMenu;
		protected var _hudCreditsPopUp:HUDCreditsPopUp;
		protected var _hudWelcomePopUp:HUDWelcomePopUp;
		protected var _hudDialog:HUDDialog;
		protected var _slowmoOverlay:SlowmoOverlay;
		
		protected var _enabled:Boolean;
		protected var _popupOpened:Boolean = false;
		protected var _knowledgeListOpened:Boolean = false;
		protected var _pauseMenuOpened:Boolean = false;
		protected var _creditsPopUpOpened:Boolean = false;
		protected var _welcomePopUpOpened:Boolean = false;
		protected var _dialogOpened:Boolean = false;
		protected var _cinematicOpened:Boolean = false;
		
		// cinematics
		protected var _currentCinematicType:String;
		protected var _currentCinematicFunction:Function;
		
		protected var _cinematicsDictionary:Dictionary;
		
		public static const CINEMATIC_CAMERA_RECORDINGS:String = "camera_recordings";
		public static const CINEMATIC_PREV_SHOOTING:String = "prev_shooting";
		public static const CINEMATIC_SHOOTING:String = "shooting";
		public static const CINEMATIC_POST_SHOOTING:String = "post_shooting";
		
		public function HUD() 
		{
			_hudClock = new HUDClock();
			_hudButtonPanel = new HUDButtonPanel();
			_hudInventory = new HUDInventory();
			_hudItemPopUp = new HUDItemPopUp();
			_hudKnowledgeList = new HUDKnowledgeList();
			_hudPauseMenu = new HUDPauseMenu();
			_hudCreditsPopUp = new HUDCreditsPopUp();
			_hudWelcomePopUp = new HUDWelcomePopUp();
			_hudDialog = new HUDDialog();
			_slowmoOverlay = new SlowmoOverlay();
			
			_cinematicsDictionary = new Dictionary();
			_cinematicsDictionary[CINEMATIC_CAMERA_RECORDINGS] = new CinematicRecording();
			_cinematicsDictionary[CINEMATIC_SHOOTING] = new CinematicShooting();
			
			_enabled = true;
		}
		
		public function init():void
		{
			_hudClock.x = _hudClock.y = 6;
			
			_hudButtonPanel.x = 170;
			_hudButtonPanel.y = 6;
			_hudButtonPanel.addEventListener(HUDButtonPanel.PAUSE_REQUEST_EVENT, onPauseRequest, false, 0, true);
			_hudButtonPanel.addEventListener(HUDButtonPanel.KNOWLEDGE_REQUEST_EVENT, onKnowledgeRequest, false, 0, true);
			
			_hudInventory.x = 6;
			_hudInventory.y = 494;
			
			_hudItemPopUp.x = (800 - _hudItemPopUp.width) * 0.5;
			_hudItemPopUp.y = (600 - _hudItemPopUp.height) * 0.5;
			_hudItemPopUp.addEventListener(HUDItemPopUp.CLOSE_REQUEST_EVENT, closeItemPopUp, false, 0, true);
			
			_hudKnowledgeList.x = (800 - _hudKnowledgeList.width) * 0.5;
			_hudKnowledgeList.y = 600 - _hudKnowledgeList.height;
			_hudKnowledgeList.addEventListener(HUDKnowledgeList.CLOSE_REQUEST_EVENT, closeKnowledgeList, false, 0, true);
			
			_hudPauseMenu.x = (800 - _hudPauseMenu.width) * 0.5;
			_hudPauseMenu.y = (600 - _hudPauseMenu.height) * 0.5;
			_hudPauseMenu.addEventListener(HUDPauseMenu.RESUME_REQUEST_EVENT, onResumeRequest, false, 0, true);
			_hudPauseMenu.addEventListener(HUDPauseMenu.CREDITS_REQUEST_EVENT, oCreditsRequest, false, 0, true);
			
			_hudCreditsPopUp.x = (800 - _hudCreditsPopUp.width) * 0.5;
			_hudCreditsPopUp.y = (600 - _hudCreditsPopUp.height) * 0.5;
			_hudCreditsPopUp.addEventListener(HUDCreditsPopUp.CLOSE_REQUEST_EVENT, closeCreditsPopUp, false, 0, true);
			
			_hudWelcomePopUp.x = (800 - _hudWelcomePopUp.width) * 0.5;
			_hudWelcomePopUp.y = (600 - _hudWelcomePopUp.height) * 0.5;
			_hudWelcomePopUp.addEventListener(HUDWelcomePopUp.CLOSE_REQUEST_EVENT, closeWelcomePopUp, false, 0, true);
			
			_hudDialog.x = (800 - _hudDialog.width) * 0.5;
			_hudDialog.y = 456;
			_hudDialog.addEventListener(HUDDialog.DIALOG_COMPLETE_EVENT, closeDialog, false, 0, true);
			
			addChild(_hudClock);
			addChild(_hudButtonPanel);
			addChild(_hudInventory);
		}
		
		public function dispose():void
		{
			
			if(contains(_hudClock))
				removeChild(_hudClock);
				
			if(contains(_hudButtonPanel))
				removeChild(_hudButtonPanel);
			
			if(contains(_hudInventory))
				removeChild(_hudInventory);
			
			if(contains(_hudItemPopUp))
				removeChild(_hudItemPopUp);
			
			if(contains(_hudKnowledgeList))
				removeChild(_hudKnowledgeList);
			
			if(contains(_hudPauseMenu))
				removeChild(_hudPauseMenu);
			
			if(contains(_hudCreditsPopUp))
				removeChild(_hudCreditsPopUp);
			
			if(contains(_hudDialog))
				removeChild(_hudDialog);
			
			if(contains(_slowmoOverlay))
				removeChild(_slowmoOverlay);
				
			_hudClock.dispose();
			_hudClock = null;

			_hudButtonPanel.dispose();
			_hudButtonPanel.removeEventListener(HUDButtonPanel.PAUSE_REQUEST_EVENT, onPauseRequest);
			_hudButtonPanel.removeEventListener(HUDButtonPanel.KNOWLEDGE_REQUEST_EVENT, onKnowledgeRequest);
			_hudButtonPanel = null;
			
			_hudInventory.dispose();
			_hudInventory = null;
			
			_hudItemPopUp.removeEventListener(HUDItemPopUp.CLOSE_REQUEST_EVENT, closeItemPopUp);
			_hudItemPopUp.dispose();
			_hudItemPopUp = null;
			
			_hudKnowledgeList.removeEventListener(HUDKnowledgeList.CLOSE_REQUEST_EVENT, closeKnowledgeList);
			_hudKnowledgeList.dispose();
			_hudKnowledgeList = null;
			
			_hudPauseMenu.removeEventListener(HUDPauseMenu.RESUME_REQUEST_EVENT, onResumeRequest);
			_hudPauseMenu.removeEventListener(HUDPauseMenu.CREDITS_REQUEST_EVENT, oCreditsRequest);
			_hudPauseMenu.dispose();
			_hudPauseMenu = null;
			
			_hudCreditsPopUp.removeEventListener(HUDCreditsPopUp.CLOSE_REQUEST_EVENT, closeCreditsPopUp);
			_hudCreditsPopUp.dispose();
			_hudCreditsPopUp = null;
			
			_hudDialog.removeEventListener(HUDDialog.DIALOG_COMPLETE_EVENT, closeDialog);
			_hudDialog.dispose();
			_hudDialog = null;
		}

		public function update():void
		{
			if(_dialogOpened)
				_hudDialog.update();
			
			if (_cinematicOpened)
				return;
				
			_hudButtonPanel.update();
			
			if(_popupOpened)
				_hudItemPopUp.update();
			if(_knowledgeListOpened)
				_hudKnowledgeList.update();
			if(_pauseMenuOpened)
				_hudPauseMenu.update();
			if(_creditsPopUpOpened)
				_hudCreditsPopUp.update();
			if(_welcomePopUpOpened)
				_hudWelcomePopUp.update();
		}
		
		public function set slowmo(isActive:Boolean):void
		{
			_hudClock.slowmo = isActive;
			
			if (isActive)
				addChildAt(_slowmoOverlay, 0);
			else
				if(contains(_slowmoOverlay))
					removeChild(_slowmoOverlay);
		}
		
		public function set time(seconds:String):void
		{
			_hudClock.time = seconds;
		}
		
		public function get inventory():HUDInventory
		{
			return _hudInventory;
		}
		
		public function get enabled():Boolean 
		{
			return _enabled;
		}
		
		public function get popupOpened():Boolean
		{
			return _popupOpened;
		}
		
		public function set enabled(value:Boolean):void 
		{
			if (value && !_enabled) {
				// enable
				_hudClock.visible = true;
				_hudInventory.visible = true;
				_hudItemPopUp.visible = true;
				_hudKnowledgeList.visible = true;
				
				_hudButtonPanel.visible = true;
				_hudCreditsPopUp.visible = true;
				_hudWelcomePopUp.visible = true;
				
			}else if (!value && _enabled) {
				// disable
				_hudClock.visible = false;
				_hudInventory.visible = false;
				_hudItemPopUp.visible = false;
				_hudKnowledgeList.visible = false;
				
				_hudButtonPanel.visible = false;
				_hudCreditsPopUp.visible = false;
				_hudWelcomePopUp.visible = false;
			}
			
			_enabled = value;
		}
		
		public function get knowledgeListOpen():Boolean
		{
			return _knowledgeListOpened;
		}
		
		public function get pauseMenuOpened():Boolean 
		{
			return _pauseMenuOpened;
		}
		
		public function get dialogOpened():Boolean 
		{
			return _dialogOpened;
		}
		
		public function openItemPopUp(itemId:int, title:String, description:String):void
		{
			_hudItemPopUp.item = itemId;
			_hudItemPopUp.title = title;
			_hudItemPopUp.description = description;
			
			_popupOpened = true;
			
			addChild(_hudItemPopUp);
			
			dispatchEvent(new Event(POPUP_OPENED_EVENT));
		}
		
		public function closeItemPopUp(event:InventoryItemEvent):void
		{
			_popupOpened = false;
			
			removeChild(_hudItemPopUp);
			
			dispatchEvent(new InventoryItemEvent(event.type, POPUP_CLOSED_EVENT));
		}
		
		public function openKnowledgeList(knowledgeVector:Vector.<String>):void
		{
			_hudKnowledgeList.open(knowledgeVector);
			
			_knowledgeListOpened = true;
			
			addChild(_hudKnowledgeList);
			
			dispatchEvent(new Event(KNOWLEDGE_OPENED_EVENT));
		}
		
		public function closeKnowledgeList(event:Event = null):void
		{
			if (!_knowledgeListOpened)
				return;
				
			_hudKnowledgeList.close();
			
			_knowledgeListOpened = false;
			
			removeChild(_hudKnowledgeList);
			
			dispatchEvent(new Event(KNOWLEDGE_CLOSED_EVENT));
		}
		
		public function openDialog(dialog:Dialog):void
		{
			if(dialog){
				_hudDialog.dialog = dialog;	
				
				_dialogOpened = true;
			
				addChild(_hudDialog);
				
				dispatchEvent(new Event(DIALOG_OPENED_EVENT));
			}
		}
		
		public function closeDialog(event:Event = null):void
		{	
			_dialogOpened = false;
			
			removeChild(_hudDialog);
			
			dispatchEvent(new Event(DIALOG_CLOSED_EVENT));
		}
		
		public function openPauseMenu():void
		{
			_pauseMenuOpened = true;
			
			addChild(_hudPauseMenu);
			
			dispatchEvent(new Event(PAUSEMENU_OPENED_EVENT));
		}
		
		public function closePauseMenu():void
		{
			if (!_pauseMenuOpened)
				return;
				
			_pauseMenuOpened = false;
			
			removeChild(_hudPauseMenu);
			
			dispatchEvent(new Event(PAUSEMENU_CLOSED_EVENT));
		}
		
		public function openCreditsPopUp():void
		{
			_creditsPopUpOpened = true;
			
			addChild(_hudCreditsPopUp);
			
			dispatchEvent(new Event(CREDITS_OPENED_EVENT));
		}
		
		public function closeCreditsPopUp(e:Event = null):void
		{
			if (!_creditsPopUpOpened)
				return;
			
			_creditsPopUpOpened = false;
			
			removeChild(_hudCreditsPopUp);
			
			dispatchEvent(new Event(CREDITS_CLOSED_EVENT));
		}
		
		public function openWelcomePopUp():void
		{
			_welcomePopUpOpened = true;
			
			addChild(_hudWelcomePopUp);
			
			dispatchEvent(new Event(WELCOME_OPENED_EVENT));
		}
		
		public function closeWelcomePopUp(e:Event = null):void
		{
			if (!_welcomePopUpOpened)
				return;
			
			_welcomePopUpOpened = false;
			
			removeChild(_hudWelcomePopUp);
			
			dispatchEvent(new Event(WELCOME_CLOSED_EVENT));
		}
		
		
		public function onPauseRequest(event:Event):void
		{
			dispatchEvent(new Event(TOGGLE_PAUSE_EVENT));
		}
		
		public function onKnowledgeRequest(event:Event):void
		{
			dispatchEvent(new Event(TOGGLE_KNOWLEDGE_EVENT));
		}
		
		public function onResumeRequest(event:Event):void
		{
			dispatchEvent(event);
		}
		
		public function oCreditsRequest(event:Event):void
		{
			dispatchEvent(event);
		}
		
		public function setClockVisibility(visible:Boolean):void 
		{
			_hudClock.visible = visible;
		}
		
		public function launchCinematic(type:String):void
		{
			if (type) {
				var cinematic:MovieClip = _cinematicsDictionary[type];
				
				if (!cinematic)
					return;
				
				_currentCinematicFunction = null;		
				_currentCinematicType = type;
						
				addChildAt(cinematic, numChildren);
				
				_cinematicOpened = true;
				
				switch(type) {
					case CINEMATIC_CAMERA_RECORDINGS :
						
						TweenLite.delayedCall(5.0, onCinematicLastFrame);
						
						dispatchEvent(new CinematicEvent(_currentCinematicType,CINEMATIC_OPENED_EVENT));
						
						break;
						
					case CINEMATIC_SHOOTING :
						FrameScriptInjector.injectFunction(cinematic,cinematic.totalFrames,onCinematicShootingDone);
						
						dispatchEvent(new CinematicEvent(_currentCinematicType,CINEMATIC_OPENED_EVENT));
						
						break;
					
					default :
						break;
				}
				cinematic.gotoAndPlay(1);
			}
		}
		
		protected function onCinematicLastFrame():void
		{
			var cinematic:MovieClip = _cinematicsDictionary[_currentCinematicType];
				
			if (_currentCinematicFunction)
				_currentCinematicFunction();
			
			_cinematicOpened = false;
			
			removeChild(cinematic);
			
			dispatchEvent(new CinematicEvent(_currentCinematicType,CINEMATIC_CLOSED_EVENT));
		
			_currentCinematicType = null;
			_currentCinematicFunction = null;
		}
		
		protected function onCinematicShootingDone():void
		{
			var cinematic:MovieClip = _cinematicsDictionary[_currentCinematicType];
				
			if (_currentCinematicFunction)
				_currentCinematicFunction();
			
			_cinematicOpened = false;
			
			removeChild(cinematic);
			
			dispatchEvent(new CinematicEvent(_currentCinematicType,CINEMATIC_CLOSED_EVENT));
		
			_currentCinematicType = null;
			_currentCinematicFunction = null;
		}
	}

}