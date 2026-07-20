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
         var _loc1_:int = 0;
         while(_loc1_ < 20)
         {
            this.p_arr.push("chj2test" + TextWay.toNum(_loc1_ + 1 + "",3));
            _loc1_++;
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
      
      public function pan(param1:String, param2:Boolean) : Boolean
      {
         var _loc3_:Array = ExtraDefine.swapToText(this.all_arr);
         var _loc4_:Array = ExtraDefine.swapToText(this.p_arr);
         var _loc5_:Boolean = false;
         if(param2)
         {
            if(this.containsText_inArr(param1,_loc3_) || _loc4_.indexOf(param1) >= 0)
            {
               _loc5_ = true;
            }
         }
         else if(_loc4_.indexOf(param1) == -1)
         {
            _loc5_ = true;
         }
         return _loc5_;
      }
      
      public function containsText_inArr(param1:String, param2:Array) : Boolean
      {
         var _loc3_:* = undefined;
         for(_loc3_ in param2)
         {
            if(param1.indexOf(param2[_loc3_]) >= 0)
            {
               return true;
            }
         }
         return false;
      }
   }
}

