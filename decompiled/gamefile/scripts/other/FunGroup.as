package other
{
   import data.INIT;
   
   public class FunGroup
   {
      
      private var _list:Array = new Array();
      
      private var funArr:Array = new Array();
      
      private var t0:int = 0;
      
      public var enabled:Boolean = true;
      
      public function FunGroup()
      {
         super();
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
      
      public function addOnceFun(fun:Function, time0:Number) : *
      {
         this.funArr.push(new OnceFun(fun,int(time0 * INIT.FPS)));
      }
      
      public function removeOnceFun(fun:Function) : *
      {
         var n:* = undefined;
         var fn:int = -1;
         for(n in this.funArr)
         {
            if(this.funArr[n].fun == fun)
            {
               fn = n;
               break;
            }
         }
         if(fn >= 0)
         {
            this.funArr.splice(fn,1);
            trace("删除事件成功");
         }
         else
         {
            trace("没找到事件：" + fn);
         }
      }
      
      public function ClearAllFun() : *
      {
         this.t0 = 0;
         this._list.splice(0);
         this.funArr.splice(0);
      }
      
      protected function FTimer() : *
      {
         var n:* = undefined;
         var f0:OnceFun = null;
         if(this.enabled)
         {
            for(n in this._list)
            {
               this._list[n]();
            }
            if(this.funArr.length > 0)
            {
               f0 = this.funArr[0];
               if(this.t0 >= f0.t0)
               {
                  f0.fun();
                  this.funArr.shift();
                  this.t0 = 0;
               }
               else
               {
                  ++this.t0;
               }
            }
         }
      }
      
      public function FTimer2() : *
      {
         this.FTimer();
      }
   }
}

