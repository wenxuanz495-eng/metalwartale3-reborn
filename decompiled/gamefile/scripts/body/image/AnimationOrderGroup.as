package body.image
{
   public class AnimationOrderGroup
   {
      
      private var arr:Array = new Array();
      
      public function AnimationOrderGroup()
      {
         super();
      }
      
      public function addOrder(arr0:Array) : *
      {
         var n:* = undefined;
         for(n in arr0)
         {
            this.arr.push(arr0[n]);
         }
      }
      
      public function add(arr0:Array) : *
      {
         var n:* = undefined;
         this.arr.splice(0);
         for(n in arr0)
         {
            this.arr.push(new AnimationOrder(arr0[n][0],arr0[n][1]));
         }
      }
      
      public function addNewOrder(arr0:Array) : *
      {
         this.arr.splice(0);
         this.addOrder(arr0);
      }
      
      public function clearAll() : *
      {
         this.arr.splice(0);
      }
      
      public function getAnimationOrder() : AnimationOrder
      {
         if(this.arr.length > 0)
         {
            return this.arr[0];
         }
         return null;
      }
      
      public function setData_AnimationEnd() : *
      {
         var ao:AnimationOrder = null;
         if(this.arr.length > 0)
         {
            ao = this.arr[0];
            ++ao.repeatNow;
            if(ao.repeat != 0)
            {
               if(ao.repeat > 0)
               {
                  if(ao.repeatNow >= ao.repeat)
                  {
                     this.arr.shift();
                  }
               }
            }
         }
      }
   }
}

