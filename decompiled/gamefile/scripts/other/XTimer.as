package other
{
   public class XTimer
   {
      
      internal var _list:Array = new Array();
      
      public var stopB:Boolean = false;
      
      public var multiple:int = 1;
      
      public var n0:int = 1;
      
      public function XTimer(_multiple:int = 1)
      {
         super();
         this.multiple = _multiple;
      }
      
      public function addFun(fun:Function) : *
      {
         this._list.push(fun);
      }
      
      public function removeFun(fun:Function) : *
      {
         var fn:int = this._list.indexOf(fun);
         if(fn >= 0)
         {
            this._list.splice(fn,1);
         }
      }
      
      public function clear() : *
      {
         this._list.length = 0;
      }
      
      public function FTimer() : *
      {
         var n:* = undefined;
         if(!this.stopB)
         {
            if(this.n0 >= this.multiple)
            {
               for(n in this._list)
               {
                  this._list[n]();
               }
               this.n0 = 1;
            }
            else
            {
               ++this.n0;
            }
         }
      }
   }
}

