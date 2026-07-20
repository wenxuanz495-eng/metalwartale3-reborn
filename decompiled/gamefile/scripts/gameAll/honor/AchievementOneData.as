package gameAll.honor
{
   public class AchievementOneData
   {
      
      public var type:String = "";
      
      public var name:String = "";
      
      public var now:String = "";
      
      public var haveGiftB:Boolean = false;
      
      public var completeTime:String = "";
      
      public function AchievementOneData()
      {
         super();
      }
      
      public function inData_byObj(obj:Object) : *
      {
         var n:* = undefined;
         var pro0:String = null;
         var pro_arr:Array = ["type","name","now","haveGiftB","completeTime"];
         for(n in pro_arr)
         {
            pro0 = pro_arr[n];
            this[pro0] = obj[pro0];
         }
      }
      
      public function getDefine() : AchievementOneDefine
      {
         return Game.gameDefine.honor.ac.getDefine(this.type,this.name);
      }
   }
}

