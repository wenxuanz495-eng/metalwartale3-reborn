package
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.ByteArray;
   import flash.utils.Timer;
   
   public class Decryption extends EventDispatcher
   {
      
      public static const DECRYPTION_COMPLETE:String = "decryptionComplete";
      
      private var _resultArray:Array;
      
      private var _bytes:ByteArray;
      
      private var _bytesAvailable:uint;
      
      private var _resultIndex:uint;
      
      private var _byteCurPos:uint;
      
      private var _bytePos:uint;
      
      private var _cycle:uint = 800000;
      
      private var _byteArrLen:int;
      
      private var _gameBtyeArr:ByteArray;
      
      private var _gameBtyeArrPos:uint;
      
      private var _gameKeyArr:Array;
      
      private var _gameKeyCurIndex:uint;
      
      private var _gameKeyArrLen:uint;
      
      private var _singleID:int;
      
      private var _time:int = 10;
      
      private var _isEnd:Boolean;
      
      private var _end:uint;
      
      private var _timer:Timer;
      
      public function Decryption()
      {
         super();
      }
      
      public function setData(param1:Array, param2:ByteArray) : void
      {
         if(param1 == null || param1.length <= 0 || param2 == null || param2.bytesAvailable <= 0)
         {
            throw new ArgumentError("解密游戏参数设置错误");
         }
         this._gameKeyArr = param1;
         this._bytes = param2;
         this._bytesAvailable = this._bytes.bytesAvailable;
         this._gameKeyArrLen = this._gameKeyArr.length;
         this.startRun();
      }
      
      public function get gameBtyeArr() : ByteArray
      {
         return this._gameBtyeArr;
      }
      
      private function startRun() : void
      {
         this._gameKeyCurIndex = 0;
         this._resultArray = [];
         this._bytePos = this._bytes.position;
         this._bytes.position = 0;
         this._bytesAvailable = this._bytes.bytesAvailable;
         this._end = 0;
         this._isEnd = false;
         if(this._timer == null)
         {
            this._timer = new Timer(10);
         }
         this._timer.addEventListener(TimerEvent.TIMER,this.getFileBinary);
         this._timer.start();
      }
      
      private function getFileBinary(param1:int, param2:Array = null) : void
      {
         this._bytes.position = this._byteCurPos;
         if(this._byteCurPos + this._cycle >= this._bytesAvailable)
         {
            this._end = this._bytesAvailable - 1;
            this._isEnd = true;
         }
         else
         {
            this._end = this._byteCurPos + this._cycle - 1;
         }
         this._byteCurPos;
         while(this._byteCurPos <= this._end)
         {
            this._resultArray[this._resultArray.length] = this._bytes.readUnsignedByte();
            ++this._byteCurPos;
         }
         if(this._isEnd)
         {
            this._resultIndex = 0;
            this._gameBtyeArr = new ByteArray();
            this._isEnd = false;
            this._byteArrLen = this._resultArray.length;
            this._timer.stop();
            this._timer.removeEventListener(TimerEvent.TIMER,this.getFileBinary);
            this._timer.addEventListener(TimerEvent.TIMER,this.displacementBtyeArr);
            this._timer.start();
         }
      }
      
      private function displacementBtyeArr(param1:int, param2:Array = null) : void
      {
         if(this._resultIndex + this._cycle >= this._byteArrLen)
         {
            this._end = this._resultIndex + this._cycle;
            this._isEnd = true;
         }
         else
         {
            this._end = this._byteArrLen;
         }
         this._resultIndex;
         while(this._resultIndex < this._end)
         {
            if(this._gameKeyCurIndex >= this._gameKeyArrLen)
            {
               this._gameKeyCurIndex = 0;
            }
            this._gameBtyeArr.writeByte(this._resultArray[this._resultIndex] ^ this._gameKeyArr[this._gameKeyCurIndex]);
            ++this._resultIndex;
            ++this._gameKeyCurIndex;
         }
         if(this._isEnd)
         {
            this._timer.stop();
            this._timer.removeEventListener(TimerEvent.TIMER,this.displacementBtyeArr);
            this._timer = null;
            dispatchEvent(new Event(DECRYPTION_COMPLETE));
         }
      }
   }
}

