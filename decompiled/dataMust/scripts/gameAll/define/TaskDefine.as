package gameAll.define
{
   import data.TextWay;
   import gameAll.data.challenge.ChallengeTaskDefine;
   import gameAll.data.collect.CollectTaskDefine;
   
   public class TaskDefine
   {
      
      public var Exp_arr:Array;
      
      public var GCoin_arr:Array;
      
      public var Exp_arr2:Array;
      
      public var GCoin_arr2:Array;
      
      public var challengeArr:Array;
      
      public var collectArr:Array;
      
      public var weekArr:Array;
      
      public var weekMustM:String = "";
      
      public function TaskDefine()
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         var _loc3_:int = 0;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:String = null;
         var _loc7_:ChallengeTaskDefine = null;
         var _loc8_:* = undefined;
         var _loc9_:String = null;
         this.Exp_arr = [1000,2000,4000,6000,8000,10000,12000,14000,16000,20000,24000,28000,32000,36000,40000,44000,48000,52000,56000,60000,64000,68000,72000,76000,80000,85000,90000,95000,100000,105000,110000,115000,120000,125000,130000,135000,140000,145000,150000,160000,170000,180000,190000,200000,210000,220000,230000,240000,250000,260000,270000,280000,290000,300000,310000,320000,330000,340000,350000,360000];
         this.GCoin_arr = [1000,1500,2000,2500,3000,3500,4000,4500,5000,6000,7000,8000,9000,10000,11000,12000,13000,14000,15000,16000,17000,18000,19000,20000,21000,22000,23000,24000,25000,26000,27000,28000,29000,30000,31000,32000,33000,34000,35000,36000,37000,38000,39000,40000,41000,42000,43000,44000,45000,46000,47000,48000,49000,50000,51000,52000,53000,54000,55000,56000];
         this.Exp_arr2 = [];
         this.GCoin_arr2 = [];
         this.challengeArr = [];
         this.collectArr = [];
         this.weekArr = [];
         super();
         this.Exp_arr = this.Exp_arr.concat([310000,320000,330000,340000,350000,400000,450000,500000,550000,600000,650000,700000,750000,800000,850000,900000]);
         this.GCoin_arr = this.GCoin_arr.concat([51000,52000,53000,54000,55000,100000,110000,120000,130000,140000,150000,160000,170000,180000,190000,200000]);
         for(_loc1_ in this.GCoin_arr)
         {
            this.GCoin_arr2.push(TextWay.toCode(String(this.GCoin_arr[_loc1_])));
         }
         for(_loc2_ in this.Exp_arr)
         {
            this.Exp_arr2.push(TextWay.toCode(String(this.Exp_arr[_loc2_])));
         }
         _loc3_ = 0;
         this.challengeArr[_loc3_] = new ChallengeTaskDefine();
         this.challengeArr[_loc3_].index = _loc3_;
         this.challengeArr[_loc3_].inData_byStr("碾压者,\t\t3,\t\t6,\t\t0,\t\t1");
         this.challengeArr[_loc3_].giftArr.push("achieve,\t\t100,\t\t\t\t1");
         this.challengeArr[_loc3_].giftArr.push("GCoin,\t\t\t100000,\t\t\t\t1");
         this.challengeArr[_loc3_].giftArr.push("green_chip,\t55,\t\t\t\t\t1");
         this.challengeArr[_loc3_].giftArr.push("red_crystal,\t5,\t\t\t\t\t1");
         _loc3_ = 1;
         this.challengeArr[_loc3_] = new ChallengeTaskDefine();
         this.challengeArr[_loc3_].index = _loc3_;
         this.challengeArr[_loc3_].inData_byStr("仲裁者,\t\t3,\t\t13,\t\t0,\t\t1");
         this.challengeArr[_loc3_].giftArr.push("achieve,\t\t120,\t\t\t\t1");
         this.challengeArr[_loc3_].giftArr.push("GCoin,\t\t\t120000,\t\t\t\t1");
         this.challengeArr[_loc3_].giftArr.push("green_chip,\t56,\t\t\t\t\t1");
         this.challengeArr[_loc3_].giftArr.push("red_crystal,\t5,\t\t\t\t\t1");
         _loc3_ = 2;
         this.challengeArr[_loc3_] = new ChallengeTaskDefine();
         this.challengeArr[_loc3_].index = _loc3_;
         this.challengeArr[_loc3_].inData_byStr("剑装审判者,\t\t3,\t\t21,\t\t0,\t\t1");
         this.challengeArr[_loc3_].giftArr.push("achieve,\t\t120,\t\t\t\t1");
         this.challengeArr[_loc3_].giftArr.push("GCoin,\t\t\t120000,\t\t\t\t1");
         this.challengeArr[_loc3_].giftArr.push("green_chip,\t61,\t\t\t\t\t1");
         this.challengeArr[_loc3_].giftArr.push("red_crystal,\t5,\t\t\t\t\t1");
         _loc3_ = 3;
         this.challengeArr[_loc3_] = new ChallengeTaskDefine();
         this.challengeArr[_loc3_].index = _loc3_;
         this.challengeArr[_loc3_].inData_byStr("炮装审判者,\t\t3,\t\t28,\t\t0,\t\t1");
         this.challengeArr[_loc3_].giftArr.push("achieve,\t\t140,\t\t\t\t1");
         this.challengeArr[_loc3_].giftArr.push("GCoin,\t\t\t140000,\t\t\t\t1");
         this.challengeArr[_loc3_].giftArr.push("green_chip,\t61,\t\t\t\t\t1");
         this.challengeArr[_loc3_].giftArr.push("red_crystal,\t5,\t\t\t\t\t1");
         _loc3_ = 4;
         this.challengeArr[_loc3_] = new ChallengeTaskDefine();
         this.challengeArr[_loc3_].index = _loc3_;
         this.challengeArr[_loc3_].inData_byStr("判决者,\t\t3,\t\t30,\t\t0,\t\t1");
         this.challengeArr[_loc3_].giftArr.push("achieve,\t\t140,\t\t\t\t1");
         this.challengeArr[_loc3_].giftArr.push("GCoin,\t\t\t140000,\t\t\t\t1");
         this.challengeArr[_loc3_].giftArr.push("green_chip,\t61,\t\t\t\t\t1");
         this.challengeArr[_loc3_].giftArr.push("red_crystal,\t5,\t\t\t\t\t1");
         _loc3_ = 5;
         this.challengeArr[_loc3_] = new ChallengeTaskDefine();
         this.challengeArr[_loc3_].index = _loc3_;
         this.challengeArr[_loc3_].inData_byStr("入侵者飞艇,\t11,\t\t1,\t\t0,\t\t1");
         this.challengeArr[_loc3_].giftArr.push("achieve,\t\t180,\t\t\t\t1");
         this.challengeArr[_loc3_].giftArr.push("GCoin,\t\t\t200000,\t\t\t\t1");
         this.challengeArr[_loc3_].giftArr.push("green_chip,\t71,\t\t\t\t\t1");
         this.challengeArr[_loc3_].giftArr.push("red_crystal,\t6,\t\t\t\t\t1");
         _loc3_ = 6;
         this.challengeArr[_loc3_] = new ChallengeTaskDefine();
         this.challengeArr[_loc3_].index = _loc3_;
         this.challengeArr[_loc3_].inData_byStr("暴君,\t11,\t\t4,\t\t0,\t\t1");
         this.challengeArr[_loc3_].giftArr.push("achieve,\t\t180,\t\t\t\t1");
         this.challengeArr[_loc3_].giftArr.push("GCoin,\t\t\t200000,\t\t\t\t1");
         this.challengeArr[_loc3_].giftArr.push("green_chip,\t71,\t\t\t\t\t1");
         this.challengeArr[_loc3_].giftArr.push("red_crystal,\t6,\t\t\t\t\t1");
         _loc3_ = 7;
         this.challengeArr[_loc3_] = new ChallengeTaskDefine();
         this.challengeArr[_loc3_].index = _loc3_;
         this.challengeArr[_loc3_].inData_byStr("掠食者,\t11,\t\t7,\t\t0,\t\t1");
         this.challengeArr[_loc3_].giftArr.push("achieve,\t\t200,\t\t\t\t1");
         this.challengeArr[_loc3_].giftArr.push("GCoin,\t\t\t200000,\t\t\t\t1");
         this.challengeArr[_loc3_].giftArr.push("green_chip,\t74,\t\t\t\t\t1");
         this.challengeArr[_loc3_].giftArr.push("red_crystal,\t6,\t\t\t\t\t1");
         _loc3_ = 8;
         this.challengeArr[_loc3_] = new ChallengeTaskDefine();
         this.challengeArr[_loc3_].index = _loc3_;
         this.challengeArr[_loc3_].inData_byStr("机械路霸,\t11,\t\t8,\t\t0,\t\t1");
         this.challengeArr[_loc3_].giftArr.push("achieve,\t\t200,\t\t\t\t1");
         this.challengeArr[_loc3_].giftArr.push("GCoin,\t\t\t200000,\t\t\t\t1");
         this.challengeArr[_loc3_].giftArr.push("green_chip,\t74,\t\t\t\t\t1");
         this.challengeArr[_loc3_].giftArr.push("red_crystal,\t6,\t\t\t\t\t1");
         _loc3_ = 9;
         this.challengeArr[_loc3_] = new ChallengeTaskDefine();
         this.challengeArr[_loc3_].index = _loc3_;
         this.challengeArr[_loc3_].inData_byStr("黑暗之刃,\t11,\t\t9,\t\t0,\t\t1");
         this.challengeArr[_loc3_].giftArr.push("achieve,\t\t300,\t\t\t\t1");
         this.challengeArr[_loc3_].giftArr.push("GCoin,\t\t\t300000,\t\t\t\t1");
         this.challengeArr[_loc3_].giftArr.push("green_chip,\t75,\t\t\t\t\t1");
         this.challengeArr[_loc3_].giftArr.push("red_crystal,\t6,\t\t\t\t\t1");
         for(_loc4_ in this.challengeArr)
         {
            _loc7_ = this.challengeArr[_loc4_];
            for(_loc8_ in _loc7_.giftArr)
            {
               _loc9_ = _loc7_.giftArr[_loc8_];
               _loc7_.giftArr[_loc8_] = TextWay.toCode(_loc9_);
            }
         }
         _loc3_ = 0;
         this.collectArr[_loc3_] = new CollectTaskDefine();
         this.collectArr[_loc3_].index = _loc3_;
         this.collectArr[_loc3_].inData_byStr("arms_fragment,\t\t200,\t武器碎片");
         this.collectArr[_loc3_].giftArr.push("exp,\t\t200000,\t\t\t\t1");
         this.collectArr[_loc3_].giftArr.push("GCoin,\t\t\t100000,\t\t\t\t1");
         this.collectArr[_loc3_].giftArr.push("props,\t\tjustice_badge,\t\t\t\t1");
         _loc3_ = 1;
         this.collectArr[_loc3_] = new CollectTaskDefine();
         this.collectArr[_loc3_].index = _loc3_;
         this.collectArr[_loc3_].inData_byStr("shell_fragment,\t\t200,\t装甲碎片");
         this.collectArr[_loc3_].giftArr.push("exp,\t\t200000,\t\t\t\t1");
         this.collectArr[_loc3_].giftArr.push("GCoin,\t\t\t100000,\t\t\t\t1");
         this.collectArr[_loc3_].giftArr.push("props,\t\tjustice_badge,\t\t\t\t1");
         _loc3_ = 2;
         this.collectArr[_loc3_] = new CollectTaskDefine();
         this.collectArr[_loc3_].index = _loc3_;
         this.collectArr[_loc3_].inData_byStr("heart_fragment,\t\t200,\t核心碎片");
         this.collectArr[_loc3_].giftArr.push("exp,\t\t200000,\t\t\t\t1");
         this.collectArr[_loc3_].giftArr.push("GCoin,\t\t\t100000,\t\t\t\t1");
         this.collectArr[_loc3_].giftArr.push("props,\t\tjustice_badge,\t\t\t\t1");
         for(_loc4_ in this.collectArr)
         {
            _loc5_ = this.collectArr[_loc4_];
            for(_loc8_ in _loc5_.giftArr)
            {
               _loc6_ = _loc5_.giftArr[_loc8_];
               _loc5_.giftArr[_loc8_] = TextWay.toCode(_loc6_);
            }
         }
         _loc3_ = 0;
         this.weekArr[_loc3_] = new CollectTaskDefine();
         this.weekArr[_loc3_].index = _loc3_;
         this.weekArr[_loc3_].inData_byStr("enemy_1_29,\t\t3000,\t大战在即（1级）");
         this.weekArr[_loc3_].giftArr.push("exp,\t\t1000000,\t\t\t\t1");
         this.weekArr[_loc3_].giftArr.push("achieve,\t\t5000,\t\t\t\t1");
         this.weekArr[_loc3_].giftArr.push("props,\t\tchipBag20,\t\t\t\t1");
         _loc3_ = 1;
         this.weekArr[_loc3_] = new CollectTaskDefine();
         this.weekArr[_loc3_].index = _loc3_;
         this.weekArr[_loc3_].inData_byStr("enemy_30_59,\t\t3000,\t大战在即（2级）");
         this.weekArr[_loc3_].giftArr.push("exp,\t\t1000000,\t\t\t\t1");
         this.weekArr[_loc3_].giftArr.push("achieve,\t\t5000,\t\t\t\t1");
         this.weekArr[_loc3_].giftArr.push("props,\t\tchipBag40,\t\t\t\t2");
         _loc3_ = 2;
         this.weekArr[_loc3_] = new CollectTaskDefine();
         this.weekArr[_loc3_].index = _loc3_;
         this.weekArr[_loc3_].inData_byStr("enemy_60_79,\t\t3000,\t大战在即（3级）");
         this.weekArr[_loc3_].giftArr.push("exp,\t\t1000000,\t\t\t\t1");
         this.weekArr[_loc3_].giftArr.push("achieve,\t\t5000,\t\t\t\t1");
         this.weekArr[_loc3_].giftArr.push("props,\t\tchipBag60,\t\t\t\t3");
         _loc3_ = 3;
         this.weekArr[_loc3_] = new CollectTaskDefine();
         this.weekArr[_loc3_].index = _loc3_;
         this.weekArr[_loc3_].inData_byStr("enemy_80_100,\t\t3000,\t大战在即（4级）");
         this.weekArr[_loc3_].giftArr.push("exp,\t\t1000000,\t\t\t\t1");
         this.weekArr[_loc3_].giftArr.push("achieve,\t\t5000,\t\t\t\t1");
         this.weekArr[_loc3_].giftArr.push("props,\t\tchipBag80,\t\t\t\t4");
         for(_loc4_ in this.weekArr)
         {
            _loc5_ = this.weekArr[_loc4_];
            for(_loc8_ in _loc5_.giftArr)
            {
               _loc6_ = _loc5_.giftArr[_loc8_];
               _loc5_.giftArr[_loc8_] = TextWay.toCode(_loc6_);
            }
         }
         this.weekMustM = TextWay.toCode("50");
      }
      
      public function getGCoin(param1:int) : int
      {
         if(param1 < 0)
         {
            param1 = 0;
         }
         if(param1 > this.GCoin_arr2.length - 1)
         {
            param1 = this.GCoin_arr2.length - 1;
         }
         return int(TextWay.getText(this.GCoin_arr2[param1]));
      }
      
      public function getTaskExp(param1:int) : int
      {
         if(param1 < 0)
         {
            param1 = 0;
         }
         if(param1 > this.Exp_arr2.length - 1)
         {
            param1 = this.Exp_arr2.length - 1;
         }
         return int(TextWay.getText(this.Exp_arr2[param1]));
      }
   }
}

