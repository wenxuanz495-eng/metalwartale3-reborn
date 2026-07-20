package UI
{
   import data.Base64;
   
   public class ZuobiPan
   {
      
      public var str_arr:Array = ["1000","9000","4000","5000","2000","6000","5000","4000"];
      
      public var arr1:Array = [];
      
      public var int_arr:Array = [86,100000,1606,3206,6406];
      
      public var arr2:Array = [];
      
      public var Number_arr:Array = [0.02,1.5];
      
      public var arr3:Array = [];
      
      public function ZuobiPan()
      {
         super();
         this.arr1 = this.bak(this.str_arr);
         this.arr2 = this.bak(this.int_arr);
         this.arr3 = this.bak(this.Number_arr);
      }
      
      private function bak(arr0:Array) : Array
      {
         var n:* = undefined;
         var str0:String = null;
         var arr1:Array = [];
         for(n in arr0)
         {
            str0 = String(arr0[n]);
            arr1[n] = Base64.encodeString(str0);
         }
         return arr1;
      }
      
      public function pan() : Boolean
      {
         if(this.panOne(this.str_arr,this.arr1))
         {
            return true;
         }
         if(this.panOne(this.int_arr,this.arr2))
         {
            return true;
         }
         if(this.panOne(this.Number_arr,this.arr3))
         {
            return true;
         }
         return false;
      }
      
      private function panOne(a1:Array, a2:Array, type0:String = "String") : Boolean
      {
         var n:* = undefined;
         var str0:* = undefined;
         var str1:* = undefined;
         for(n in a1)
         {
            str0 = a1[n];
            str1 = Base64.decodeString(a2[n]);
            if(type0 == "String")
            {
               str1 = String(str1);
            }
            else if(type0 == "int")
            {
               str1 = int(str1);
            }
            else if(type0 == "Number")
            {
               str1 = Number(str1);
            }
            if(str0 != str1)
            {
               return true;
            }
         }
         return false;
      }
   }
}

