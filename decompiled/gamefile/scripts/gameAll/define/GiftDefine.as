package gameAll.define
{
   public class GiftDefine
   {
      
      public var oneYuan_arr:Array = [];
      
      public var pay_arr:Array = [10,20,50,100,200,300,400,500,1000,2000,3000,4000,4399,5000,6000,7000,7998,8000,9000,9998,10000,100000];
      
      public var onePay_arr:Array = [100,500,1000,2000,3000,5000];
      
      public var payBagMust:Array = [4,4,6,8,8,8,8,8,13,13,13,13,0,13,23,23,-1,23,23,-2,53,8];
      
      public var payGift:Array = [];
      
      public var onePayGift:Array = [];
      
      public var douwa_gift:Array = [];
      
      public var douwa_gift2:Array = [];
      
      public var douwa_gift3:Array = [];
      
      public var pay10:Array = [];
      
      public var gift10:Array = [];
      
      public var gift11:Array = [];
      
      public function GiftDefine()
      {
         super();
         this.oneYuan_arr.push("materials,\tsuperalloy_X,\t\t5");
         this.oneYuan_arr.push("props,\t\trebirth_crystal,1");
         this.oneYuan_arr.push("props,\t\texp_card_double,1");
         this.oneYuan_arr.push("props,\t\tGCoin_card_3,\t1");
         var i:int = 0;
         while(i < 100)
         {
            this.payGift[i] = new Array();
            this.onePayGift[i] = new Array();
            i++;
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
         var num0:int = 12;
         this.payGift[num0].push("props,\t\trebirth_crystal,10");
         num0 = 13;
         this.payGift[num0].push("props,\t\trebirth_crystal,10");
         this.payGift[num0].push("materials,\tsuperalloy,\t\t200");
         this.payGift[num0].push("props,\t\tGCoin_card_4,\t5");
         this.payGift[num0].push("materials,\tsuperalloy_Z,\t50");
         this.payGift[num0].push("materials,\tgreen_chip,\t\t10");
         this.payGift[num0].push("props,\t\tlife_capsule,\t2");
         this.payGift[num0].push("props,\t\tdefence_capsule,2");
         this.payGift[num0].push("crystal,\t6,\t\t\t\t2");
         num0 = 14;
         this.payGift[num0].push("props,\t\trebirth_crystal,20");
         this.payGift[num0].push("materials,\tsuperalloy,\t\t300");
         this.payGift[num0].push("props,\t\tGCoin_card_4,\t6");
         this.payGift[num0].push("materials,\tsuperalloy_Z,\t75");
         this.payGift[num0].push("materials,\tgreen_chip,\t\t20");
         this.payGift[num0].push("props,\t\tlife_capsule,\t3");
         this.payGift[num0].push("props,\t\tdefence_capsule,3");
         this.payGift[num0].push("crystal,\t7,\t\t\t\t2");
         num0 = 15;
         this.payGift[num0].push("props,\t\trebirth_crystal,20");
         this.payGift[num0].push("materials,\tsuperalloy,\t\t300");
         this.payGift[num0].push("props,\t\tGCoin_card_4,\t6");
         this.payGift[num0].push("materials,\tsuperalloy_Z,\t75");
         this.payGift[num0].push("materials,\tgreen_chip,\t\t20");
         this.payGift[num0].push("props,\t\tlife_capsule,\t3");
         this.payGift[num0].push("props,\t\tdefence_capsule,3");
         this.payGift[num0].push("crystal,\t7,\t\t\t\t2");
         num0 = 16;
         this.payGift[num0].push("props,\t\trebirth_crystal,10");
         num0 = 17;
         this.payGift[num0].push("props,\t\trebirth_crystal,20");
         this.payGift[num0].push("materials,\tsuperalloy,\t\t400");
         this.payGift[num0].push("props,\t\tGCoin_card_4,\t6");
         this.payGift[num0].push("materials,\tsuperalloy_Z,\t75");
         this.payGift[num0].push("materials,\tgreen_chip,\t\t20");
         this.payGift[num0].push("props,\t\tlife_capsule,\t3");
         this.payGift[num0].push("props,\t\tdefence_capsule,3");
         this.payGift[num0].push("crystal,\t7,\t\t\t\t2");
         num0 = 18;
         this.payGift[num0].push("props,\t\trebirth_crystal,20");
         this.payGift[num0].push("materials,\tsuperalloy,\t\t400");
         this.payGift[num0].push("props,\t\tGCoin_card_4,\t6");
         this.payGift[num0].push("materials,\tsuperalloy_Z,\t75");
         this.payGift[num0].push("materials,\tgreen_chip,\t\t20");
         this.payGift[num0].push("props,\t\tlife_capsule,\t3");
         this.payGift[num0].push("props,\t\tdefence_capsule,3");
         this.payGift[num0].push("crystal,\t7,\t\t\t\t2");
         num0 = 19;
         this.payGift[num0].push("props,\t\trebirth_crystal,10");
         num0 = 20;
         this.payGift[num0].push("props,\t\trebirth_crystal,50");
         this.payGift[num0].push("materials,\tsuperalloy,\t\t500");
         this.payGift[num0].push("props,\t\tGCoin_card_4,\t10");
         this.payGift[num0].push("materials,\tsuperalloy_Z,\t100");
         this.payGift[num0].push("materials,\tgreen_chip,\t\t50");
         this.payGift[num0].push("props,\t\tlife_capsule,\t5");
         this.payGift[num0].push("props,\t\tdefence_capsule,5");
         this.payGift[num0].push("crystal,\t\t8,\t\t\t\t1");
         this.configureEarnedMCoinGifts();
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
         this.douwa_gift2.push("GCoin,\t\t5000000,\t\t\t\t1");
         this.douwa_gift2.push("materials,\tred_crystal_7,\t\t\t2");
         this.douwa_gift2.push("materials,\ttuzhi_zhuanyipao2,\t\t1");
         this.douwa_gift2.push("materials,\tgreen_chip,\t\t\t\t5");
         ExtraDefine.swapToCode(this.douwa_gift2);
         this.douwa_gift3.push("props,\t\trebirth_crystal,\t\t\t4");
         this.douwa_gift3.push("props,\t\texp_card_double,\t\t4");
         ExtraDefine.swapToCode(this.douwa_gift3);
         this.pay10.push("GCoin,\t\t2000000,\t\t\t\t\t1");
         this.pay10.push("materials,\t\tred_crystal_7,\t\t\t1");
         this.pay10.push("materials,\t\tyellow_crystal_7,\t\t\t1");
         this.pay10.push("materials,\t\tgreen_crystal_7,\t\t\t1");
         this.pay10.push("materials,\t\tpurple_crystal_7,\t\t\t1");
         ExtraDefine.swapToCode(this.pay10);
         this.gift10.push("GCoin,\t\t\t2000000,\t\t\t\t1");
         this.gift10.push("materials,\tsuperalloy,\t\t\t100");
         this.gift10.push("props,\t\trebirth_crystal,\t\t\t5");
         ExtraDefine.swapToCode(this.gift10);
         this.gift11.push("props,\t\tdisassemble,\t\t10");
         this.gift11.push("props,\t\texp_card_double,\t10");
         this.gift11.push("props,\t\tGCoin_card_4,\t\t10");
         this.gift11.push("props,\t\tachieve_card_3,\t\t10");
         this.gift11.push("materials,\tgreen_crystal_5,\t2");
         this.gift11.push("materials,\tred_crystal_5,\t\t2");
         this.gift11.push("materials,\tyellow_crystal_5,\t2");
         this.gift11.push("materials,\tpurple_crystal_5,\t2");
         ExtraDefine.swapToCode(this.gift11);
      }
      
      private function configureEarnedMCoinGifts() : void
      {
         var i:int = 0;
         var n:int = 0;
         var factor:Number = 1;
         var threshold:int = 0;
         var source:Array = null;
         var parts:Array = null;
         while(i < 21)
         {
            threshold = int(this.pay_arr[i]);
            factor = threshold < 1000 ? 1.5 : (threshold < 10000 ? 2 : 3);
            n = 0;
            while(n < this.payGift[i].length)
            {
               this.payGift[i][n] = this.multiplyGiftCount(String(this.payGift[i][n]),factor);
               n++;
            }
            i++;
         }
         source = this.payGift[20];
         this.payGift[21] = [];
         n = 0;
         while(n < source.length)
         {
            parts = String(source[n]).split(",");
            factor = parts.length > 1 && String(parts[1]).indexOf("superalloy") >= 0 ? 10 : 5;
            this.payGift[21].push(this.multiplyGiftCount(String(source[n]),factor));
            n++;
         }
      }
      
      private function multiplyGiftCount(value:String, factor:Number) : String
      {
         var parts:Array = value.split(",");
         if(parts.length >= 3)
         {
            parts[2] = String(Math.max(1,Math.round(Number(parts[2]) * factor)));
         }
         return parts.join(",");
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
      
      public function getPay10() : Array
      {
         return ExtraDefine.swapToText(this.pay10);
      }
      
      public function getGift10() : Array
      {
         return ExtraDefine.swapToText(this.gift10);
      }
      
      public function getOldGift() : Array
      {
         return ExtraDefine.swapToText(this.gift11);
      }
   }
}

