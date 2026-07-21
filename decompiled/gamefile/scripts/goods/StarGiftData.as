package goods
{
   public class StarGiftData
   {
      
      public var Id:int = 0;
      
      public var NeedNum:int = 0;
      
      public var Name:String = "";
      
      public var GiftArr:Array = [];
      
      public var GiftDesc:String = "";
      
      public var Icon:String = "";
      
      public var AddArr:Array = [];

      public function getMCoinReward() : int
      {
         return Math.max(0,int(this.NeedNum / 10) * 70);
      }
      
      public function StarGiftData()
      {
         super();
      }
   }
}

