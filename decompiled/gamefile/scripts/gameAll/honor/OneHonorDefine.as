package gameAll.honor
{
   public class OneHonorDefine
   {
      
      public var name:String = "";
      
      public var cnName:String = "";
      
      public var pro:String = "";
      
      public var condition:String = "";
      
      public var add:Array = [];
      
      public function OneHonorDefine()
      {
         super();
      }
      
      public function inData_byObj(obj:Object) : *
      {
         var n:* = undefined;
         var pro0:String = null;
         var pro_arr:Array = ["name","cnName","pro","condition"];
         for(n in pro_arr)
         {
            pro0 = pro_arr[n];
            this[pro0] = obj[pro0];
         }
         this.add = this.copyArray(obj.add);
      }
      
      public function copy() : OneHonorDefine
      {
         var d0:OneHonorDefine = new OneHonorDefine();
         d0.inData_byObj(this);
         return d0;
      }
      
      private function copyArray(arr0:Array) : Array
      {
         var n:* = undefined;
         var xx0:* = undefined;
         var arr1:Array = [];
         for(n in arr0)
         {
            xx0 = arr0[n];
            if(xx0 is String || xx0 is int || xx0 is Number)
            {
               arr1.push(xx0);
            }
            else if(Boolean(xx0.hasOwnProperty("clone")))
            {
               arr1.push(xx0.clone());
            }
         }
         return arr1;
      }
   }
}

