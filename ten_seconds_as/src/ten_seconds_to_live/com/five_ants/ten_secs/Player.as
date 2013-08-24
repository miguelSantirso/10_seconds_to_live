package ten_seconds_to_live.com.five_ants.ten_secs 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Miguel Santirso
	 */
	public class Player extends Entity 
	{
		protected static const SPEED_HORIZONTAL:Number = 3.8;
		protected static const SPEED_VERTICAL:Number = 5;
		
		public function Player()
		{
			super();
			
			graphics.beginFill(0, 1);
			graphics.drawRect( -5, 0, 10, -50);
			graphics.endFill();
		}
		
		public override function update():void
		{
			if (_gameplay.playerInput.leftPressed)
				x -= SPEED_HORIZONTAL;
			if (_gameplay.playerInput.rightPressed)
				x += SPEED_HORIZONTAL;
			if (_gameplay.playerInput.upPressed)
				y -= SPEED_VERTICAL;
			if (_gameplay.playerInput.downPressed)
				y += SPEED_VERTICAL;
			
		}
	}

}