package sound
{
   import flash.media.Sound;
   import flash.media.SoundTransform;
   import gs.TweenLite;
   
   public class OneMusic extends OneSound
   {
      
      public function OneMusic(_sound:Sound, _label:String)
      {
         super(_sound,_label);
      }

      override public function play(_loopNum:int = 1, _v0:Number = 1) : *
      {
         if(Game.SG.playExternalMusic(this))
         {
            return;
         }
         if(this.s == null)
         {
            return;
         }
         this.SC = this.s.play(0,_loopNum,new SoundTransform(_v0 * Game.SG.getMusicGain()));
      }

      override public function stop() : *
      {
         if(!Game.SG.stopExternalMusic(this.label))
         {
            super.stop();
         }
      }

      public function stopFlashOnly() : *
      {
         super.stop();
      }
      
      public function tweenTo(_time:Number = 2, _end:Number = 0, _first:Number = -1) : *
      {
         if(getPlayB())
         {
            if(_first >= 0)
            {
               SC.soundTransform = new SoundTransform(_first * Game.SG.getMusicGain());
            }
            if(_end <= 0)
            {
               TweenLite.to(SC,_time,{
                  "volume":_end * Game.SG.getMusicGain(),
                  "onComplete":stop
               });
            }
            else
            {
               TweenLite.to(SC,_time,{"volume":_end * Game.SG.getMusicGain()});
            }
         }
      }
   }
}

