package gameAll.define.other
{
   import gameAll.define.ExtraDefine;
   
   public class DailySignDefine
   {
      
      private var _mustNum:Array = [2,5,10,17,26];
      
      public var allGift:Array = [];
      
      public var vipGift:Array = [];
      
      public function DailySignDefine()
      {
         super();
         var _loc1_:Array = [];
         _loc1_ = [];
         _loc1_.push("props,\t\trebirth_crystal,\t2");
         _loc1_.push("props,\t\texp_card_double,\t1");
         _loc1_.push("GCoin,\t\t200000,\t\t\t\t1");
         _loc1_.push("materials,\tsuperalloy_X,\t\t20");
         this.allGift.push(_loc1_);
         _loc1_ = [];
         _loc1_.push("props,\t\trebirth_crystal,\t5");
         _loc1_.push("props,\t\texp_card_double,\t2");
         _loc1_.push("GCoin,\t\t500000,\t\t\t\t1");
         _loc1_.push("materials,\tsuperalloy_X,\t\t50");
         this.allGift.push(_loc1_);
         _loc1_ = [];
         _loc1_.push("props,\t\trebirth_crystal,\t10");
         _loc1_.push("props,\t\texp_card_double,\t4");
         _loc1_.push("GCoin,\t\t1000000,\t\t\t\t1");
         _loc1_.push("materials,\tsuperalloy_X,\t\t100");
         this.allGift.push(_loc1_);
         _loc1_ = [];
         _loc1_.push("props,\t\trebirth_crystal,\t17");
         _loc1_.push("props,\t\texp_card_double,\t8");
         _loc1_.push("GCoin,\t\t1700000,\t\t\t\t1");
         _loc1_.push("materials,\tsuperalloy_X,\t\t170");
         this.allGift.push(_loc1_);
         _loc1_ = [];
         _loc1_.push("props,\t\trebirth_crystal,\t26");
         _loc1_.push("props,\t\texp_card_double,\t16");
         _loc1_.push("GCoin,\t\t2600000,\t\t\t1");
         _loc1_.push("materials,\tsuperalloy_X,\t\t260");
         this.allGift.push(_loc1_);
         _loc1_ = [];
         _loc1_.push("achieve,\t\t2000,\t1");
         this.vipGift.push(_loc1_);
         _loc1_ = [];
         _loc1_.push("achieve,\t\t5000,\t1");
         this.vipGift.push(_loc1_);
         _loc1_ = [];
         _loc1_.push("achieve,\t\t10000,\t1");
         this.vipGift.push(_loc1_);
         _loc1_ = [];
         _loc1_.push("achieve,\t\t17000,\t1");
         this.vipGift.push(_loc1_);
         _loc1_ = [];
         _loc1_.push("achieve,\t\t26000,\t1");
         this.vipGift.push(_loc1_);
         ExtraDefine.swapToCode2(this.allGift);
         ExtraDefine.swapToCode2(this.vipGift);
         ExtraDefine.swapToCode(this._mustNum);
      }
      
      public function getMustNum() : Array
      {
         return ExtraDefine.swapToNumber(this._mustNum);
      }
      
      public function getGift_byIndex(param1:int) : *
      {
         return ExtraDefine.swapToText(this.allGift[param1]);
      }
      
      public function getVipGift_byIndex(param1:int) : *
      {
         return ExtraDefine.swapToText(this.vipGift[param1]);
      }
   }
}

