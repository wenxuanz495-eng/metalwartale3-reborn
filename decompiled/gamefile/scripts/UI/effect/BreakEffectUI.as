package UI.effect
{
   import effect.OutbreakEffect;
   
   public class BreakEffectUI extends OutbreakEffect
   {
      
      public var overFun:Function;
      
      public function BreakEffectUI()
      {
         super();
         stop();
      }
      
      override public function start(x0:int, y0:int) : *
      {
         super.start(x0,y0);
         bitmap.visible = true;
         gotoAndPlay(1);
         this.visible = true;
      }
      
      override public function timer(e:*) : *
      {
         super.timer(e);
         if(tweenB)
         {
            if(this.currentFrame == this.totalFrames)
            {
               stop();
               this.visible = false;
               clear();
               if(this.overFun is Function)
               {
                  this.overFun();
               }
            }
            else if(this.currentLabel == "change")
            {
               bitmap.visible = false;
            }
         }
      }
   }
}

