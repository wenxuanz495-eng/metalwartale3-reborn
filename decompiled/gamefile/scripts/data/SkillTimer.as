package data
{
   public class SkillTimer
   {
      
      public var t:Number = -100;
      
      public var overFun:Function;
      
      public function SkillTimer()
      {
         super();
      }
      
      public function FTimer(e:* = null) : *
      {
         if(this.t <= 0 && this.t > -100)
         {
            this.t = -100;
            if(this.overFun is Function)
            {
               this.overFun();
            }
         }
         else if(this.t > 0)
         {
            this.t -= 1 / 24;
         }
      }
   }
}

