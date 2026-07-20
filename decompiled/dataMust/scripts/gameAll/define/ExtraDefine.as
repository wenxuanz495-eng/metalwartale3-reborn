package gameAll.define
{
   import data.TextWay;
   import gameAll.NormalMustDefine;
   
   public class ExtraDefine
   {
      
      public var giftArr0:Array = [];
      
      public var giftArr1:Array = [];
      
      public var lifeArr:Array = [100000,200000,500000,800000,1200000,2000000,4000000,6000000,10000000,25000000,30000000,40000000];
      
      public var hurtArr:Array = [800,1500,3000,6000,9000,30000,50000,80000,150000,300000,400000,500000,1000,1000,1000];
      
      public var levelArr:Array = [10,15,20,25,30,35,40,45,50,50,55,60,999,999,999,999];
      
      public function ExtraDefine()
      {
         super();
         var _loc1_:int = 0;
         while(_loc1_ < 100)
         {
            this.giftArr0[_loc1_] = new Array();
            this.giftArr1[_loc1_] = new Array();
            _loc1_++;
         }
         var _loc2_:int = 0;
         this.giftArr0[_loc2_].push("exp,\t\t100000,\t\t\t1");
         this.giftArr0[_loc2_].push("GCoin,\t\t50000,\t\t\t1");
         this.giftArr0[_loc2_].push("achieve,\t30,\t\t\t\t1");
         this.giftArr0[_loc2_].push("random_1,\t30,\t\t\t\t30");
         this.giftArr0[_loc2_].push("crystal_3,\t1,\t\t\t\t1");
         _loc2_ = 1;
         this.giftArr0[_loc2_].push("exp,\t\t120000,\t\t\t1");
         this.giftArr0[_loc2_].push("GCoin,\t\t100000,\t\t\t1");
         this.giftArr0[_loc2_].push("achieve,\t30,\t\t\t\t1");
         this.giftArr0[_loc2_].push("random_1,\t40,\t\t\t\t40");
         this.giftArr0[_loc2_].push("crystal_3,\t1,\t\t\t\t1");
         _loc2_ = 2;
         this.giftArr0[_loc2_].push("exp,\t\t150000,\t\t\t1");
         this.giftArr0[_loc2_].push("GCoin,\t\t150000,\t\t\t1");
         this.giftArr0[_loc2_].push("achieve,\t50,\t\t\t\t1");
         this.giftArr0[_loc2_].push("random_2,\t45,\t\t\t\t45");
         this.giftArr0[_loc2_].push("crystal_3,\t1,\t\t\t\t1");
         _loc2_ = 3;
         this.giftArr0[_loc2_].push("exp,\t\t200000,\t\t\t1");
         this.giftArr0[_loc2_].push("GCoin,\t\t200000,\t\t\t1");
         this.giftArr0[_loc2_].push("achieve,\t60,\t\t\t\t1");
         this.giftArr0[_loc2_].push("random_2,\t45,\t\t\t\t45");
         this.giftArr0[_loc2_].push("crystal_3,\t1,\t\t\t\t1");
         _loc2_ = 4;
         this.giftArr0[_loc2_].push("exp,\t\t300000,\t\t\t1");
         this.giftArr0[_loc2_].push("GCoin,\t\t250000,\t\t\t1");
         this.giftArr0[_loc2_].push("achieve,\t70,\t\t\t\t1");
         this.giftArr0[_loc2_].push("random_2,\t60,\t\t\t\t60");
         this.giftArr0[_loc2_].push("crystal_3,\t1,\t\t\t\t1");
         _loc2_ = 5;
         this.giftArr0[_loc2_].push("exp,\t\t400000,\t\t\t1");
         this.giftArr0[_loc2_].push("GCoin,\t\t300000,\t\t\t1");
         this.giftArr0[_loc2_].push("achieve,\t80,\t\t\t\t1");
         this.giftArr0[_loc2_].push("random_2,\t60,\t\t\t\t60");
         this.giftArr0[_loc2_].push("crystal_4,\t1,\t\t\t\t1");
         _loc2_ = 6;
         this.giftArr0[_loc2_].push("exp,\t\t600000,\t\t\t1");
         this.giftArr0[_loc2_].push("GCoin,\t\t350000,\t\t\t1");
         this.giftArr0[_loc2_].push("achieve,\t90,\t\t\t\t1");
         this.giftArr0[_loc2_].push("random_3,\t80,\t\t\t\t80");
         this.giftArr0[_loc2_].push("crystal_4,\t1,\t\t\t\t1");
         _loc2_ = 7;
         this.giftArr0[_loc2_].push("exp,\t\t800000,\t\t\t1");
         this.giftArr0[_loc2_].push("GCoin,\t\t400000,\t\t\t1");
         this.giftArr0[_loc2_].push("achieve,\t100,\t\t\t1");
         this.giftArr0[_loc2_].push("random_3,\t80,\t\t\t\t80");
         this.giftArr0[_loc2_].push("crystal_4,\t1,\t\t\t\t1");
         _loc2_ = 8;
         this.giftArr0[_loc2_].push("exp,\t\t1000000,\t\t1");
         this.giftArr0[_loc2_].push("GCoin,\t\t450000,\t\t\t1");
         this.giftArr0[_loc2_].push("achieve,\t120,\t\t\t1");
         this.giftArr0[_loc2_].push("random_4,\t80,\t\t\t\t80");
         this.giftArr0[_loc2_].push("crystal_5,\t1,\t\t\t\t1");
         _loc2_ = 9;
         this.giftArr0[_loc2_].push("exp,\t\t1000000,\t\t1");
         this.giftArr0[_loc2_].push("GCoin,\t\t500000,\t\t\t1");
         this.giftArr0[_loc2_].push("achieve,\t150,\t\t\t1");
         this.giftArr0[_loc2_].push("random_4,\t1,\t\t\t\t80");
         this.giftArr0[_loc2_].push("crystal_5,\t1,\t\t\t\t1");
         _loc2_ = 10;
         this.giftArr0[_loc2_].push("exp,\t\t1000000,\t\t1");
         this.giftArr0[_loc2_].push("GCoin,\t\t500000,\t\t\t1");
         this.giftArr0[_loc2_].push("achieve,\t150,\t\t\t1");
         this.giftArr0[_loc2_].push("random_4,\t1,\t\t\t\t80");
         this.giftArr0[_loc2_].push("crystal_5,\t1,\t\t\t\t1");
         _loc2_ = 11;
         this.giftArr0[_loc2_].push("exp,\t\t1200000,\t\t1");
         this.giftArr0[_loc2_].push("GCoin,\t\t600000,\t\t1");
         this.giftArr0[_loc2_].push("achieve,\t180,\t\t\t1");
         this.giftArr0[_loc2_].push("random_5,\t1,\t\t\t\t100");
         this.giftArr0[_loc2_].push("crystal_5,\t1,\t\t\t\t1");
         _loc2_ = 0;
         this.giftArr1[_loc2_].push("exp,\t\t60000,\t\t\t1");
         this.giftArr1[_loc2_].push("GCoin,\t\t20000,\t\t\t1");
         this.giftArr1[_loc2_].push("random_1,\t20,\t\t\t\t20");
         this.giftArr1[_loc2_].push("materials,\torange_chip,\t1");
         _loc2_ = 1;
         this.giftArr1[_loc2_].push("exp,\t\t80000,\t\t\t1");
         this.giftArr1[_loc2_].push("GCoin,\t\t50000,\t\t\t1");
         this.giftArr1[_loc2_].push("random_2,\t20,\t\t\t\t20");
         this.giftArr1[_loc2_].push("materials,\torange_chip,\t1");
         _loc2_ = 2;
         this.giftArr1[_loc2_].push("exp,\t\t84000,\t\t\t1");
         this.giftArr1[_loc2_].push("GCoin,\t\t60000,\t\t\t1");
         this.giftArr1[_loc2_].push("random_2,\t24,\t\t\t\t24");
         this.giftArr1[_loc2_].push("materials,\torange_chip,\t1");
         this.giftArr1[_loc2_].push("crystal,\t4,\t\t\t\t1");
         _loc2_ = 3;
         this.giftArr1[_loc2_].push("exp,\t\t84000,\t\t\t1");
         this.giftArr1[_loc2_].push("GCoin,\t\t60000,\t\t\t1");
         this.giftArr1[_loc2_].push("random_2,\t24,\t\t\t\t24");
         this.giftArr1[_loc2_].push("materials,\torange_chip,\t1");
         this.giftArr1[_loc2_].push("crystal,\t4,\t\t\t\t1");
         _loc2_ = 4;
         this.giftArr1[_loc2_].push("exp,\t\t120000,\t\t\t1");
         this.giftArr1[_loc2_].push("GCoin,\t\t96000,\t\t\t1");
         this.giftArr1[_loc2_].push("random_3,\t24,\t\t\t\t24");
         this.giftArr1[_loc2_].push("materials,\torange_chip,\t1");
         this.giftArr1[_loc2_].push("crystal,\t4,\t\t\t\t1");
         _loc2_ = 5;
         this.giftArr1[_loc2_].push("exp,\t\t120000,\t\t\t1");
         this.giftArr1[_loc2_].push("GCoin,\t\t96000,\t\t\t1");
         this.giftArr1[_loc2_].push("random_3,\t24,\t\t\t\t24");
         this.giftArr1[_loc2_].push("materials,\torange_chip,\t1");
         this.giftArr1[_loc2_].push("crystal,\t4,\t\t\t\t1");
         _loc2_ = 6;
         this.giftArr1[_loc2_].push("GCoin,\t\t100000,\t\t\t1");
         this.giftArr1[_loc2_].push("random_4,\t30,\t\t\t\t30");
         this.giftArr1[_loc2_].push("materials,\tgreen_chip,\t\t1");
         this.giftArr1[_loc2_].push("crystal,\t5,\t\t\t\t1");
         this.giftArr1[_loc2_].push("materials,\tsuperalloy_X,\t4");
         _loc2_ = 7;
         this.giftArr1[_loc2_].push("achieve,\t100,\t\t\t1");
         this.giftArr1[_loc2_].push("GCoin,\t\t120000,\t\t\t1");
         this.giftArr1[_loc2_].push("random_4,\t35,\t\t\t\t35");
         this.giftArr1[_loc2_].push("materials,\tgreen_chip,\t\t1");
         this.giftArr1[_loc2_].push("crystal,\t5,\t\t\t\t1");
         this.giftArr1[_loc2_].push("materials,\tsuperalloy_X,\t4");
         _loc2_ = 8;
         this.giftArr1[_loc2_].push("achieve,\t100,\t\t\t1");
         this.giftArr1[_loc2_].push("GCoin,\t\t150000,\t\t\t1");
         this.giftArr1[_loc2_].push("random_4,\t40,\t\t\t\t40");
         this.giftArr1[_loc2_].push("materials,\tgreen_chip,\t\t1");
         this.giftArr1[_loc2_].push("crystal,\t5,\t\t\t\t1");
         this.giftArr1[_loc2_].push("materials,\tsuperalloy_X,\t4");
         swapToCode2(this.giftArr0);
         swapToCode2(this.giftArr1);
         swapToCode(this.lifeArr);
         swapToCode(this.hurtArr);
      }
      
      public static function swapToCode2(param1:Array) : *
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         for(_loc2_ in param1)
         {
            for(_loc3_ in param1[_loc2_])
            {
               param1[_loc2_][_loc3_] = TextWay.toCode(param1[_loc2_][_loc3_]);
            }
         }
      }
      
      public static function swapToCode(param1:Array) : *
      {
         var _loc2_:* = undefined;
         for(_loc2_ in param1)
         {
            param1[_loc2_] = TextWay.toCode(String(param1[_loc2_]));
         }
      }
      
      public static function swapToText(param1:Array) : Array
      {
         var _loc3_:* = undefined;
         var _loc2_:Array = [];
         for(_loc3_ in param1)
         {
            _loc2_[_loc3_] = TextWay.getText(param1[_loc3_]);
         }
         return _loc2_;
      }
      
      public static function swapToNumber(param1:Array) : Array
      {
         var _loc3_:* = undefined;
         var _loc2_:Array = [];
         for(_loc3_ in param1)
         {
            _loc2_[_loc3_] = Number(TextWay.getText(param1[_loc3_]));
         }
         return _loc2_;
      }
      
      public function getHurt(param1:int, param2:int) : int
      {
         return int(TextWay.getText(this.hurtArr[param2]));
      }
      
      public function getLife(param1:int, param2:int) : int
      {
         return int(TextWay.getText(this.lifeArr[param2]));
      }
      
      public function getMustLevel(param1:int, param2:int) : int
      {
         return this.levelArr[param2] - 1;
      }
      
      public function restart_M() : NormalMustDefine
      {
         var _loc1_:NormalMustDefine = new NormalMustDefine();
         _loc1_.MCoin = 2;
         return _loc1_;
      }
      
      public function getGift(param1:int, param2:int) : Array
      {
         var _loc5_:* = undefined;
         var _loc6_:String = null;
         var _loc7_:int = 0;
         if(param2 > this.giftArr0.length - 1)
         {
            param2 = this.giftArr0.length - 1;
         }
         var _loc3_:Array = this["giftArr" + param1][param2];
         var _loc4_:Array = swapToText(_loc3_);
         for(_loc5_ in _loc4_)
         {
            _loc6_ = _loc4_[_loc5_];
            if(_loc6_.indexOf("exp") >= 0 || _loc6_.indexOf("GCoin") >= 0)
            {
               _loc7_ = int(_loc6_.split(",")[1]) * 1;
               _loc6_ = _loc6_.split(",")[0] + "," + _loc7_ + ",1";
            }
            _loc4_[_loc5_] = _loc6_;
         }
         return _loc4_;
      }
   }
}

