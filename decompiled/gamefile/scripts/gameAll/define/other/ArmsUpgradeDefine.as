package gameAll.define.other
{
   import data.Base64;
   
   public class ArmsUpgradeDefine
   {
      
      private var conMust:String = "";
      
      private var conYoudaoMust:String = "200,300,400,500,600";
      
      public function ArmsUpgradeDefine()
      {
         super();
         for(var i:int = 0; i < 35; i++)
         {
            this.conMust += (i + 1) * 2 + "";
            if(i < 34)
            {
               this.conMust += ",";
            }
         }
         trace(this.conMust);
         this.conMust = Base64.encodeString(this.conMust);
         this.conYoudaoMust = Base64.encodeString(this.conYoudaoMust);
      }
      
      public function getYoudaoConMust(lv0:int) : Array
      {
         var num0:int = 0;
         var arr0:Array = Base64.decodeString(this.conYoudaoMust).split(",");
         if(lv0 > arr0.length)
         {
            return [];
         }
         num0 = int(arr0[lv0 - 1]);
         return ["justice_badge_num" + num0];
      }
      
      public function getConMust(lv0:int) : Array
      {
         var num0:int = 0;
         var arr0:Array = Base64.decodeString(this.conMust).split(",");
         if(lv0 > arr0.length)
         {
            return [];
         }
         num0 = int(arr0[lv0 - 1]);
         return ["justice_badge_num" + num0];
      }
   }
}

