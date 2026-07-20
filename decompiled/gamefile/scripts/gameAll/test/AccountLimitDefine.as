package gameAll.test
{
   import data.TextWay;
   import gameAll.define.ExtraDefine;
   
   public class AccountLimitDefine
   {
      
      public var all_arr:Array = [];
      
      public var p_arr:Array = [];
      
      public function AccountLimitDefine()
      {
         super();
         for(var i:int = 0; i < 20; i++)
         {
            this.p_arr.push("chj2test" + TextWay.toNum(i + 1 + "",3));
         }
         this.all_arr.push("sounto");
         this.all_arr.push("metalwartale");
         this.all_arr.push("xinye011");
         this.all_arr.push("whiteless");
         this.all_arr.push("johnkills");
         this.all_arr.push("hekan01");
         ExtraDefine.swapToCode(this.all_arr);
         ExtraDefine.swapToCode(this.p_arr);
      }
      
      public function pan(name0:String, pB:Boolean) : Boolean
      {
         var arr1:Array = ExtraDefine.swapToText(this.all_arr);
         var arr2:Array = ExtraDefine.swapToText(this.p_arr);
         var bb:Boolean = false;
         if(pB)
         {
            if(this.containsText_inArr(name0,arr1) || arr2.indexOf(name0) >= 0)
            {
               bb = true;
            }
         }
         else if(arr2.indexOf(name0) == -1)
         {
            bb = true;
         }
         return bb;
      }
      
      public function containsText_inArr(name0:String, arr0:Array) : Boolean
      {
         var n:* = undefined;
         for(n in arr0)
         {
            if(name0.indexOf(arr0[n]) >= 0)
            {
               return true;
            }
         }
         return false;
      }
   }
}

