package UI.helper
{
   public class HelperContextBarDefine
   {
      
      public var iconLabel:String = "";
      
      public var title:String = "";
      
      public var context:String = "";
      
      public var gotoTarget:String = "";
      
      public var enemyLevel:int = 0;
      
      public function HelperContextBarDefine()
      {
         super();
      }
      
      public function toString() : String
      {
         var i:* = undefined;
         var str0:String = "";
         var arr0:Array = ["iconLabel","title","context","gotoTarget"];
         for(i in arr0)
         {
            str0 += arr0[i] + ":" + this[arr0[i]] + "，";
         }
         return str0;
      }
   }
}

