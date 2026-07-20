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
      
      public function tweenTo(_time:Number = 2, _end:Number = 0, _first:Number = -1) : *
      {
         if(getPlayB())
         {
            if(_first >= 0)
            {
               SC.soundTransform = new SoundTransform(_first);
            }
            if(_end <= 0)
            {
               TweenLite.to(SC,_time,{
                  "volume":_end,
                  "onComplete":stop
               });
            }
            else
            {
               TweenLite.to(SC,_time,{"volume":_end});
            }
         }
      }
   }
}

