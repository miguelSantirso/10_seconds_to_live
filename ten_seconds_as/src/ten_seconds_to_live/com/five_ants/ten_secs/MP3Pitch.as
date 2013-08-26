package ten_seconds_to_live.com.five_ants.ten_secs
{
	import flash.events.Event;
	import flash.events.SampleDataEvent;
	import flash.media.Sound;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;

	/**
	 * @author Andre Michelle (andre.michelle@gmail.com)
	 */
	public class MP3Pitch 
	{
		private const BLOCK_SIZE: int = 3072;
		
		private var _mp3: Sound;
		private var _sound: Sound;
		
		private var _target: ByteArray;
		
		private var _position: Number;
		private var _rate: Number;
		private var _pause:Boolean;
		private var _emptyBlock:ByteArray;
		
		public function MP3Pitch(original:Sound)
		{
			_target = new ByteArray();
			_emptyBlock = new ByteArray();
			_emptyBlock.length = BLOCK_SIZE;

			_mp3 = original;

			_position = 0.0;
			_rate = 1.0;

			_sound = new Sound();
			_sound.addEventListener( SampleDataEvent.SAMPLE_DATA, sampleData );
			_sound.play();
		}

		public function get rate(): Number
		{
			return _rate;
		}
		
		public function set rate( value: Number ): void
		{
			if( value < 0.0 )
				value = 0;

			_rate = value;
		}
		
		public function get pause():Boolean 
		{
			return _pause;
		}
		
		public function set pause(value:Boolean):void 
		{
			_pause = value;
		}

		public function play():void
		{
			_position = 0;
		}
		
		private function complete( event: Event ): void
		{
			_sound.play();
		}

		private function sampleData( event: SampleDataEvent ): void
		{
			//-- SHORTCUT
			var data: ByteArray = event.data;
			
			//-- REUSE INSTEAD OF RECREATION
			_target.position = 0;
			
			var scaledBlockSize: Number = BLOCK_SIZE * _rate;
			var positionInt: int = _position;
			var alpha: Number = _position - positionInt;

			var positionTargetNum: Number = alpha;
			var positionTargetInt: int = -1;

			//-- COMPUTE NUMBER OF SAMPLES NEED TO PROCESS BLOCK (+2 FOR INTERPOLATION)
			var need: int = Math.ceil( scaledBlockSize ) + 2;
			
			//-- EXTRACT SAMPLES
			var read: int = _mp3.extract( _target, need, positionInt );

			var n: int = read == need ? BLOCK_SIZE : read / _rate;

			var l0: Number;
			var r0: Number;
			var l1: Number;
			var r1: Number;

			for( var i: int = 0 ; !_pause && i < n ; ++i )
			{
				//-- AVOID READING EQUAL SAMPLES, IF RATE < 1.0
				if( int( positionTargetNum ) != positionTargetInt )
				{
					positionTargetInt = positionTargetNum;
					
					//-- SET TARGET READ POSITION
					_target.position = positionTargetInt << 3;
	
					//-- READ TWO STEREO SAMPLES FOR LINEAR INTERPOLATION
					l0 = _target.readFloat();
					r0 = _target.readFloat();

					l1 = _target.readFloat();
					r1 = _target.readFloat();
				}
				
				//-- WRITE INTERPOLATED AMPLITUDES INTO STREAM
				data.writeFloat( l0 + alpha * ( l1 - l0 ) );
				data.writeFloat( r0 + alpha * ( r1 - r0 ) );
				
				//-- INCREASE TARGET POSITION
				positionTargetNum += _rate;
				
				//-- INCREASE FRACTION AND CLAMP BETWEEN 0 AND 1
				alpha += _rate;
				while( alpha >= 1.0 ) --alpha;
			}
			
			//var lastBlock:Boolean = (_position) >= 442368 - BLOCK_SIZE;
			var lastBlock:Boolean = false;
			//-- FILL REST OF STREAM WITH ZEROs
			if( i < BLOCK_SIZE )
			{
				lastBlock = true;
				while( i < BLOCK_SIZE )
				{
 					data.writeFloat( 0.0 );
					data.writeFloat( 0.0 );
					
					++i;
				}
			}

			//-- INCREASE SOUND POSITION
			if (pause)
				return;
			else if (lastBlock)
			{
				_position = 0;
			}
			else
			{
				_position += scaledBlockSize;
			}
		}
	}
}
