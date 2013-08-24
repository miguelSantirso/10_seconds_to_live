package ten_seconds_to_live.com.five_ants.ten_secs.realities 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import ten_seconds_to_live.com.five_ants.ten_secs.Player;
	
	/**
	 * ...
	 * @author Miguel Santirso
	 */
	public interface IRealityConfig 
	{
		function constructHouseCollisions():Sprite;
		function constructFloors():Sprite;
		function constructPlayer():Player;
		function constructVisualGameMap():MovieClip;
	}
	
}