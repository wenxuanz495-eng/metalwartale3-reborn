package other
{
   public class OneTimer
   {
      
      public var enabled:Boolean = false;
      
      public var t:int = 0;
      
      public var m:int = -1;
      
      public var m2:int = -1;
      
      public var fun:Function;
      
      public function OneTimer(_m:int)
      {
         super();
         this.m = _m;
         this.m2 = _m;
      }
      
      public function random() : *
      {
         this.m = this.m2 * (Math.random() + 0.5);
      }
      
      public function FTimer() : *
      {
         if(this.enabled)
         {
            if(this.t >= this.m)
            {
               this.t = 0;
               if(this.fun is Function)
               {
                  this.fun();
               }
            }
            else
            {
               ++this.t;
            }
         }
      }
   }
}

