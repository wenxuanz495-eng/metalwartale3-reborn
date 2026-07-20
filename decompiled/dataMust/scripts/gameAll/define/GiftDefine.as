package gameAll.define
{
   public class GiftDefine
   {
      
      public var oneYuan_arr:Array = [];
      
      public var pay_arr:Array = [100,200,500,1000,2000,3000,4000,5000,10000,20000,30000,40000,43990,50000,60000,70000,79980,80000,90000,99980,100000];
      
      public var onePay_arr:Array = [100,500,1000,2000,3000,5000];
      
      public var payBagMust:Array = [4,4,6,8,8,8,8,8,13,13,13,13,0,13,23,23,-1,23,23,-2,53];
      
      public var payGift:Array = [];
      
      public var onePayGift:Array = [];
      
      public var douwa_gift:Array = [];
      
      public var douwa_gift2:Array = [];
      
      public var douwa_gift3:Array = [];
      
      public var pay29:Array = [];
      
      public function GiftDefine()
      {
         super();
         this.oneYuan_arr.push("materials,\tsuperalloy_X,\t\t5");
         this.oneYuan_arr.push("props,\t\trebirth_crystal,1");
         this.oneYuan_arr.push("props,\t\texp_card_double,1");
         this.oneYuan_arr.push("props,\t\tGCoin_card_3,\t1");
         var _loc1_:int = 0;
         while(_loc1_ < 100)
         {
            this.payGift[_loc1_] = new Array();
            this.onePayGift[_loc1_] = new Array();
            _loc1_++;
         }
         this.payGift[0].push("props,\t\trebirth_crystal,1");
         this.payGift[0].push("materials,\tsuperalloy,\t\t8");
         this.payGift[0].push("props,\t\tGCoin_card_3,\t1");
         this.payGift[0].push("materials,\tsuperalloy_Z,\t2");
         this.payGift[0].push("materials,\tgreen_chip,\t\t1");
         this.payGift[0].push("crystal,\t4,\t\t\t\t1");
         this.payGift[1].push("props,\t\trebirth_crystal,1");
         this.payGift[1].push("materials,\tsuperalloy,\t\t8");
         this.payGift[1].push("props,\t\tGCoin_card_3,\t1");
         this.payGift[1].push("materials,\tsuperalloy_Z,\t2");
         this.payGift[1].push("materials,\tgreen_chip,\t\t1");
         this.payGift[1].push("crystal,\t4,\t\t\t\t1");
         this.payGift[2].push("props,\t\trebirth_crystal,1");
         this.payGift[2].push("materials,\tsuperalloy,\t\t24");
         this.payGift[2].push("props,\t\tGCoin_card_3,\t3");
         this.payGift[2].push("materials,\tsuperalloy_Z,\t6");
         this.payGift[2].push("materials,\tgreen_chip,\t\t3");
         this.payGift[2].push("props,\t\tlife_capsule,\t1");
         this.payGift[2].push("crystal,\t4,\t\t\t\t2");
         this.payGift[3].push("props,\t\trebirth_crystal,2");
         this.payGift[3].push("materials,\tsuperalloy,\t\t40");
         this.payGift[3].push("props,\t\tGCoin_card_3,\t5");
         this.payGift[3].push("materials,\tsuperalloy_Z,\t10");
         this.payGift[3].push("materials,\tgreen_chip,\t\t5");
         this.payGift[3].push("props,\t\tlife_capsule,\t1");
         this.payGift[3].push("crystal,\t4,\t\t\t\t2");
         this.payGift[4].push("props,\t\trebirth_crystal,5");
         this.payGift[4].push("materials,\tsuperalloy,\t\t40");
         this.payGift[4].push("props,\t\tGCoin_card_4,\t1");
         this.payGift[4].push("materials,\tsuperalloy_Z,\t10");
         this.payGift[4].push("materials,\tgreen_chip,\t\t5");
         this.payGift[4].push("props,\t\tlife_capsule,\t1");
         this.payGift[4].push("crystal,\t5,\t\t\t\t2");
         this.payGift[5].push("props,\t\trebirth_crystal,5");
         this.payGift[5].push("materials,\tsuperalloy,\t\t40");
         this.payGift[5].push("props,\t\tGCoin_card_4,\t1");
         this.payGift[5].push("materials,\tsuperalloy_Z,\t10");
         this.payGift[5].push("materials,\tgreen_chip,\t\t5");
         this.payGift[5].push("props,\t\tlife_capsule,\t1");
         this.payGift[5].push("crystal,\t5,\t\t\t\t2");
         this.payGift[6].push("props,\t\trebirth_crystal,5");
         this.payGift[6].push("materials,\tsuperalloy,\t\t40");
         this.payGift[6].push("props,\t\tGCoin_card_4,\t1");
         this.payGift[6].push("materials,\tsuperalloy_Z,\t10");
         this.payGift[6].push("materials,\tgreen_chip,\t\t5");
         this.payGift[6].push("props,\t\tlife_capsule,\t1");
         this.payGift[6].push("props,\t\tdefence_capsule,1");
         this.payGift[6].push("crystal,\t5,\t\t\t\t2");
         this.payGift[7].push("props,\t\trebirth_crystal,5");
         this.payGift[7].push("materials,\tsuperalloy,\t\t40");
         this.payGift[7].push("props,\t\tGCoin_card_4,\t1");
         this.payGift[7].push("materials,\tsuperalloy_Z,\t10");
         this.payGift[7].push("materials,\tgreen_chip,\t\t5");
         this.payGift[7].push("props,\t\tlife_capsule,\t1");
         this.payGift[7].push("props,\t\tdefence_capsule,1");
         this.payGift[7].push("crystal,\t5,\t\t\t\t2");
         this.payGift[8].push("props,\t\trebirth_crystal,10");
         this.payGift[8].push("materials,\tsuperalloy,\t\t200");
         this.payGift[8].push("props,\t\tGCoin_card_4,\t2");
         this.payGift[8].push("materials,\tsuperalloy_Z,\t50");
         this.payGift[8].push("materials,\tgreen_chip,\t\t10");
         this.payGift[8].push("props,\t\tlife_capsule,\t2");
         this.payGift[8].push("props,\t\tdefence_capsule,2");
         this.payGift[8].push("crystal,\t6,\t\t\t\t2");
         this.payGift[9].push("props,\t\trebirth_crystal,10");
         this.payGift[9].push("materials,\tsuperalloy,\t\t200");
         this.payGift[9].push("props,\t\tGCoin_card_4,\t2");
         this.payGift[9].push("materials,\tsuperalloy_Z,\t50");
         this.payGift[9].push("materials,\tgreen_chip,\t\t10");
         this.payGift[9].push("props,\t\tlife_capsule,\t2");
         this.payGift[9].push("props,\t\tdefence_capsule,2");
         this.payGift[9].push("crystal,\t6,\t\t\t\t2");
         this.payGift[10].push("props,\t\trebirth_crystal,10");
         this.payGift[10].push("materials,\tsuperalloy,\t\t200");
         this.payGift[10].push("props,\t\tGCoin_card_4,\t2");
         this.payGift[10].push("materials,\tsuperalloy_Z,\t50");
         this.payGift[10].push("materials,\tgreen_chip,\t\t10");
         this.payGift[10].push("props,\t\tlife_capsule,\t2");
         this.payGift[10].push("props,\t\tdefence_capsule,2");
         this.payGift[10].push("crystal,\t\t6,\t\t\t\t2");
         this.payGift[11].push("props,\t\trebirth_crystal,10");
         this.payGift[11].push("materials,\tsuperalloy,\t\t200");
         this.payGift[11].push("props,\t\tGCoin_card_4,\t2");
         this.payGift[11].push("materials,\tsuperalloy_Z,\t50");
         this.payGift[11].push("materials,\tgreen_chip,\t\t10");
         this.payGift[11].push("props,\t\tlife_capsule,\t2");
         this.payGift[11].push("props,\t\tdefence_capsule,2");
         this.payGift[11].push("crystal,\t\t6,\t\t\t\t2");
         var _loc2_:int = 12;
         this.payGift[_loc2_].push("props,\t\trebirth_crystal,10");
         _loc2_ = 13;
         this.payGift[_loc2_].push("props,\t\trebirth_crystal,10");
         this.payGift[_loc2_].push("materials,\tsuperalloy,\t\t200");
         this.payGift[_loc2_].push("props,\t\tGCoin_card_4,\t5");
         this.payGift[_loc2_].push("materials,\tsuperalloy_Z,\t50");
         this.payGift[_loc2_].push("materials,\tgreen_chip,\t\t10");
         this.payGift[_loc2_].push("props,\t\tlife_capsule,\t2");
         this.payGift[_loc2_].push("props,\t\tdefence_capsule,2");
         this.payGift[_loc2_].push("crystal,\t6,\t\t\t\t2");
         _loc2_ = 14;
         this.payGift[_loc2_].push("props,\t\trebirth_crystal,20");
         this.payGift[_loc2_].push("materials,\tsuperalloy,\t\t300");
         this.payGift[_loc2_].push("props,\t\tGCoin_card_4,\t6");
         this.payGift[_loc2_].push("materials,\tsuperalloy_Z,\t75");
         this.payGift[_loc2_].push("materials,\tgreen_chip,\t\t20");
         this.payGift[_loc2_].push("props,\t\tlife_capsule,\t3");
         this.payGift[_loc2_].push("props,\t\tdefence_capsule,3");
         this.payGift[_loc2_].push("crystal,\t7,\t\t\t\t2");
         _loc2_ = 15;
         this.payGift[_loc2_].push("props,\t\trebirth_crystal,20");
         this.payGift[_loc2_].push("materials,\tsuperalloy,\t\t300");
         this.payGift[_loc2_].push("props,\t\tGCoin_card_4,\t6");
         this.payGift[_loc2_].push("materials,\tsuperalloy_Z,\t75");
         this.payGift[_loc2_].push("materials,\tgreen_chip,\t\t20");
         this.payGift[_loc2_].push("props,\t\tlife_capsule,\t3");
         this.payGift[_loc2_].push("props,\t\tdefence_capsule,3");
         this.payGift[_loc2_].push("crystal,\t7,\t\t\t\t2");
         _loc2_ = 16;
         this.payGift[_loc2_].push("props,\t\trebirth_crystal,10");
         _loc2_ = 17;
         this.payGift[_loc2_].push("props,\t\trebirth_crystal,20");
         this.payGift[_loc2_].push("materials,\tsuperalloy,\t\t400");
         this.payGift[_loc2_].push("props,\t\tGCoin_card_4,\t6");
         this.payGift[_loc2_].push("materials,\tsuperalloy_Z,\t75");
         this.payGift[_loc2_].push("materials,\tgreen_chip,\t\t20");
         this.payGift[_loc2_].push("props,\t\tlife_capsule,\t3");
         this.payGift[_loc2_].push("props,\t\tdefence_capsule,3");
         this.payGift[_loc2_].push("crystal,\t7,\t\t\t\t2");
         _loc2_ = 18;
         this.payGift[_loc2_].push("props,\t\trebirth_crystal,20");
         this.payGift[_loc2_].push("materials,\tsuperalloy,\t\t400");
         this.payGift[_loc2_].push("props,\t\tGCoin_card_4,\t6");
         this.payGift[_loc2_].push("materials,\tsuperalloy_Z,\t75");
         this.payGift[_loc2_].push("materials,\tgreen_chip,\t\t20");
         this.payGift[_loc2_].push("props,\t\tlife_capsule,\t3");
         this.payGift[_loc2_].push("props,\t\tdefence_capsule,3");
         this.payGift[_loc2_].push("crystal,\t7,\t\t\t\t2");
         _loc2_ = 19;
         this.payGift[_loc2_].push("props,\t\trebirth_crystal,10");
         _loc2_ = 20;
         this.payGift[_loc2_].push("props,\t\trebirth_crystal,50");
         this.payGift[_loc2_].push("materials,\tsuperalloy,\t\t500");
         this.payGift[_loc2_].push("props,\t\tGCoin_card_4,\t10");
         this.payGift[_loc2_].push("materials,\tsuperalloy_Z,\t100");
         this.payGift[_loc2_].push("materials,\tgreen_chip,\t\t50");
         this.payGift[_loc2_].push("props,\t\tlife_capsule,\t5");
         this.payGift[_loc2_].push("props,\t\tdefence_capsule,5");
         this.payGift[_loc2_].push("crystal,\t\t8,\t\t\t\t1");
         this.onePayGift[0].push("props,\t\trebirth_crystal,2");
         this.onePayGift[0].push("props,\t\tGCoin_card_3,\t1");
         this.onePayGift[0].push("crystal,\t5,\t\t\t\t1");
         this.onePayGift[1].push("props,\t\trebirth_crystal,10");
         this.onePayGift[1].push("props,\t\tGCoin_card_4,\t1");
         this.onePayGift[1].push("crystal,\t6,\t\t\t\t1");
         this.onePayGift[2].push("props,\t\trebirth_crystal,10");
         this.onePayGift[2].push("props,\t\tGCoin_card_4,\t2");
         this.onePayGift[2].push("crystal,\t6,\t\t\t\t1");
         this.onePayGift[2].push("props,\t\tlife_capsule,\t1");
         this.onePayGift[3].push("props,\t\trebirth_crystal,10");
         this.onePayGift[3].push("props,\t\tGCoin_card_4,\t4");
         this.onePayGift[3].push("props,\t\tachieve_card_3,\t1");
         this.onePayGift[3].push("crystal,\t6,\t\t\t\t1");
         this.onePayGift[3].push("props,\t\tlife_capsule,\t1");
         this.onePayGift[3].push("props,\t\tdefence_capsule,1");
         this.onePayGift[4].push("props,\t\trebirth_crystal,10");
         this.onePayGift[4].push("props,\t\tGCoin_card_4,\t6");
         this.onePayGift[4].push("props,\t\tachieve_card_3,\t3");
         this.onePayGift[4].push("crystal,\t6,\t\t\t\t1");
         this.onePayGift[4].push("props,\t\tlife_capsule,\t2");
         this.onePayGift[4].push("props,\t\tdefence_capsule,2");
         this.onePayGift[5].push("props,\t\trebirth_crystal,20");
         this.onePayGift[5].push("props,\t\tGCoin_card_4,\t10");
         this.onePayGift[5].push("props,\t\tachieve_card_3,\t10");
         this.onePayGift[5].push("crystal,\t7,\t\t\t\t1");
         this.onePayGift[5].push("props,\t\tlife_capsule,\t4");
         this.onePayGift[5].push("props,\t\tdefence_capsule,4");
         this.douwa_gift.push("GCoin,\t\t\t1000000,\t\t\t\t1");
         this.douwa_gift.push("props,\t\t\texp_card_double,\t\t2");
         this.douwa_gift.push("materials,\t\tbuncher_1,\t\t\t\t100");
         this.douwa_gift.push("materials,\t\tboom_1,\t\t\t\t\t100");
         this.douwa_gift.push("materials,\t\tthorn_1,\t\t\t\t100");
         ExtraDefine.swapToCode(this.douwa_gift);
         this.douwa_gift2.push("GCoin,\t\t20130000,\t\t\t\t1");
         this.douwa_gift2.push("props,\t\texp_card_double,\t\t5");
         this.douwa_gift2.push("props,\t\texp_card_5,\t\t\t\t1");
         this.douwa_gift2.push("sub,\t\t\tbanger_lv1,\t\t\t\t1");
         ExtraDefine.swapToCode(this.douwa_gift2);
         this.douwa_gift3.push("props,\t\trebirth_crystal,\t\t\t4");
         this.douwa_gift3.push("props,\t\texp_card_double,\t\t4");
         ExtraDefine.swapToCode(this.douwa_gift3);
         this.pay29.push("props,\t\tsuperalloyStone,\t\t30");
         this.pay29.push("props,\t\tjustice_badge,\t\t\t30");
         this.pay29.push("props,\t\tGCoin_card_4,\t\t\t5");
         this.pay29.push("props,\t\tachieve_card_3,\t\t10");
         this.pay29.push("props,\t\texp_card_3,\t\t\t10");
         ExtraDefine.swapToCode(this.pay29);
      }
      
      public function getDouwaGift() : Array
      {
         return ExtraDefine.swapToText(this.douwa_gift);
      }
      
      public function getDouwaGift2() : Array
      {
         return ExtraDefine.swapToText(this.douwa_gift2);
      }
      
      public function getDouwaGift3() : Array
      {
         return ExtraDefine.swapToText(this.douwa_gift3);
      }
      
      public function getPay29Gift() : Array
      {
         return ExtraDefine.swapToText(this.pay29);
      }
   }
}

