package sound
{
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   
   public class OneSound
   {
      
      public var s:Sound;
      
      public var label:String = "";
      
      public var length:Number = 0;
      
      public var SC:SoundChannel;
      
      public var loopNum:int = 0;
      
      public function OneSound(_sound:Sound, _label:String)
      {
         super();
         this.s = _sound;
         this.label = _label;
         this.length = this.s.length;
      }
      
      public function play(_loopNum:int = 1, _v0:Number = 1) : *
      {
         this.SC = this.s.play(0,_loopNum,new SoundTransform(_v0));
      }
      
      public function getPlayB() : Boolean
      {
         if(this.SC is SoundChannel)
         {
            if(this.SC.position < this.length)
            {
               return true;
            }
         }
         return false;
      }
      
      public function stop() : *
      {
         if(this.getPlayB())
         {
            this.SC.stop();
            trace("停止");
         }
      }
   }
}

