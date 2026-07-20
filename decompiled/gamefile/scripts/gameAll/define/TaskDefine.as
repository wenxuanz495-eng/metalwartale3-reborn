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
         var n:* = undefined;
         var m:* = undefined;
         var num1:int = 0;
         var n2:* = undefined;
         var ca2:* = undefined;
         var str2:String = null;
         var ca0:ChallengeTaskDefine = null;
         var m2:* = undefined;
         var str0:String = null;
         this.Exp_arr = [1000,2000,4000,6000,8000,10000,12000,14000,16000,20000,24000,28000,32000,36000,40000,44000,48000,52000,56000,60000,64000,68000,72000,76000,80000,85000,90000,95000,100000,105000,110000,115000,120000,125000,130000,135000,140000,145000,150000,160000,170000,180000,190000,200000,210000,220000,230000,240000,250000,260000,270000,280000,290000,300000,310000,320000,330000,340000,350000,360000];
         this.GCoin_arr = [1000,1500,2000,2500,3000,3500,4000,4500,5000,6000,7000,8000,9000,10000,11000,12000,13000,14000,15000,16000,17000,18000,19000,20000,21000,22000,23000,24000,25000,26000,27000,28000,29000,30000,31000,32000,33000,34000,35000,36000,37000,38000,39000,40000,41000,42000,43000,44000,45000,46000,47000,48000,49000,50000,51000,52000,53000,54000,55000,56000];
         this.Exp_arr2 = [];
         this.GCoin_arr2 = [];
         this.challengeArr = [];
         this.collectArr = [];
         this.weekArr = [];
         super();
         this.Exp_arr = this.Exp_arr.concat([400000,450000,500000,550000,600000,650000,700000,750000,800000,850000,900000,920000,940000,960000,980000,1000000,1020000,1040000,1060000,1080000,1100000,1120000,1140000,1160000,1180000,1200000,1220000,1240000,1260000,1280000,1300000,1320000,1340000,1360000,1380000,1400000,1420000,1440000,1460000,1480000,1500000,1520000,1540000,1560000,1580000]);
         this.GCoin_arr = this.GCoin_arr.concat([100000,110000,120000,130000,140000,150000,160000,170000,180000,190000,200000,210000,220000,230000,240000,250000,260000,270000,280000,290000,300000,310000,320000,330000,340000,350000,360000,370000,380000,390000,400000,410000,420000,430000,440000,450000,460000,470000,480000,490000,500000,510000,520000,530000,540000]);
         for(n in this.GCoin_arr)
         {
            this.GCoin_arr2.push(TextWay.toCode(String(this.GCoin_arr[n])));
         }
         for(m in this.Exp_arr)
         {
            this.Exp_arr2.push(TextWay.toCode(String(this.Exp_arr[m])));
         }
         num1 = 0;
         this.challengeArr[num1] = new ChallengeTaskDefine();
         this.challengeArr[num1].index = num1;
         this.challengeArr[num1].inData_byStr("仲裁者,3,13,360,1");
         this.challengeArr[num1].giftArr.push("achieve,100,1");
         this.challengeArr[num1].giftArr.push("GCoin,100000,1");
         this.challengeArr[num1].giftArr.push("green_chip,30,1");
         this.challengeArr[num1].giftArr.push("green_crystal,5,1");
         num1 = 1;
         this.challengeArr[num1] = new ChallengeTaskDefine();
         this.challengeArr[num1].index = num1;
         this.challengeArr[num1].inData_byStr("剑装审判者,3,21,360,1");
         this.challengeArr[num1].giftArr.push("achieve,110,1");
         this.challengeArr[num1].giftArr.push("GCoin,120000,1");
         this.challengeArr[num1].giftArr.push("green_chip,40,1");
         this.challengeArr[num1].giftArr.push("yellow_crystal,5,1");
         num1 = 2;
         this.challengeArr[num1] = new ChallengeTaskDefine();
         this.challengeArr[num1].index = num1;
         this.challengeArr[num1].inData_byStr("炮装审判者,3,28,360,1");
         this.challengeArr[num1].giftArr.push("achieve,120,1");
         this.challengeArr[num1].giftArr.push("GCoin,140000,1");
         this.challengeArr[num1].giftArr.push("green_chip,40,1");
         this.challengeArr[num1].giftArr.push("red_crystal,5,1");
         num1 = 3;
         this.challengeArr[num1] = new ChallengeTaskDefine();
         this.challengeArr[num1].index = num1;
         this.challengeArr[num1].inData_byStr("判决者,3,30,360,1");
         this.challengeArr[num1].giftArr.push("achieve,130,1");
         this.challengeArr[num1].giftArr.push("GCoin,160000,1");
         this.challengeArr[num1].giftArr.push("green_chip,50,1");
         this.challengeArr[num1].giftArr.push("green_crystal,5,1");
         num1 = 4;
         this.challengeArr[num1] = new ChallengeTaskDefine();
         this.challengeArr[num1].index = num1;
         this.challengeArr[num1].inData_byStr("先知,7,6,300,1");
         this.challengeArr[num1].giftArr.push("achieve,140,1");
         this.challengeArr[num1].giftArr.push("GCoin,180000,1");
         this.challengeArr[num1].giftArr.push("green_chip,50,1");
         this.challengeArr[num1].giftArr.push("green_crystal,5,1");
         num1 = 5;
         this.challengeArr[num1] = new ChallengeTaskDefine();
         this.challengeArr[num1].index = num1;
         this.challengeArr[num1].inData_byStr("入侵者飞艇,11,1,300,1");
         this.challengeArr[num1].giftArr.push("achieve,150,1");
         this.challengeArr[num1].giftArr.push("GCoin,200000,1");
         this.challengeArr[num1].giftArr.push("green_chip,60,1");
         this.challengeArr[num1].giftArr.push("yellow_crystal,5,1");
         num1 = 6;
         this.challengeArr[num1] = new ChallengeTaskDefine();
         this.challengeArr[num1].index = num1;
         this.challengeArr[num1].inData_byStr("暴君,11,4,240,1");
         this.challengeArr[num1].giftArr.push("achieve,160,1");
         this.challengeArr[num1].giftArr.push("GCoin,220000,1");
         this.challengeArr[num1].giftArr.push("green_chip,60,1");
         this.challengeArr[num1].giftArr.push("red_crystal,5,1");
         num1 = 7;
         this.challengeArr[num1] = new ChallengeTaskDefine();
         this.challengeArr[num1].index = num1;
         this.challengeArr[num1].inData_byStr("掠食者,11,7,240,1");
         this.challengeArr[num1].giftArr.push("achieve,170,1");
         this.challengeArr[num1].giftArr.push("GCoin,240000,1");
         this.challengeArr[num1].giftArr.push("green_chip,70,1");
         this.challengeArr[num1].giftArr.push("green_crystal,5,\t1");
         num1 = 8;
         this.challengeArr[num1] = new ChallengeTaskDefine();
         this.challengeArr[num1].index = num1;
         this.challengeArr[num1].inData_byStr("机械路霸,11,8,180,1");
         this.challengeArr[num1].giftArr.push("achieve,180,1");
         this.challengeArr[num1].giftArr.push("GCoin,260000,1");
         this.challengeArr[num1].giftArr.push("green_chip,70,1");
         this.challengeArr[num1].giftArr.push("yellow_crystal,6,1");
         num1 = 9;
         this.challengeArr[num1] = new ChallengeTaskDefine();
         this.challengeArr[num1].index = num1;
         this.challengeArr[num1].inData_byStr("黑暗之刃,11,9,180,1");
         this.challengeArr[num1].giftArr.push("achieve,190,1");
         this.challengeArr[num1].giftArr.push("GCoin,280000,1");
         this.challengeArr[num1].giftArr.push("green_chip,70,1");
         this.challengeArr[num1].giftArr.push("red_crystal,6,1");
         num1 = 10;
         this.challengeArr[num1] = new ChallengeTaskDefine();
         this.challengeArr[num1].index = num1;
         this.challengeArr[num1].inData_byStr("雷霆,11,11,180,1");
         this.challengeArr[num1].giftArr.push("achieve,200,\t1");
         this.challengeArr[num1].giftArr.push("GCoin,300000,1");
         this.challengeArr[num1].giftArr.push("green_chip,70,1");
         this.challengeArr[num1].giftArr.push("green_crystal,6,1");
         num1 = 11;
         this.challengeArr[num1] = new ChallengeTaskDefine();
         this.challengeArr[num1].index = num1;
         this.challengeArr[num1].inData_byStr("黑暗剑装审判者,11,12,180,1");
         this.challengeArr[num1].giftArr.push("achieve,210,\t1");
         this.challengeArr[num1].giftArr.push("GCoin,320000,1");
         this.challengeArr[num1].giftArr.push("green_chip,70,1");
         this.challengeArr[num1].giftArr.push("yellow_crystal,6,1");
         num1 = 12;
         this.challengeArr[num1] = new ChallengeTaskDefine();
         this.challengeArr[num1].index = num1;
         this.challengeArr[num1].inData_byStr("猛犸战神,11,13,180,1");
         this.challengeArr[num1].giftArr.push("achieve,220,\t1");
         this.challengeArr[num1].giftArr.push("GCoin,340000,1");
         this.challengeArr[num1].giftArr.push("green_chip,80,1");
         this.challengeArr[num1].giftArr.push("red_crystal,6,1");
         num1 = 13;
         this.challengeArr[num1] = new ChallengeTaskDefine();
         this.challengeArr[num1].index = num1;
         this.challengeArr[num1].inData_byStr("风暴战神,11,14,180,1");
         this.challengeArr[num1].giftArr.push("achieve,220,\t1");
         this.challengeArr[num1].giftArr.push("GCoin,340000,1");
         this.challengeArr[num1].giftArr.push("green_chip,80,1");
         this.challengeArr[num1].giftArr.push("red_crystal,6,1");
         num1 = 14;
         this.challengeArr[num1] = new ChallengeTaskDefine();
         this.challengeArr[num1].index = num1;
         this.challengeArr[num1].inData_byStr("机械剑齿虎,11,17,180,1");
         this.challengeArr[num1].giftArr.push("achieve,230,\t1");
         this.challengeArr[num1].giftArr.push("GCoin,360000,1");
         this.challengeArr[num1].giftArr.push("green_chip,90,1");
         this.challengeArr[num1].giftArr.push("green_crystal,6,1");
         num1 = 15;
         this.challengeArr[num1] = new ChallengeTaskDefine();
         this.challengeArr[num1].index = num1;
         this.challengeArr[num1].inData_byStr("凯斯特推土机,11,19,180,1");
         this.challengeArr[num1].giftArr.push("achieve,250,\t1");
         this.challengeArr[num1].giftArr.push("GCoin,400000,1");
         this.challengeArr[num1].giftArr.push("green_chip,100,1");
         this.challengeArr[num1].giftArr.push("yellow_crystal,6,1");
         num1 = 16;
         this.challengeArr[num1] = new ChallengeTaskDefine();
         this.challengeArr[num1].index = num1;
         this.challengeArr[num1].inData_byStr("激光战神苏拉,11,23,180,1");
         this.challengeArr[num1].giftArr.push("achieve,260,\t1");
         this.challengeArr[num1].giftArr.push("GCoin,420000,1");
         this.challengeArr[num1].giftArr.push("green_chip,110,1");
         this.challengeArr[num1].giftArr.push("red_crystal,6,1");
         num1 = 17;
         this.challengeArr[num1] = new ChallengeTaskDefine();
         this.challengeArr[num1].index = num1;
         this.challengeArr[num1].inData_byStr("黑暗先知,11,26,180,1");
         this.challengeArr[num1].giftArr.push("achieve,270,\t1");
         this.challengeArr[num1].giftArr.push("GCoin,440000,1");
         this.challengeArr[num1].giftArr.push("green_chip,110,1");
         this.challengeArr[num1].giftArr.push("green_crystal,6,1");
         for(n2 in this.challengeArr)
         {
            ca0 = this.challengeArr[n2];
            for(m2 in ca0.giftArr)
            {
               str0 = ca0.giftArr[m2];
               ca0.giftArr[m2] = TextWay.toCode(str0);
            }
         }
         num1 = 0;
         this.collectArr[num1] = new CollectTaskDefine();
         this.collectArr[num1].index = num1;
         this.collectArr[num1].inData_byStr("arms_fragment,\t150,\t\t\t武器碎片");
         this.collectArr[num1].giftArr.push("exp,\t\t\t\t1000000,\t\t1");
         this.collectArr[num1].giftArr.push("GCoin,\t\t\t100000,\t\t\t1");
         this.collectArr[num1].giftArr.push("props,\t\t\tjustice_badge,\t1");
         num1 = 1;
         this.collectArr[num1] = new CollectTaskDefine();
         this.collectArr[num1].index = num1;
         this.collectArr[num1].inData_byStr("shell_fragment,\t150,\t\t\t装甲碎片");
         this.collectArr[num1].giftArr.push("exp,\t\t\t\t1000000,\t\t1");
         this.collectArr[num1].giftArr.push("GCoin,\t\t\t100000,\t\t\t1");
         this.collectArr[num1].giftArr.push("props,\t\t\tjustice_badge,\t1");
         num1 = 2;
         this.collectArr[num1] = new CollectTaskDefine();
         this.collectArr[num1].index = num1;
         this.collectArr[num1].inData_byStr("heart_fragment,\t150,\t\t\t核心碎片");
         this.collectArr[num1].giftArr.push("exp,\t\t\t\t1000000,\t\t1");
         this.collectArr[num1].giftArr.push("GCoin,\t\t\t100000,\t\t\t1");
         this.collectArr[num1].giftArr.push("props,\t\t\tjustice_badge,\t1");
         for(n2 in this.collectArr)
         {
            ca2 = this.collectArr[n2];
            for(m2 in ca2.giftArr)
            {
               str2 = ca2.giftArr[m2];
               ca2.giftArr[m2] = TextWay.toCode(str2);
            }
         }
         num1 = 0;
         this.weekArr[num1] = new CollectTaskDefine();
         this.weekArr[num1].index = num1;
         this.weekArr[num1].inData_byStr("enemy_1_40,\t\t\t3000,\t\t扫荡战场（1级）");
         this.weekArr[num1].giftArr.push("exp,\t\t\t2000000,\t\t\t1");
         this.weekArr[num1].giftArr.push("achieve,\t\t5000,\t\t\t\t1");
         this.weekArr[num1].giftArr.push("crystal_4,\t\t1,\t\t\t\t\t3");
         this.weekArr[num1].giftArr.push("props,\t\t\telite_challenge_card,\t1");
         num1 = 1;
         this.weekArr[num1] = new CollectTaskDefine();
         this.weekArr[num1].index = num1;
         this.weekArr[num1].inData_byStr("enemy_41_80,\t\t\t3000,\t\t扫荡战场（2级）");
         this.weekArr[num1].giftArr.push("exp,\t\t\t20000000,\t\t\t1");
         this.weekArr[num1].giftArr.push("achieve,\t\t5000,\t\t\t\t1");
         this.weekArr[num1].giftArr.push("crystal_5,\t\t1,\t\t\t\t\t3");
         this.weekArr[num1].giftArr.push("props,\t\t\telite_challenge_card,\t1");
         num1 = 2;
         this.weekArr[num1] = new CollectTaskDefine();
         this.weekArr[num1].index = num1;
         this.weekArr[num1].inData_byStr("enemy_81_120,\t\t\t3000,\t\t扫荡战场（3级）");
         this.weekArr[num1].giftArr.push("exp,\t\t\t200000000,\t\t\t1");
         this.weekArr[num1].giftArr.push("achieve,\t\t5000,\t\t\t\t1");
         this.weekArr[num1].giftArr.push("crystal_6,\t\t1,\t\t\t\t\t3");
         this.weekArr[num1].giftArr.push("props,\t\t\telite_challenge_card,\t1");
         num1 = 3;
         this.weekArr[num1] = new CollectTaskDefine();
         this.weekArr[num1].index = num1;
         this.weekArr[num1].inData_byStr("enemy_121_160,\t\t\t3000,\t扫荡战场（4级）");
         this.weekArr[num1].giftArr.push("exp,\t\t\t500000000,\t\t\t1");
         this.weekArr[num1].giftArr.push("achieve,\t\t5000,\t\t\t\t1");
         this.weekArr[num1].giftArr.push("crystal_7,\t\t1,\t\t\t\t\t3");
         this.weekArr[num1].giftArr.push("props,\t\t\telite_challenge_card,\t1");
         for(n2 in this.weekArr)
         {
            ca2 = this.weekArr[n2];
            for(m2 in ca2.giftArr)
            {
               str2 = ca2.giftArr[m2];
               ca2.giftArr[m2] = TextWay.toCode(str2);
            }
         }
         this.weekMustM = TextWay.toCode("50");
      }
      
      public function getGCoin(num0:int) : int
      {
         if(num0 < 0)
         {
            num0 = 0;
         }
         if(num0 > this.GCoin_arr2.length - 1)
         {
            num0 = this.GCoin_arr2.length - 1;
         }
         return int(TextWay.getText(this.GCoin_arr2[num0]));
      }
      
      public function getTaskExp(num0:int) : int
      {
         if(num0 < 0)
         {
            num0 = 0;
         }
         if(num0 > this.Exp_arr2.length - 1)
         {
            num0 = this.Exp_arr2.length - 1;
         }
         return int(TextWay.getText(this.Exp_arr2[num0]));
      }
   }
}

