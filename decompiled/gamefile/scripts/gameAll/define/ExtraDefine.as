package gameAll.define
{
   import data.TextWay;
   import gameAll.NormalMustDefine;
   
   public class ExtraDefine
   {
      
      public var giftArr0:Array = [];
      
      public var giftArr1:Array = [];
      
      public var lifeArr:Array = [120000,240000,480000,800000,1200000,2400000,4000000,6400000,8000000,20000000,32000000,40000000,80000000,120000000,160000000,200000000,320000000,360000000,400000000,440000000,480000000,520000000,560000000,600000000,640000000,640000000,640000000,720000000,720000000,720000000,720000000,720000000,750000000,800000000,820000000,840000000,1000000000,1050000000,1100000000,1150000000,1200000000,1250000000,1300000000,1350000000,1400000000];
      
      public var hurtArr:Array = [800,1600,2400,4000,8000,24000,40000,64000,80000,160000,240000,400000,800000,1600000,2400000,3200000,4000000,4800000,5600000,6400000,7200000,8000000,8000000,9600000,9600000,10400000,11200000,1600000,1600000,1600000,2400000,2800000,3000000,3200000,3300000,3500000,4000000,4500000,5000000,5500000,6000000,6500000,7000000,7200000,7400000];
      
      public var levelArr:Array = [10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,90,90,95,95,95,100,100,100,105,105,105,105,105,105,110,110,110,110,110,115,115,120,120,120,125,130,135,140,9999];
      
      public function ExtraDefine()
      {
         super();
         for(var i:int = 0; i < 100; i++)
         {
            this.giftArr0[i] = new Array();
            this.giftArr1[i] = new Array();
         }
         var num0:int = 0;
         this.giftArr0[num0].push("exp,200000,1");
         this.giftArr0[num0].push("GCoin,\t   100000,\t\t\t1");
         this.giftArr0[num0].push("achieve,\t   100,\t\t    1");
         this.giftArr0[num0].push("crystal_3,   1,\t\t\t\t1");
         this.giftArr0[num0].push("random_1,\t   20,\t\t\t\t20");
         this.giftArr0[num0].push("materials,green_chip,1");
         num0 = 1;
         this.giftArr0[num0].push("exp,\t\t400000,\t\t\t1");
         this.giftArr0[num0].push("GCoin,\t\t200000,\t\t\t1");
         this.giftArr0[num0].push("achieve,\t120,\t\t\t1");
         this.giftArr0[num0].push("crystal_3,\t1,\t\t\t\t1");
         this.giftArr0[num0].push("random_1,\t30,\t\t\t\t30");
         this.giftArr0[num0].push("materials,green_chip,1");
         num0 = 2;
         this.giftArr0[num0].push("exp,\t\t600000,\t\t\t1");
         this.giftArr0[num0].push("GCoin,\t\t300000,\t\t\t1");
         this.giftArr0[num0].push("achieve,\t140,\t\t\t1");
         this.giftArr0[num0].push("crystal_3,\t1,\t\t\t\t1");
         this.giftArr0[num0].push("random_2,\t20,\t\t\t\t20");
         this.giftArr0[num0].push("materials,green_chip,1");
         num0 = 3;
         this.giftArr0[num0].push("exp,\t\t800000,\t\t\t1");
         this.giftArr0[num0].push("GCoin,\t\t400000,\t\t\t1");
         this.giftArr0[num0].push("achieve,\t160,\t\t\t1");
         this.giftArr0[num0].push("crystal_3,\t1,\t\t\t\t1");
         this.giftArr0[num0].push("random_2,\t30,\t\t\t\t30");
         this.giftArr0[num0].push("materials,green_chip,1");
         num0 = 4;
         this.giftArr0[num0].push("exp,\t\t1000000,\t\t1");
         this.giftArr0[num0].push("GCoin,\t\t500000,\t\t\t1");
         this.giftArr0[num0].push("achieve,\t180,\t\t\t1");
         this.giftArr0[num0].push("crystal_3,\t1,\t\t\t\t1");
         this.giftArr0[num0].push("random_2,\t40,\t\t\t\t40");
         this.giftArr0[num0].push("materials,green_chip,1");
         num0 = 5;
         this.giftArr0[num0].push("exp,\t\t1200000,\t\t1");
         this.giftArr0[num0].push("GCoin,\t\t600000,\t\t\t1");
         this.giftArr0[num0].push("achieve,\t200,\t\t\t1");
         this.giftArr0[num0].push("crystal_4,\t1,\t\t\t\t1");
         this.giftArr0[num0].push("random_3,\t40,\t\t\t\t40");
         this.giftArr0[num0].push("materials,green_chip,1");
         num0 = 6;
         this.giftArr0[num0].push("exp,\t\t1400000,\t\t1");
         this.giftArr0[num0].push("GCoin,\t\t700000,\t\t\t1");
         this.giftArr0[num0].push("achieve,\t220,\t\t\t1");
         this.giftArr0[num0].push("crystal_4,\t1,\t\t\t\t1");
         this.giftArr0[num0].push("random_3,\t50,\t\t\t\t50");
         this.giftArr0[num0].push("materials,green_chip,1");
         num0 = 7;
         this.giftArr0[num0].push("exp,\t\t1600000,\t\t1");
         this.giftArr0[num0].push("GCoin,\t\t800000,\t\t\t1");
         this.giftArr0[num0].push("achieve,\t240,\t\t\t1");
         this.giftArr0[num0].push("crystal_4,\t1,\t\t\t\t1");
         this.giftArr0[num0].push("random_3,\t60,\t\t\t\t60");
         this.giftArr0[num0].push("materials,green_chip,1");
         num0 = 8;
         this.giftArr0[num0].push("exp,\t\t1800000,\t\t1");
         this.giftArr0[num0].push("GCoin,\t\t900000,\t\t\t1");
         this.giftArr0[num0].push("achieve,\t260,\t\t\t1");
         this.giftArr0[num0].push("crystal_4,\t1,\t\t\t\t1");
         this.giftArr0[num0].push("random_4,\t50,\t\t\t\t50");
         this.giftArr0[num0].push("materials,green_chip,1");
         num0 = 9;
         this.giftArr0[num0].push("exp,\t\t2000000,\t\t1");
         this.giftArr0[num0].push("GCoin,\t\t1000000,\t\t\t1");
         this.giftArr0[num0].push("achieve,\t280,\t\t\t1");
         this.giftArr0[num0].push("crystal_4,\t1,\t\t\t\t1");
         this.giftArr0[num0].push("random_4,\t60,\t\t\t\t60");
         this.giftArr0[num0].push("materials,green_chip,1");
         num0 = 10;
         this.giftArr0[num0].push("exp,\t\t2200000,\t\t1");
         this.giftArr0[num0].push("GCoin,\t\t1100000,\t\t1");
         this.giftArr0[num0].push("achieve,\t300,\t\t\t1");
         this.giftArr0[num0].push("crystal_5,\t1,\t\t\t\t1");
         this.giftArr0[num0].push("random_5,\t50,\t\t\t\t50");
         this.giftArr0[num0].push("materials,green_chip,1");
         num0 = 11;
         this.giftArr0[num0].push("exp,\t\t2400000,\t\t1");
         this.giftArr0[num0].push("GCoin,\t\t1200000,\t\t1");
         this.giftArr0[num0].push("achieve,\t320,\t\t\t1");
         this.giftArr0[num0].push("crystal_5,\t1,\t\t\t\t1");
         this.giftArr0[num0].push("random_5,\t60,\t\t\t\t60");
         this.giftArr0[num0].push("materials,green_chip,1");
         num0 = 12;
         this.giftArr0[num0].push("exp,\t\t2600000,\t\t1");
         this.giftArr0[num0].push("GCoin,\t\t1300000,\t\t1");
         this.giftArr0[num0].push("achieve,\t340,\t\t\t1");
         this.giftArr0[num0].push("crystal_5,\t1,\t\t\t\t1");
         this.giftArr0[num0].push("random_5,\t70,\t\t\t\t70");
         this.giftArr0[num0].push("materials,green_chip,1");
         num0 = 13;
         this.giftArr0[num0].push("exp,\t\t2800000,\t\t1");
         this.giftArr0[num0].push("GCoin,\t\t1400000,\t\t1");
         this.giftArr0[num0].push("achieve,\t360,\t\t\t1");
         this.giftArr0[num0].push("crystal_5,\t1,\t\t\t\t1");
         this.giftArr0[num0].push("random_5,\t80,\t\t\t\t80");
         this.giftArr0[num0].push("materials,green_chip,1");
         num0 = 14;
         this.giftArr0[num0].push("exp,\t\t3000000,\t\t1");
         this.giftArr0[num0].push("GCoin,\t\t1500000,\t\t1");
         this.giftArr0[num0].push("achieve,\t380,\t\t\t1");
         this.giftArr0[num0].push("crystal_5,\t1,\t\t\t\t1");
         this.giftArr0[num0].push("random_6,\t50,\t\t\t\t50");
         this.giftArr0[num0].push("materials,green_chip,1");
         num0 = 15;
         this.giftArr0[num0].push("exp,\t\t3200000,\t\t1");
         this.giftArr0[num0].push("GCoin,\t\t1600000,\t\t1");
         this.giftArr0[num0].push("achieve,\t400,\t\t\t1");
         this.giftArr0[num0].push("crystal_6,\t1,\t\t\t\t1");
         this.giftArr0[num0].push("random_6,\t80,\t\t\t\t80");
         this.giftArr0[num0].push("materials,green_chip,1");
         num0 = 16;
         this.giftArr0[num0].push("exp,\t\t3400000,\t\t1");
         this.giftArr0[num0].push("GCoin,\t1700000,\t1");
         this.giftArr0[num0].push("achieve,\t420,\t\t\t1");
         this.giftArr0[num0].push("crystal_6,\t1,\t\t\t1");
         this.giftArr0[num0].push("random_6,\t110,\t\t    110");
         this.giftArr0[num0].push("materials,green_chip,1");
         num0 = 17;
         this.giftArr0[num0].push("exp,\t\t4000000,\t1");
         this.giftArr0[num0].push("GCoin,\t\t2000000,\t1");
         this.giftArr0[num0].push("achieve,\t500,\t\t1");
         this.giftArr0[num0].push("crystal_6,\t1,\t\t\t1");
         this.giftArr0[num0].push("random_6,\t150,\t\t150");
         this.giftArr0[num0].push("materials,\tgreen_chip,\t1");
         num0 = 18;
         this.giftArr0[num0].push("exp,\t\t4200000,\t1");
         this.giftArr0[num0].push("GCoin,\t\t2100000,\t1");
         this.giftArr0[num0].push("achieve,\t550,\t\t1");
         this.giftArr0[num0].push("crystal_6,\t1,\t\t\t1");
         this.giftArr0[num0].push("random_6,\t160,\t\t160");
         this.giftArr0[num0].push("materials,\tgreen_chip,\t1");
         num0 = 19;
         this.giftArr0[num0].push("exp,\t\t4500000,\t1");
         this.giftArr0[num0].push("GCoin,\t\t2400000,\t1");
         this.giftArr0[num0].push("achieve,\t600,\t\t1");
         this.giftArr0[num0].push("crystal_6,\t1,\t\t\t1");
         this.giftArr0[num0].push("random_6,\t160,\t\t160");
         this.giftArr0[num0].push("materials,green_chip,\t1");
         num0 = 20;
         this.giftArr0[num0].push("exp,\t\t4500000,\t1");
         this.giftArr0[num0].push("GCoin,\t\t2400000,\t1");
         this.giftArr0[num0].push("achieve,\t600,\t\t1");
         this.giftArr0[num0].push("crystal_6,\t1,\t\t\t1");
         this.giftArr0[num0].push("random_6,\t160,\t\t160");
         this.giftArr0[num0].push("materials,\tgreen_chip,\t1");
         num0 = 21;
         this.giftArr0[num0].push("exp,\t\t4500000,\t1");
         this.giftArr0[num0].push("GCoin,\t\t2400000,\t1");
         this.giftArr0[num0].push("achieve,\t600,\t\t1");
         this.giftArr0[num0].push("crystal_6,\t1,\t\t\t1");
         this.giftArr0[num0].push("random_6,\t160,\t\t160");
         this.giftArr0[num0].push("materials,\tgreen_chip,\t1");
         num0 = 22;
         this.giftArr0[num0].push("exp,\t\t5000000,\t1");
         this.giftArr0[num0].push("GCoin,\t\t3000000,\t1");
         this.giftArr0[num0].push("achieve,\t800,\t\t1");
         this.giftArr0[num0].push("crystal_7,\t1,\t\t\t1");
         this.giftArr0[num0].push("random_6,\t160,\t\t160");
         this.giftArr0[num0].push("materials,\tgreen_chip,\t1");
         num0 = 23;
         this.giftArr0[num0].push("exp,\t\t5500000,\t1");
         this.giftArr0[num0].push("GCoin,\t\t3000000,\t1");
         this.giftArr0[num0].push("achieve,\t1000,\t\t1");
         this.giftArr0[num0].push("crystal_7,\t1,\t\t\t1");
         this.giftArr0[num0].push("random_6,\t160,\t\t160");
         this.giftArr0[num0].push("materials,\tgreen_chip,\t1");
         num0 = 24;
         this.giftArr0[num0].push("exp,\t\t6000000,\t1");
         this.giftArr0[num0].push("GCoin,\t\t3000000,\t1");
         this.giftArr0[num0].push("achieve,\t1200,\t\t1");
         this.giftArr0[num0].push("crystal_7,\t1,\t\t\t1");
         this.giftArr0[num0].push("random_6,\t160,\t\t160");
         this.giftArr0[num0].push("materials,\tgreen_chip,\t1");
         num0 = 25;
         this.giftArr0[num0].push("exp,\t\t6500000,\t1");
         this.giftArr0[num0].push("GCoin,\t\t3000000,\t1");
         this.giftArr0[num0].push("achieve,\t1400,\t\t1");
         this.giftArr0[num0].push("crystal_7,\t1,\t\t\t1");
         this.giftArr0[num0].push("random_7,\t50,\t\t\t50");
         this.giftArr0[num0].push("materials,\tgreen_chip,\t1");
         num0 = 26;
         this.giftArr0[num0].push("exp,\t\t7000000,\t1");
         this.giftArr0[num0].push("GCoin,\t\t3000000,\t1");
         this.giftArr0[num0].push("achieve,\t1600,\t\t1");
         this.giftArr0[num0].push("crystal_7,\t1,\t\t\t1");
         this.giftArr0[num0].push("random_7,\t50,\t\t\t50");
         this.giftArr0[num0].push("materials,\tgreen_chip,\t1");
         num0 = 27;
         this.giftArr0[num0].push("exp,\t\t7500000,\t1");
         this.giftArr0[num0].push("GCoin,\t\t3000000,\t1");
         this.giftArr0[num0].push("achieve,\t1800,\t\t1");
         this.giftArr0[num0].push("crystal_7,\t1,\t\t\t1");
         this.giftArr0[num0].push("random_7,\t50,\t\t\t50");
         this.giftArr0[num0].push("materials,\tgreen_chip,\t1");
         num0 = 28;
         this.giftArr0[num0].push("exp,\t\t8000000,\t1");
         this.giftArr0[num0].push("GCoin,\t\t3000000,\t1");
         this.giftArr0[num0].push("achieve,\t2000,\t\t1");
         this.giftArr0[num0].push("crystal_7,\t1,\t\t\t1");
         this.giftArr0[num0].push("random_7,\t50,\t\t\t50");
         this.giftArr0[num0].push("materials,\tgreen_chip,\t1");
         num0 = 29;
         this.giftArr0[num0].push("exp,\t\t8500000,\t1");
         this.giftArr0[num0].push("GCoin,\t\t3000000,\t1");
         this.giftArr0[num0].push("achieve,\t2200,\t\t1");
         this.giftArr0[num0].push("crystal_7,\t1,\t\t\t1");
         this.giftArr0[num0].push("random_7,\t50,\t\t\t50");
         this.giftArr0[num0].push("materials,\tgreen_chip,\t1");
         num0 = 30;
         this.giftArr0[num0].push("exp,\t\t9000000,\t1");
         this.giftArr0[num0].push("GCoin,\t\t3000000,\t1");
         this.giftArr0[num0].push("achieve,\t2400,\t\t1");
         this.giftArr0[num0].push("crystal_7,\t1,\t\t\t1");
         this.giftArr0[num0].push("random_7,\t60,\t\t\t60");
         this.giftArr0[num0].push("materials,\tgreen_chip,\t1");
         num0 = 31;
         this.giftArr0[num0].push("exp,\t\t9500000,\t1");
         this.giftArr0[num0].push("GCoin,\t\t3000000,\t1");
         this.giftArr0[num0].push("achieve,\t2600,\t\t1");
         this.giftArr0[num0].push("crystal_8,\t1,\t\t\t1");
         this.giftArr0[num0].push("random_7,\t70,\t\t\t70");
         this.giftArr0[num0].push("materials,\tgreen_chip,\t1");
         num0 = 32;
         this.giftArr0[num0].push("exp,\t\t10000000,\t1");
         this.giftArr0[num0].push("GCoin,\t\t3000000,\t1");
         this.giftArr0[num0].push("achieve,\t2800,\t\t1");
         this.giftArr0[num0].push("crystal_8,\t1,\t\t\t1");
         this.giftArr0[num0].push("random_7,\t70,\t\t\t70");
         this.giftArr0[num0].push("materials,\tgreen_chip,\t1");
         num0 = 33;
         this.giftArr0[num0].push("exp,\t\t10500000,\t1");
         this.giftArr0[num0].push("GCoin,\t\t3000000,\t1");
         this.giftArr0[num0].push("achieve,\t3000,\t\t1");
         this.giftArr0[num0].push("crystal_8,\t1,\t\t\t1");
         this.giftArr0[num0].push("random_7,\t80,\t\t\t80");
         this.giftArr0[num0].push("materials,\tgreen_chip,\t1");
         num0 = 34;
         this.giftArr0[num0].push("exp,\t\t11000000,\t1");
         this.giftArr0[num0].push("GCoin,\t\t3000000,\t1");
         this.giftArr0[num0].push("achieve,\t3200,\t\t1");
         this.giftArr0[num0].push("crystal_8,\t1,\t\t\t1");
         this.giftArr0[num0].push("random_7,\t90,\t\t\t90");
         this.giftArr0[num0].push("materials,\tgreen_chip,\t1");
         num0 = 35;
         this.giftArr0[num0].push("exp,\t\t11500000,\t1");
         this.giftArr0[num0].push("GCoin,\t\t3000000,\t1");
         this.giftArr0[num0].push("achieve,\t3400,\t\t1");
         this.giftArr0[num0].push("crystal_8,\t1,\t\t\t1");
         this.giftArr0[num0].push("random_7,\t90,\t\t\t90");
         this.giftArr0[num0].push("materials,\tgreen_chip,\t1");
         num0 = 36;
         this.giftArr0[num0].push("exp,\t\t12000000,\t1");
         this.giftArr0[num0].push("GCoin,\t\t3000000,\t1");
         this.giftArr0[num0].push("achieve,\t3600,\t\t1");
         this.giftArr0[num0].push("crystal_8,\t1,\t\t\t1");
         this.giftArr0[num0].push("random_7,\t90,\t\t\t90");
         this.giftArr0[num0].push("materials,\tgreen_chip,\t1");
         num0 = 37;
         this.giftArr0[num0].push("exp,\t\t12500000,\t1");
         this.giftArr0[num0].push("GCoin,\t\t3000000,\t1");
         this.giftArr0[num0].push("achieve,\t3800,\t\t1");
         this.giftArr0[num0].push("crystal_8,\t1,\t\t\t1");
         this.giftArr0[num0].push("random_7,\t90,\t\t\t90");
         this.giftArr0[num0].push("materials,\tgreen_chip,\t1");
         num0 = 38;
         this.giftArr0[num0].push("exp,\t\t13000000,\t1");
         this.giftArr0[num0].push("GCoin,\t\t3000000,\t1");
         this.giftArr0[num0].push("achieve,\t4000,\t\t1");
         this.giftArr0[num0].push("crystal_8,\t1,\t\t\t1");
         this.giftArr0[num0].push("random_7,\t90,\t\t\t90");
         this.giftArr0[num0].push("materials,\tgreen_chip,\t1");
         num0 = 39;
         this.giftArr0[num0].push("exp,\t\t13500000,\t1");
         this.giftArr0[num0].push("GCoin,\t\t3000000,\t1");
         this.giftArr0[num0].push("achieve,\t4200,\t\t1");
         this.giftArr0[num0].push("crystal_8,\t1,\t\t\t1");
         this.giftArr0[num0].push("random_7,\t90,\t\t\t90");
         this.giftArr0[num0].push("materials,\tgreen_chip,\t1");
         num0 = 40;
         this.giftArr0[num0].push("exp,\t\t14000000,\t1");
         this.giftArr0[num0].push("GCoin,\t\t3000000,\t1");
         this.giftArr0[num0].push("achieve,\t4400,\t\t1");
         this.giftArr0[num0].push("crystal_8,\t1,\t\t\t1");
         this.giftArr0[num0].push("random_7,\t90,\t\t\t90");
         this.giftArr0[num0].push("materials,\tgreen_chip,\t1");
         num0 = 41;
         this.giftArr0[num0].push("exp,\t\t15000000,\t1");
         this.giftArr0[num0].push("GCoin,\t\t3000000,\t1");
         this.giftArr0[num0].push("achieve,\t4600,\t\t1");
         this.giftArr0[num0].push("crystal_8,\t1,\t\t\t1");
         this.giftArr0[num0].push("random_7,\t95,95");
         this.giftArr0[num0].push("materials,\tgreen_chip,\t1");
         num0 = 42;
         this.giftArr0[num0].push("exp,\t\t16000000,\t1");
         this.giftArr0[num0].push("GCoin,\t\t3000000,\t1");
         this.giftArr0[num0].push("achieve,\t4800,\t\t1");
         this.giftArr0[num0].push("crystal_7,\t1,\t\t\t1");
         this.giftArr0[num0].push("random_7,\t100,100");
         this.giftArr0[num0].push("materials,\tgreen_chip,\t1");
         num0 = 43;
         this.giftArr0[num0].push("exp,\t\t17000000,\t1");
         this.giftArr0[num0].push("GCoin,\t\t3000000,\t1");
         this.giftArr0[num0].push("achieve,\t5000,\t\t1");
         this.giftArr0[num0].push("crystal_7,\t1,\t\t\t1");
         this.giftArr0[num0].push("random_7,\t100,100");
         this.giftArr0[num0].push("materials,\tgreen_chip,\t1");
         num0 = 44;
         this.giftArr0[num0].push("exp,\t\t17000000,\t1");
         this.giftArr0[num0].push("GCoin,\t\t3000000,\t1");
         this.giftArr0[num0].push("achieve,\t5000,\t\t1");
         this.giftArr0[num0].push("crystal_7,\t1,\t\t\t1");
         this.giftArr0[num0].push("random_7,\t100,100");
         this.giftArr0[num0].push("materials,\tgreen_chip,\t1");
         num0 = 0;
         this.giftArr1[num0].push("exp,\t\t60000,\t\t\t1");
         this.giftArr1[num0].push("GCoin,\t\t20000,\t\t\t1");
         this.giftArr1[num0].push("random_1,\t20,\t\t\t\t20");
         this.giftArr1[num0].push("materials,\torange_chip,\t1");
         num0 = 1;
         this.giftArr1[num0].push("exp,\t\t80000,\t\t\t1");
         this.giftArr1[num0].push("GCoin,\t\t50000,\t\t\t1");
         this.giftArr1[num0].push("random_2,\t20,\t\t\t\t20");
         this.giftArr1[num0].push("materials,\torange_chip,\t1");
         num0 = 2;
         this.giftArr1[num0].push("exp,\t\t84000,\t\t\t1");
         this.giftArr1[num0].push("GCoin,\t\t60000,\t\t\t1");
         this.giftArr1[num0].push("random_2,\t24,\t\t\t\t24");
         this.giftArr1[num0].push("materials,\torange_chip,\t1");
         this.giftArr1[num0].push("crystal,\t4,\t\t\t\t1");
         num0 = 3;
         this.giftArr1[num0].push("exp,\t\t84000,\t\t\t1");
         this.giftArr1[num0].push("GCoin,\t\t60000,\t\t\t1");
         this.giftArr1[num0].push("random_2,\t24,\t\t\t\t24");
         this.giftArr1[num0].push("materials,\torange_chip,\t1");
         this.giftArr1[num0].push("crystal,\t4,\t\t\t\t1");
         num0 = 4;
         this.giftArr1[num0].push("exp,\t\t120000,\t\t\t1");
         this.giftArr1[num0].push("GCoin,\t\t96000,\t\t\t1");
         this.giftArr1[num0].push("random_3,\t24,\t\t\t\t24");
         this.giftArr1[num0].push("materials,\torange_chip,\t1");
         this.giftArr1[num0].push("crystal,\t4,\t\t\t\t1");
         num0 = 5;
         this.giftArr1[num0].push("exp,\t\t120000,\t\t\t1");
         this.giftArr1[num0].push("GCoin,\t\t96000,\t\t\t1");
         this.giftArr1[num0].push("random_3,\t24,\t\t\t\t24");
         this.giftArr1[num0].push("materials,\torange_chip,\t1");
         this.giftArr1[num0].push("crystal,\t4,\t\t\t\t1");
         num0 = 6;
         this.giftArr1[num0].push("GCoin,\t\t100000,\t\t\t1");
         this.giftArr1[num0].push("random_4,\t30,\t\t\t\t30");
         this.giftArr1[num0].push("materials,\tgreen_chip,\t\t1");
         this.giftArr1[num0].push("crystal,\t5,\t\t\t\t1");
         this.giftArr1[num0].push("materials,\tsuperalloy_X,\t4");
         num0 = 7;
         this.giftArr1[num0].push("achieve,\t100,\t\t\t1");
         this.giftArr1[num0].push("GCoin,\t\t120000,\t\t\t1");
         this.giftArr1[num0].push("random_4,\t35,\t\t\t\t35");
         this.giftArr1[num0].push("materials,\tgreen_chip,\t\t1");
         this.giftArr1[num0].push("crystal,\t5,\t\t\t\t1");
         this.giftArr1[num0].push("materials,\tsuperalloy_X,\t4");
         num0 = 8;
         this.giftArr1[num0].push("achieve,\t100,\t\t\t1");
         this.giftArr1[num0].push("GCoin,\t\t150000,\t\t\t1");
         this.giftArr1[num0].push("random_4,\t40,\t\t\t\t40");
         this.giftArr1[num0].push("materials,\tgreen_chip,\t\t1");
         this.giftArr1[num0].push("crystal,\t5,\t\t\t\t1");
         this.giftArr1[num0].push("materials,\tsuperalloy_X,\t4");
         swapToCode2(this.giftArr0);
         swapToCode2(this.giftArr1);
         swapToCode(this.lifeArr);
         swapToCode(this.hurtArr);
      }
      
      public static function swapToCode2(arr0:Array) : *
      {
         var n:* = undefined;
         var m:* = undefined;
         for(n in arr0)
         {
            for(m in arr0[n])
            {
               arr0[n][m] = TextWay.toCode(arr0[n][m]);
            }
         }
      }
      
      public static function swapToCode(arr0:Array) : *
      {
         var n:* = undefined;
         for(n in arr0)
         {
            arr0[n] = TextWay.toCode(String(arr0[n]));
         }
      }
      
      public static function swapToText(arr0:Array) : Array
      {
         var n:* = undefined;
         var arr1:Array = [];
         for(n in arr0)
         {
            arr1[n] = TextWay.getText(arr0[n]);
         }
         return arr1;
      }
      
      public static function swapToNumber(arr0:Array) : Array
      {
         var n:* = undefined;
         var arr1:Array = [];
         for(n in arr0)
         {
            arr1[n] = Number(TextWay.getText(arr0[n]));
         }
         return arr1;
      }
      
      public function getHurt(diff0:int, level0:int) : int
      {
         return int(TextWay.getText(this.hurtArr[level0]));
      }
      
      public function getLife(diff0:int, level0:int) : int
      {
         return int(TextWay.getText(this.lifeArr[level0]));
      }
      
      public function getMustLevel(diff0:int, level0:int) : int
      {
         return this.levelArr[level0] - 1;
      }
      
      public function restart_M() : NormalMustDefine
      {
         var nmd0:NormalMustDefine = new NormalMustDefine();
         nmd0.MCoin = 2;
         return nmd0;
      }
      
      public function getGift(diff0:int, level0:int) : Array
      {
         var n:* = undefined;
         var str0:String = null;
         var value0:int = 0;
         if(level0 > this.giftArr0.length - 1)
         {
            level0 = this.giftArr0.length - 1;
         }
         var arr1:Array = this["giftArr" + diff0][level0];
         var arr2:Array = swapToText(arr1);
         for(n in arr2)
         {
            str0 = arr2[n];
            if(str0.indexOf("exp") >= 0 || str0.indexOf("GCoin") >= 0)
            {
               value0 = int(str0.split(",")[1]) * 1;
               str0 = str0.split(",")[0] + "," + value0 + ",1";
            }
            arr2[n] = str0;
         }
         return arr2;
      }
   }
}

