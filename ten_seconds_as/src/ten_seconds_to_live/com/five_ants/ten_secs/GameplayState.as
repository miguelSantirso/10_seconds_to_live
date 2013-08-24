package ten_seconds_to_live.com.five_ants.ten_secs 
{
	/**
	 * ...
	 * @author Miguel Santirso
	 */
	public class GameplayState extends IGameState 
	{
		private var _player:Player;
		private var _entities:Vector.<Entity> = new Vector.<Entity>();
		
		private var _playerInput:IPlayerInput;
		
		protected override function init():void 
		{
			_playerInput = new KeyboardInput();
			_playerInput.init(_stage);
			
			_player = new Player();
			_player.x = 300; _player.y = 300;
			addChild(_player);
			
			_entities.push(_player);
			
			for each (var entity:Entity in _entities)
				entity.load(this);
		}
		
		public override function update():void 
		{
			for each (var entity:Entity in _entities)
				entity.update();
		}
		
		public override function dispose():void 
		{
			_playerInput.dispose();
			
			for each (var entity:Entity in _entities)
				entity.dispose();
		}
		
		
		public function get playerInput():IPlayerInput
		{
			return _playerInput;
		}
		
	}

}