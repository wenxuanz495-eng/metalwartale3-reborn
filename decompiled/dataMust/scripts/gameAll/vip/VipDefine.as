package gameAll.vip
{
   public class VipDefine
   {
      
      public var arr:Array;
      
      public function VipDefine()
      {
         var _loc1_:OneVipDefine = null;
         this.arr = [];
         super();
         var _loc2_:Array = [];
         _loc1_ = new OneVipDefine();
         _loc1_.name = "vipCard_0";
         _loc1_.cnName = "VIP体验卡";
         _loc1_.honor = "体验VIP";
         _loc1_.expAdd = 0.1;
         _loc1_.achieveAdd = 0.2;
         _loc1_.all_pro = 0.1;
         _loc1_.durationTime = 0.01;
         _loc2_ = [];
         _loc2_.push("GCoin,\t\t50000,\t\t\t1");
         _loc2_.push("achieve,\t\t100,\t\t\t1");
         _loc1_.giftArr = _loc2_;
         this.arr.push(_loc1_);
         _loc1_ = new OneVipDefine();
         _loc1_.name = "vipCard_1";
         _loc1_.cnName = "VIP周卡";
         _loc1_.honor = "黄金VIP";
         _loc1_.expAdd = 0.1;
         _loc1_.achieveAdd = 0.2;
         _loc1_.all_pro = 0.1;
         _loc1_.durationTime = 7;
         _loc2_ = [];
         _loc2_.push("GCoin,\t\t50000,\t\t\t1");
         _loc2_.push("achieve,\t\t100,\t\t\t1");
         _loc1_.giftArr = _loc2_;
         this.arr.push(_loc1_);
         _loc1_ = new OneVipDefine();
         _loc1_.name = "vipCard_2";
         _loc1_.cnName = "VIP半月卡";
         _loc1_.honor = "白金VIP";
         _loc1_.expAdd = 0.2;
         _loc1_.achieveAdd = 0.3;
         _loc1_.all_pro = 0.15;
         _loc1_.durationTime = 15;
         _loc2_ = [];
         _loc2_.push("GCoin,\t\t100000,\t\t\t1");
         _loc2_.push("achieve,\t\t200,\t\t\t1");
         _loc1_.giftArr = _loc2_;
         this.arr.push(_loc1_);
         _loc1_ = new OneVipDefine();
         _loc1_.name = "vipCard_3";
         _loc1_.cnName = "VIP月卡";
         _loc1_.honor = "钻石VIP";
         _loc1_.expAdd = 0.3;
         _loc1_.achieveAdd = 0.5;
         _loc1_.all_pro = 0.2;
         _loc1_.durationTime = 30;
         _loc2_ = [];
         _loc2_.push("GCoin,\t\t200000,\t\t\t1");
         _loc2_.push("achieve,\t\t500,\t\t\t1");
         _loc1_.giftArr = _loc2_;
         this.arr.push(_loc1_);
         _loc1_ = new OneVipDefine();
         _loc1_.name = "vipCard_4";
         _loc1_.cnName = "VIP终生卡";
         _loc1_.honor = "终生VIP";
         _loc1_.expAdd = 0.5;
         _loc1_.achieveAdd = 1;
         _loc1_.all_pro = 0.5;
         _loc1_.durationTime = 10000;
         _loc2_ = [];
         _loc2_.push("GCoin,\t\t500000,\t\t\t1");
         _loc2_.push("achieve,\t\t1000,\t\t\t1");
         _loc1_.giftArr = _loc2_;
         this.arr.push(_loc1_);
      }
      
      public function getDefine(param1:String) : *
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         for(_loc2_ in this.arr)
         {
            _loc3_ = this.arr[_loc2_];
            if(_loc3_.name == param1)
            {
               return _loc3_;
            }
         }
         return null;
      }
   }
}

