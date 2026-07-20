package gameAll
{
   public class NormalMustDefine
   {
      
      public var index:int = 0;
      
      public var GCoin:Number = 0;
      
      public var GCoin_arr:Array = [0];
      
      public var MCoin:int = 0;
      
      public var MCoin_arr:Array = [0];
      
      public var mustLevel:int = 0;
      
      public var level_arr:Array = [0];
      
      public var mustRankLevel:int = 0;
      
      public var rankLevel_arr:Array = [0];
      
      public function NormalMustDefine()
      {
         super();
      }
      
      public function fleshByIndex(index0:int) : *
      {
         this.index = index0;
         if(index0 > this.GCoin_arr.length - 1)
         {
            this.GCoin = this.GCoin_arr[this.GCoin_arr.length - 1];
         }
         else
         {
            this.GCoin = this.GCoin_arr[index0];
         }
         if(index0 > this.level_arr.length - 1)
         {
            this.mustLevel = this.level_arr[this.level_arr.length - 1];
         }
         else
         {
            this.mustLevel = this.level_arr[index0];
         }
         if(index0 > this.MCoin_arr.length - 1)
         {
            this.MCoin = this.MCoin_arr[this.MCoin_arr.length - 1];
         }
         else
         {
            this.MCoin = this.MCoin_arr[index0];
         }
         if(index0 > this.rankLevel_arr.length - 1)
         {
            this.mustRankLevel = this.rankLevel_arr[this.rankLevel_arr.length - 1];
         }
         else
         {
            this.mustRankLevel = this.rankLevel_arr[index0];
         }
      }
   }
}

