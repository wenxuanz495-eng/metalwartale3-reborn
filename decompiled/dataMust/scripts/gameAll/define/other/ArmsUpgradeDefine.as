package gameAll.define.other
{
   import data.Base64;
   
   public class ArmsUpgradeDefine
   {
      
      private var conMust:String = "";
      
      public function ArmsUpgradeDefine()
      {
         super();
         var _loc1_:int = 0;
         while(_loc1_ < 35)
         {
            this.conMust += (_loc1_ + 1) * 2 + "";
            if(_loc1_ < 34)
            {
               this.conMust += ",";
            }
            _loc1_++;
         }
         trace(this.conMust);
         this.conMust = Base64.encodeString(this.conMust);
      }
      
      public function getConMust(param1:int) : Array
      {
         var _loc3_:int = 0;
         var _loc2_:Array = Base64.decodeString(this.conMust).split(",");
         if(param1 > _loc2_.length)
         {
            return [];
         }
         _loc3_ = int(_loc2_[param1 - 1]);
         return ["justice_badge_num" + _loc3_];
      }
   }
}

