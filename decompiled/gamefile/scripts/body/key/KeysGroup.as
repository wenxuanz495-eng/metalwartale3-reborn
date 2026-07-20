package body.key
{
   import flash.events.KeyboardEvent;
   
   public class KeysGroup
   {
      
      public var arr:Array;
      
      public function KeysGroup()
      {
         var n:int = 0;
         this.arr = new Array(100);
         for(super(); n <= this.arr.length - 1; )
         {
            this.arr[n] = new Keys(n);
            n++;
         }
      }
      
      public function gamingInit() : *
      {
         var n:* = undefined;
         var key0:Keys = null;
         for(n in this.arr)
         {
            key0 = this.arr[n];
            key0.s = "uping";
         }
      }
      
      public function keyDown(event:KeyboardEvent) : *
      {
         var key0:Keys = null;
         var code:int = int(event.keyCode);
         if(code < this.arr.length)
         {
            key0 = this.arr[code];
            if(key0.s != "downing")
            {
               key0.s = "down";
            }
         }
      }
      
      public function keyUp(event:KeyboardEvent) : *
      {
         var key0:Keys = null;
         var code:int = int(event.keyCode);
         if(code < this.arr.length)
         {
            key0 = this.arr[code];
            key0.s = "up";
         }
      }
      
      public function KeyTimer() : *
      {
         var n:* = undefined;
         for(n in this.arr)
         {
            this.arr[n].toing();
         }
      }
   }
}

