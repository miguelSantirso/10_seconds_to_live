package ten_seconds_to_live.com.five_ants.ten_secs
{
	import flash.display.MovieClip;
	import flash.display.Scene;
	import flash.events.Event;

	/**
	 * Class that contains static function that help injecting commonly useful
	 * scripts into specific frames of movieclips.
	 * 
	 * <p>Be careful, this uses an undocumented feature of ActionScript 3.0 
	 * (<code>MovieClip.addFrameScript</code>)
	 */	
	public final class FrameScriptInjector
	{
		/**
		 * Injects a <code>stop()</code> to the frame specified of the passed 
		 * <code>MovieClip</code>
		 *  
		 * @param mc MovieClip to inject the <code>stop</code> into
		 * @param frame Frame where the script should be injected. The first 
		 * frame is "1"
		 * @param eventToDispatch If different than "", the movieclip will 
		 * dispatch an event with the given name when arrives to the frame. 
		 */		
		public static function injectStop(mc:MovieClip, frame:int, eventToDispatch:String = ""):void
		{
			if (eventToDispatch == "")
				injectFunction(mc, frame, stopScript(mc));
			else
				injectFunction(mc, frame, stopAndDispatchEventScript(mc, eventToDispatch));
		}
		
		
		/**
		 * The same as injectStop but you can reference the frame by its label
		 */		
		public static function injectStopToLabel(mc:MovieClip, frameLabel:String, eventToDispatch:String = ""):void
		{
			injectStop(mc, getFrameByLabel(mc, frameLabel), eventToDispatch);
		}
		
		
		/**
		 * Injects a <code>stop()</code> to the last frame of the animation
		 *  
		 * @param mc MovieClip to inject the <code>stop</code> into
		 * @param eventToDispatch If different than "", the movieclip will 
		 * dispatch an event with the given name when arrives to the frame. 
		 */		
		public static function injectStopAtEnd(mc:MovieClip, eventToDispatch:String = ""):void
		{
			injectStop(mc, mc.totalFrames, eventToDispatch);
		}
		
		
		/**
		 * Injects any function into the frame specified of the passed movieclip 
		 */		
		public static function injectFunction(mc:MovieClip, frame:int, func:Function):void
		{
			// Remember this function takes zero-based frame indexes
			mc.addFrameScript(frame - 1, func);
		}
		
		/**
		 * The same as injectFunction but allowing to specify the frame by its label
		 */		
		public static function injectFunctionToLabel(mc:MovieClip, frameLabel:String, func:Function):void
		{
			injectFunction(mc, getFrameByLabel(mc, frameLabel), func);
		}
		
		
		
		private static function getFrameByLabel(mc:MovieClip, frameLabel:String):int
		{
			var frameNumber:int = -1;
			
			for( var i:int = 0; frameNumber < 0 && i < mc.currentLabels.length; i++)
			{
				if(mc.currentLabels[i].name == frameLabel)
					frameNumber = mc.currentLabels[i].frame;
			}
			
			if (frameNumber < 0)
			{
				throw new Error("Can't find label \"" + frameLabel + "\" in MovieClip");
			}
			if (frameNumber == 1)
			{
				frameNumber=2;
			}
			return frameNumber;
		}
		
		
		/**
		 * Returns a function that stops the passed movieclip when called
		 */		
		private static function stopScript(target:MovieClip):Function
		{
			return function():void
			{
				target.stop();
			}
		}
		private static function stopAndDispatchEventScript(target:MovieClip, eventName:String):Function
		{
			return function():void
			{
				target.stop();
				target.dispatchEvent(new Event(eventName));
			}
		}
		
		
	}
}