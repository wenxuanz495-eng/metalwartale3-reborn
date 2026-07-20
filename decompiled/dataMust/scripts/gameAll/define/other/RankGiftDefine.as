package gameAll.define.other
{
   import gameAll.define.ExtraDefine;
   
   public class RankGiftDefine
   {
      
      public var arr:Array;
      
      public function RankGiftDefine()
      {
         var _loc1_:Array = null;
         this.arr = [];
         super();
         this.arr.push([]);
         this.arr.push([]);
         this.arr.push([]);
         this.arr.push([]);
         _loc1_ = [];
         _loc1_.push("GCoin,\t\t100000,\t\t\t\t1");
         _loc1_.push("random,\t\t20,\t\t\t\t\t20");
         _loc1_.push("materials,\tsuperalloy_Z,\t3");
         _loc1_.push("crystal_2,\t2,\t\t\t\t\t\t2");
         _loc1_.push("materials,\tyellow_chip,\t\t1");
         this.arr.push(_loc1_);
         _loc1_ = [];
         _loc1_.push("GCoin,\t\t150000,\t\t\t1");
         _loc1_.push("random,\t\t30,\t\t\t\t\t30");
         _loc1_.push("materials,\tsuperalloy_Z,\t6");
         _loc1_.push("crystal_2,\t3,\t\t\t\t\t\t3");
         _loc1_.push("materials,\tyellow_chip,\t\t1");
         this.arr.push(_loc1_);
         _loc1_ = [];
         _loc1_.push("GCoin,\t\t200000,\t\t\t1");
         _loc1_.push("random,\t\t40,\t\t\t\t\t40");
         _loc1_.push("materials,\tsuperalloy_Z,\t9");
         _loc1_.push("crystal_2,\t4,\t\t\t\t\t\t4");
         _loc1_.push("materials,\tyellow_chip,\t\t1");
         this.arr.push(_loc1_);
         _loc1_ = [];
         _loc1_.push("GCoin,\t\t300000,\t\t\t1");
         _loc1_.push("random,\t\t50,\t\t\t\t\t50");
         _loc1_.push("materials,\tsuperalloy_Z,\t12");
         _loc1_.push("crystal_3,\t2,\t\t\t\t\t\t2");
         _loc1_.push("materials,\torange_chip,\t\t1");
         this.arr.push(_loc1_);
         _loc1_ = [];
         _loc1_.push("GCoin,\t\t400000,\t\t\t1");
         _loc1_.push("random,\t\t60,\t\t\t\t\t60");
         _loc1_.push("materials,\tsuperalloy_Z,\t15");
         _loc1_.push("crystal_3,\t3,\t\t\t\t\t\t3");
         _loc1_.push("materials,\torange_chip,\t\t1");
         this.arr.push(_loc1_);
         _loc1_ = [];
         _loc1_.push("GCoin,\t\t500000,\t\t\t1");
         _loc1_.push("random,\t\t70,\t\t\t\t\t70");
         _loc1_.push("materials,\tsuperalloy_Z,\t18");
         _loc1_.push("crystal_3,\t4,\t\t\t\t\t\t4");
         _loc1_.push("materials,\torange_chip,\t\t1");
         this.arr.push(_loc1_);
         _loc1_ = [];
         _loc1_.push("GCoin,\t\t600000,\t\t\t1");
         _loc1_.push("random,\t\t80,\t\t\t\t\t80");
         _loc1_.push("materials,\tsuperalloy_Z,\t21");
         _loc1_.push("crystal_4,\t2,\t\t\t\t\t\t2");
         _loc1_.push("materials,\tgreen_chip,\t\t1");
         this.arr.push(_loc1_);
         _loc1_ = [];
         _loc1_.push("GCoin,\t\t700000,\t\t\t1");
         _loc1_.push("random,\t\t90,\t\t\t\t\t90");
         _loc1_.push("materials,\tsuperalloy_Z,\t24");
         _loc1_.push("crystal_4,\t3,\t\t\t\t\t\t3");
         _loc1_.push("materials,\tgreen_chip,\t\t1");
         this.arr.push(_loc1_);
         _loc1_ = [];
         _loc1_.push("GCoin,\t\t800000,\t\t\t1");
         _loc1_.push("random,\t\t100,\t\t\t\t\t100");
         _loc1_.push("materials,\tsuperalloy_Z,\t27");
         _loc1_.push("crystal_4,\t4,\t\t\t\t\t\t4");
         _loc1_.push("materials,\tgreen_chip,\t\t1");
         this.arr.push(_loc1_);
         _loc1_ = [];
         _loc1_.push("GCoin,\t\t1000000,\t\t\t1");
         _loc1_.push("random,\t\t110,\t\t\t\t\t110");
         _loc1_.push("materials,\tsuperalloy_Z,\t30");
         _loc1_.push("crystal_5,\t2,\t\t\t\t\t\t2");
         _loc1_.push("materials,\tgreen_chip,\t\t1");
         this.arr.push(_loc1_);
         _loc1_ = [];
         _loc1_.push("GCoin,\t\t2000000,\t\t\t1");
         _loc1_.push("random,\t\t120,\t\t\t\t\t120");
         _loc1_.push("materials,\tsuperalloy_Z,\t40");
         _loc1_.push("crystal_5,\t3,\t\t\t\t\t\t3");
         _loc1_.push("materials,\tgreen_chip,\t\t1");
         this.arr.push(_loc1_);
         _loc1_ = [];
         _loc1_.push("GCoin,\t\t2000000,\t\t\t1");
         _loc1_.push("random,\t\t120,\t\t\t\t\t120");
         _loc1_.push("materials,\tsuperalloy_Z,\t40");
         _loc1_.push("crystal_5,\t3,\t\t\t\t\t\t3");
         _loc1_.push("materials,\tgreen_chip,\t\t1");
         this.arr.push(_loc1_);
         ExtraDefine.swapToCode2(this.arr);
      }
      
      public function getGift(param1:int) : Array
      {
         var _loc2_:Array = this.arr[param1];
         if(_loc2_)
         {
            return ExtraDefine.swapToText(_loc2_);
         }
         return null;
      }
   }
}

