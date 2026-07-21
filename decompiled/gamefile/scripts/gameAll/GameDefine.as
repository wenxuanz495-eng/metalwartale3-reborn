package gameAll
{
   import data.StringToDefine;
   import data.TextWay;
   import flash.display.Sprite;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import gameAll.define.AdditionalDefine;
   import gameAll.define.ArenaFlipCardDefine;
   import gameAll.define.DialogueDefine;
   import gameAll.define.ExploreDefine;
   import gameAll.define.ExtraDefine;
   import gameAll.define.ExtraFlipCardDefine;
   import gameAll.define.FlipCardDefine;
   import gameAll.define.GameLevelDefine;
   import gameAll.define.GiftDefine;
   import gameAll.define.SpecialExtraDefine;
   import gameAll.define.TaskDefine;
   import gameAll.define.TipsDefine;
   import gameAll.define.UnionFlipCardDefine;
   import gameAll.define.WeekExtraDefine;
   import gameAll.define.drop.DropDefine;
   import gameAll.define.helper.HelperDefine;
   import gameAll.define.liveness.LivenessDefine;
   import gameAll.define.other.ArmsUpgradeDefine;
   import gameAll.define.other.DailySignDefine;
   import gameAll.define.other.DropBox2Define;
   import gameAll.define.other.DropBox3Define;
   import gameAll.define.other.DropBoxDefine;
   import gameAll.define.other.HighDefine;
   import gameAll.define.other.PurpleChipDefine;
   import gameAll.define.other.RankGiftDefine;
   import gameAll.honor.HonorDefine;
   import gameAll.test.AccountLimitDefine;
   import gameAll.vip.VipDefine;
   
   public class GameDefine
   {
      
      public var dialogue:DialogueDefine = new DialogueDefine();
      
      public var taskDefine:TaskDefine = new TaskDefine();
      
      public var itemsDropLevel:Array = [0,-3,-6];
      
      public var itemsDropPro:Array = [0.2,0.3,0.5];
      
      public var itemsDropType:Array = ["chip","crystal","material","lifePer","money",""];
      
      public var soldierIDTP:Array = [0.005,0.005,0.09,0.05,0.35,1];
      
      public var superIDTP:Array = [0.2,0.2,0.2,0,0.2,1];
      
      public var championIDTP:Array = [0.2,0.2,0.2,0,0.2,1];
      
      public var bossIDTP:Array = [0.3,0.3,0.2,0,0.2,0];
      
      public var chipDropType:Array = ["green_chip","orange_chip","yellow_chip","blue_chip","white_chip"];
      
      public var soldierChip:Array = [0.0001,0,0.0001,0.0098,0.99];
      
      public var superChip:Array = [0.0001,0.0001,0.0098,0.99,0];
      
      public var championChip:Array = [0.01,0.09,0.2,0.7,0];
      
      public var bossChip:Array = [0.01,0.09,0.6,0.3,0];
      
      public var drop:DropDefine = new DropDefine();
      
      public var rankNameArr:Array = ["新兵","下士","中士","上士","少尉","中尉","上尉","少校","中校","上校","少将","中将","上将","五星上将","元帅","大元帅","大元帅+1","大元帅+2","大元帅+3","大元帅+4","钢铁元帅","钢铁元帅+1","钢铁元帅+2","钢铁元帅+3","钢铁元帅+4","行星元帅","行星元帅+1","行星元帅+2","行星元帅+3","行星元帅+4"];
      
      public var armsMust:NormalMustDefine = new NormalMustDefine();
      
      public var subMust:NormalMustDefine = new NormalMustDefine();
      
      public var holeMust:NormalMustDefine = new NormalMustDefine();
      
      public var supplyMust:NormalMustDefine = new NormalMustDefine();
      
      public var headMust:NormalMustDefine = new NormalMustDefine();
      
      public var difficult_ra_arr:Array = [1,1,1,1];
      
      public var difficult_ra0:Array = [0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.612,0.648,0.72,0.792,0.792,0.792,0.9,0.9,0.9,0.9,1.08,1.08,1.08,1.08,1.08,1.08,1.08,1.08,1.08,1.08];
      
      public var difficult_ra1:Array = [1.44,1.152,1.152,1.224,1.224,1.296,1.296,1.296,1.296,1.368,1.368,1.44,1.44,1.44,1.512,1.512,1.512,1.584,1.584,1.584,1.656,1.656,1.728,1.728,1.728,1.8,1.8,1.8,1.872,1.872,1.872];
      
      public var difficult_ra2:Array = [2.8,2.24,2.24,2.24,2.4,2.4,2.4,2.56,2.56,2.56,2.56,2.64,2.64,2.64,2.72,2.72,2.72,2.72,2.8,2.8,2.8,2.8,2.88,2.88,2.88,2.88,3.04,3.04,3.04,3.04,3.04];
      
      public var difficult_ra3:Array = [4,3.2,3.2,3.2,3.2,3.2,3.2,4,4,4,4,4,4,4,4.8,4.8,4.8,4.8,4.8,4.8,4.8,4.8,6.4,6.4,6.4,6.4,6.4,6.4,6.4,6.4,6.4];
      
      public var enemyExp2:Array = [14,26,46,74,110,154,206,266,334,410,494,586,686,794,910,1034,1166,1306,1454,1610,1650,1700,1750,1800,1850,1900,1950,2000,2050,2100,2150,2200,2250,2300,2350,2400,2450,2500,2550,2600,2650,2700,2750,2800,2850,2900,2950,3000,3050,3100,3150,3200,3250,3300,3350,3400,3450,3500,3550,3600,3650,3700,3750,3800,3850,3900,3950,4000,4050,4100];
      
      public var enemyAttack2:Array = [492,659,939,1337,1861,2516,3308,4243,6172,7599,16723,19999,23624,28186,32627,37458,42688,48330,56852,63627,70861,78564,86749,97070,106386,130750,142413,154685,173853,187817,249265,268122,287827,312930,334645,357261,380794,405260,444857,471921,694417,734795,776599,830363,875565,922268,970496,1020268,1101926,1156173,1761057,1844694,1930771,2042268,2134176,2228635,2325675,2425328,2591467,2698582,2808439,2921070,3036507,3186972,4412164,4578918,4749600,4924252,5220172,5802973,8343296,8633126,8929260,10248961,10591329,10940870,11297652,11661743,12283916,12669184];
      
      public var enemyAttack_diff:Array = [16,12,8,4];
      
      public var addDefine:AdditionalDefine = new AdditionalDefine();
      
      public var enemyLoaderList:Array = [];
      
      public var explore:ExploreDefine = new ExploreDefine();
      
      public var gift:GiftDefine = new GiftDefine();
      
      public var extra:ExtraDefine = new ExtraDefine();
      
      public var weekExtra:WeekExtraDefine = new WeekExtraDefine();
      
      public var specialExtra:SpecialExtraDefine = new SpecialExtraDefine();
      
      public var liveness:LivenessDefine = new LivenessDefine();
      
      public var flipCard:FlipCardDefine = new FlipCardDefine();
      
      public var arenaFlipCard:ArenaFlipCardDefine = new ArenaFlipCardDefine();
      
      public var extraFlipCard:ExtraFlipCardDefine = new ExtraFlipCardDefine();
      
      public var unionFlipCard:UnionFlipCardDefine = new UnionFlipCardDefine();
      
      public var dropBox:DropBoxDefine = new DropBoxDefine();
      
      public var dropBox2:DropBox2Define = new DropBox2Define();
      
      public var dropBox3:DropBox3Define = new DropBox3Define();
      
      public var accountLimit:AccountLimitDefine = new AccountLimitDefine();
      
      public var high:HighDefine = new HighDefine();
      
      public var honor:HonorDefine = new HonorDefine();
      
      public var purpleChip:PurpleChipDefine = new PurpleChipDefine();
      
      public var vip:VipDefine = new VipDefine();
      
      public var dailySign:DailySignDefine = new DailySignDefine();
      
      public var helper:HelperDefine = new HelperDefine();
      
      public var armsUpgrade:ArmsUpgradeDefine = new ArmsUpgradeDefine();
      
      public var level:GameLevelDefine = new GameLevelDefine();
      
      public var rankGiftDefine:RankGiftDefine = new RankGiftDefine();
      
      public var crystalMax:int = 9;
      
      public var crystalUpgradeNum:int = 4;
      
      public var materialUpgradeNum:int = 2;
      
      public var motionMustItems:Array = ["thorn"];
      
      public var boomMustItems:Array = ["boom"];
      
      public var energyMustItems:Array = ["buncher"];
      
      public var mixedMustItems:Array = ["thorn","buncher","boom"];
      
      public var armsMustItemsNum:Array = [5,10,20,30,60,120,50,100,200,100,200,400];
      
      public var superalloy_Z_Must:Array = [1,5,10,10,50,100,15,75,150,20,100,200];
      
      public var jumpSkillCoinNum:Array = [0,100,1000,10000,20000,50000,100000,200000,500000,1000000,2000000,4000000,5000000,8000000];
      
      public var rocketSkillCoinNum:Array = [0,100,1000,10000,20000,50000,100000,200000,500000,1000000,2000000,4000000,5000000,8000000];
      
      public var plasmaSkillCoinNum:Array = [0,100,1000,10000,20000,50000,100000,200000,500000,1000000,2000000,4000000,6000000,10000000];
      
      public var jumpSkillLevelNum:Array = [-1,4,9,14,19,24,29,34,39,44,55,59,61,64];
      
      public var rocketSkillLevelNum:Array = [-1,4,9,14,19,24,29,34,39,44,55,60,61,64];
      
      public var plasmaSkillLevelNum:Array = [-1,4,9,14,19,24,29,34,39,44,55,60,63,68];
      
      public var pointArr:Array = [];
      
      internal var CarUpgradeLife_G:Array = [1000,1600,3000,5000,7000,9000,24000,32000,40000,80000,120000,200000,300000,320000,350000,400000,450000,500000,550000];
      
      internal var CarUpgradeLife_M:Array = [1800,3600,6000,12000,15000,20000,50000,60000,96000,200000,350000,600000,800000,850000,900000,950000,1000000,1100000,1200000];
      
      internal var CarUpgradeLife_XYZ:Array = [0,0,0,24000,36000,48000,60000,80000,120000,240000,350000,800000,1000000,1100000,1200000,1300000,1400000,1500000,1600000];
      
      internal var CarUpgradeDefence_G:Array = [480,680,880,1080,1280,1480,1680,1880,2000,2200,2400,5200,5600,5800,6000,6200,6400,6600,6800];
      
      internal var CarUpgradeDefence_M:Array = [720,1020,1320,1620,1920,2220,2520,2820,3000,3300,3600,7800,8400,8800,9200,9600,10000,10500,11000];
      
      internal var CarUpgradeDefence_XYZ:Array = [0,0,0,1200,1600,2000,3000,3600,4200,5000,5500,8000,8800,9600,10400,11200,12000,12800,13600];
      
      internal var CarUpgradeMust_G:Array = [10000,30000,50000,100000,300000,500000,1000000,1500000,1500000,2000000,3000000,5000000,10000000,15000000,20000000,20000000,20000000,20000000,20000000];
      
      internal var CarUpgradeMust_M:Array = [10,10,20,20,30,30,50,70,100,100,100,100,100,200,200,200,200,200,200];
      
      internal var CarUpgradeMust_X:Array = [0,0,0,0,60,60,60,80,80,100,100,200,200,300,300,400,400,500,500];
      
      internal var CarUpgradeMust_Y:Array = [0,0,0,0,0,0,0,0,0,12,12,16,16,24,24,40,40,64,64];
      
      public var superEnemyColor:ColorTransform = new ColorTransform(1,1,1,1,0,20,200,0);
      
      public var championEnemyColor:ColorTransform = new ColorTransform(1,1,1,1,180,80,0,0);
      
      public var weEnemyColor:ColorTransform = new ColorTransform(0.9,1,0.9,1,0,139,0,0);
      
      public var superAllRa:Array = [5,1.5,1,1];
      
      public var championAllRa:Array = [10,2,2,1];
      
      public var bossAllRa:Array = [10,3,4,1];
      
      public var noSuperList:Array = ["判决者","剑装审判者","炮装审判者","自爆蜘蛛机","原子塔","原子反应堆","警报塔","地面自动炮台","防御激光炮","巨型压路机","飞轮机器人","闪电球",""];
      
      public var nolyChampionList:Array = ["强袭者","碾压者","攻城坦克","仲裁者","杀戮者","突击者","女妖战机"];
      
      public var unlockBagMustMCoin:int = 50;
      
      public var refreshExchange:int = 2;
      
      public var rankAdd:Array = [];
      
      public var rankGift:Array = [];
      
      public var levelsMax:int = 31;
      
      public var gameLevelTest:int = 0;
      
      public var nowLevel:int = 1;
      
      public var lockFirstB:Boolean = false;
      
      public var recommendLevelArr:Array = [];
      
      public var noticeContext:String = "   <font color=\'#FFFF00\'>亲爱的玩家，超合金战记2 1.007补丁正式更新！</font>\n\n   如之前有充值方面的问题，请前往论坛联系客服解决问题！更多精彩活动，更多新关卡，我们将在后续版本中陆续推出！";
      
      public var tips:TipsDefine = new TipsDefine();
      
      public function GameDefine()
      {
         super();
         this.armsMust.GCoin_arr = [0,0,1000,10000,1000000,0,0,0];
         this.armsMust.level_arr = [0,2,4,4,24,39,49,59];
         this.armsMust.MCoin_arr = [0,0,0,0,0,99,199,399];
         this.armsMust.rankLevel_arr = [0,0,0,0,2,4,7,10];
         this.subMust.level_arr = [2,4,19,24,29,39,69,79];
         this.subMust.GCoin_arr = [0,10000,1000000,1500000,5000000,0,0,0];
         this.subMust.MCoin_arr = [0,0,0,0,0,200,400,800];
         this.subMust.rankLevel_arr = [0,0,0,2,4,6,11,14];
         this.holeMust.GCoin_arr = [10000,50000,1000000,0,0];
         this.holeMust.level_arr = [6,6,6,6];
         this.holeMust.MCoin_arr = [0,0,0,50];
         this.headMust.GCoin = 50000;
         this.headMust.MCoin = 0;
         this.supplyMust.GCoin_arr = [500];
         this.supplyMust.index = 0;
         this.supplyMust.fleshByIndex(0);
         this.pointArr.push(new Point(-100 - 40,-20));
         this.pointArr.push(new Point(-153 - 40,-50));
         this.pointArr.push(new Point(-60 - 40,-134));
         this.pointArr.push(new Point(-98 + 10 - 33,-154 + 14));
         this.pointArr.push(new Point(-98 + 10 - 33,-111 - 14));
         this.pointArr.push(new Point(-161 + 50 - 36,-170 + 17));
         this.pointArr.push(new Point(-161 + 50 - 36,-106 - 17));
         this.pointArr.push(new Point(-161 + 50 - 36,-137));
         this.rankAdd.push([5,0,-1,0,0,0]);
         this.rankAdd.push([5,0.05,-1,0.05,0.04,0.02]);
         this.rankAdd.push([5,0.06,-1,0.06,0.08,0.04]);
         this.rankAdd.push([5,0.07,-1,0.07,0.12,0.06]);
         this.rankAdd.push([5,0.08,-1,0.08,0.16,0.08]);
         this.rankAdd.push([5,0.09,-1,0.09,0.2,0.1]);
         this.rankAdd.push([5,0.1,-1,0.1,0.24,0.12]);
         this.rankAdd.push([5,0.11,-1,0.11,0.28,0.14]);
         this.rankAdd.push([5,0.12,-1,0.12,0.32,0.16]);
         this.rankAdd.push([5,0.13,-1,0.13,0.36,0.18]);
         this.rankAdd.push([5,0.14,-1,0.14,0.4,0.2]);
         this.rankAdd.push([5,0.15,-1,0.15,0.44,0.22]);
         this.rankAdd.push([5,0.16,-1,0.16,0.48,0.24]);
         this.rankAdd.push([5,0.17,-1,0.17,0.52,0.26]);
         this.rankAdd.push([5,0.18,-1,0.18,0.56,0.28]);
         this.rankAdd.push([5,0.19,-1,0.19,0.6,0.3]);
         this.rankAdd.push([5,0.2,-1,0.2,0.64,0.32]);
         this.rankAdd.push([5,0.21,-1,0.21,0.68,0.34]);
         this.rankAdd.push([5,0.22,-1,0.22,0.72,0.36]);
         this.rankAdd.push([5,0.23,-1,0.23,0.76,0.38]);
         this.rankAdd.push([5,0.24,-1,0.24,0.8,0.4]);
         this.rankAdd.push([5,0.25,-1,0.25,0.84,0.42]);
         this.rankAdd.push([5,0.26,-1,0.26,0.88,0.44]);
         this.rankAdd.push([5,0.27,-1,0.27,0.92,0.46]);
         this.rankAdd.push([5,0.28,-1,0.28,0.96,0.48]);
         this.rankAdd.push([5,0.29,-1,0.29,1,0.5]);
         this.rankAdd.push([5,0.3,-1,0.3,1.04,0.52]);
         this.rankAdd.push([5,0.31,-1,0.31,1.08,0.54]);
         this.rankAdd.push([5,0.32,-1,0.32,1.12,0.56]);
         this.rankAdd.push([5,0.33,-1,0.33,1.16,0.58]);
         this.rankGift.push(["100000","crystal_3_1","green_chip_1"]);
         this.rankGift.push(["200000","crystal_3_1","green_chip_1"]);
         this.rankGift.push(["300000","crystal_3_1","green_chip_1"]);
         this.rankGift.push(["400000","crystal_4_1","green_chip_1"]);
         this.rankGift.push(["500000","crystal_4_1","green_chip_1"]);
         this.rankGift.push(["600000","crystal_4_1","green_chip_1"]);
         this.rankGift.push(["700000","crystal_5_1","green_chip_1"]);
         this.rankGift.push(["800000","crystal_5_1","green_chip_1"]);
         this.rankGift.push(["900000","crystal_5_1","green_chip_1"]);
         this.rankGift.push(["1000000","crystal_5_1","green_chip_1"]);
         this.rankGift.push(["1100000","crystal_6_1","green_chip_1"]);
         this.rankGift.push(["1200000","crystal_6_1","green_chip_1"]);
         this.rankGift.push(["1300000","crystal_6_1","green_chip_1"]);
         this.rankGift.push(["1400000","crystal_6_1","green_chip_1"]);
         this.rankGift.push(["1500000","crystal_6_1","green_chip_1"]);
         this.rankGift.push(["1600000","crystal_6_1","green_chip_1"]);
         this.rankGift.push(["1700000","crystal_7_1","green_chip_1"]);
         this.rankGift.push(["1800000","crystal_7_1","green_chip_1"]);
         this.rankGift.push(["1900000","crystal_7_1","green_chip_1"]);
         this.rankGift.push(["2000000","crystal_7_1","green_chip_1"]);
         this.rankGift.push(["2100000","crystal_7_1","green_chip_1"]);
         this.rankGift.push(["2200000","crystal_7_1","green_chip_1"]);
         this.rankGift.push(["2300000","crystal_7_1","green_chip_1"]);
         this.rankGift.push(["2400000","crystal_7_1","green_chip_1"]);
         this.rankGift.push(["2500000","crystal_7_1","green_chip_1"]);
         this.rankGift.push(["2600000","crystal_7_1","green_chip_1"]);
         this.rankGift.push(["2700000","crystal_7_1","green_chip_1"]);
         this.rankGift.push(["2800000","crystal_7_1","green_chip_1"]);
         this.rankGift.push(["2900000","crystal_7_1","green_chip_1"]);
         this.rankGift.push(["3000000","crystal_7_1","green_chip_1"]);
         this.recommendLevelArr[0] = ["1","1-2","1-3","2-4","3-5","4-6","5-7","6-8","7-9","8-10","9-11","10-12","11-13","11-13","12-14","13-15","14-16","15-17","16-18","17-19","18-20","19-21","20-22","20-22","21-23","21-23","22-24","22-24","23-25","23-25","24-25"];
         this.recommendLevelArr[1] = ["1","26-28","26-28","27-29","27-29","28-30","28-30","29-31","29-31","30-32","30-32","31-33","31-33","32-34","33-35","33-35","34-36","34-36","35-37","35-37","36-38","36-38","37-39","37-39","38-40","38-40","39-40","39-40","39-40","39-40","39-40"];
         this.recommendLevelArr[2] = ["1","41-44","41-44","41-44","42-45","42-45","42-45","43-46","43-46","43-46","44-47","44-47","44-47","45-48","46-49","46-49","46-49","47-50","47-50","47-50","48-50","48-50","49-50","49-50","49-50","49-50","50","50","50","50","50"];
         this.recommendLevelArr[3] = ["1","50","50","50","50","50","50","50","50","50","50","50","50","50","50","50","50","50","50","50","50","50","50","50","50","50","50","50","50","50","50"];
         ExtraDefine.swapToCode2([this.CarUpgradeDefence_G,this.CarUpgradeDefence_M,this.CarUpgradeDefence_XYZ,this.CarUpgradeLife_G,this.CarUpgradeLife_M,this.CarUpgradeLife_XYZ,this.CarUpgradeMust_G,this.CarUpgradeMust_M,this.CarUpgradeMust_X,this.CarUpgradeMust_Y]);
      }
      
      public function test2() : *
      {
         var i:int = 0;
         var _loc2_:Number = NaN;
         var bbs:Number = NaN;
         var life_0:Number = NaN;
      }
      
      public function fleshSubPosition(sp0:Sprite) : *
      {
         var name0:String = null;
         var mc0:* = undefined;
         this.pointArr.length = 0;
         for(var i:int = 0; i < 8; i++)
         {
            name0 = "a" + (i + 1);
            mc0 = sp0.getChildByName(name0);
            this.pointArr.push(new Point(mc0.x,mc0.y));
         }
      }
      
      public function checkSuper(str0:String) : Boolean
      {
         var n:* = undefined;
         for(n in this.noSuperList)
         {
            if(str0 == this.noSuperList[n])
            {
               return false;
            }
         }
         return true;
      }
      
      public function checkOnlyChampion(str0:String) : Boolean
      {
         var n:* = undefined;
         for(n in this.nolyChampionList)
         {
            if(str0 == this.nolyChampionList[n])
            {
               return true;
            }
         }
         return false;
      }
      
      public function getDpsByLevel(level0:int) : *
      {
         return 10 * Math.pow(level0,1.5) + 2;
      }
      
      public function getArmsMustItems(type0:String, mar:Array) : Array
      {
         var n:* = undefined;
         var arr00:Array = null;
         var i:* = undefined;
         var txt00:String = null;
         var txt_arr00:Array = null;
         var str0:String = null;
         if(int(mar[0]) == 0)
         {
            arr00 = [];
            for(i in mar)
            {
               txt00 = mar[i];
               txt_arr00 = txt00.split("_num");
               txt00 = txt_arr00[0] + "_num" + Math.ceil(Number(txt_arr00[1]));
               arr00.push(txt00);
            }
            return arr00;
         }
         var level0:int = int(mar[0]);
         var num0:int = int(mar[1]);
         var znum0:int = int(mar[2]);
         if(znum0 < 1)
         {
            znum0 = 1;
         }
         var arr1:Array = [];
         var arr0:Array = this[type0 + "MustItems"];
         var b1:String = "_" + level0;
         if(level0 == 5)
         {
            arr0 = this.mixedMustItems;
         }
         for(n in arr0)
         {
            str0 = arr0[n] + b1 + "_num" + num0;
            arr1.push(str0);
         }
         arr1.push("superalloy_num" + num0);
         arr1.push("superalloy_Z_num" + znum0);
         return arr1;
      }
      
      public function getArmsEnergyMax(agap:Number) : int
      {
         return 1.2 * 20 / ((agap + 0.1) * (1 + 20 * this.getArmsEnergyRa(agap))) / 2;
      }
      
      public function getArmsEnergyRa(agap:Number) : Number
      {
         return 0.011;
      }
      
      public function getTrainItemsNum(level0:int) : int
      {
         var num0:int = 0;
         if(level0 < 5000)
         {
            num0 = 0;
         }
         else if(level0 < 21)
         {
            num0 = 1;
         }
         else if(level0 < 31)
         {
            num0 = 2;
         }
         else if(level0 < 41)
         {
            num0 = 3;
         }
         else
         {
            num0 = 4;
         }
         return num0;
      }
      
      public function getTrainCoinNum(level0:int) : int
      {
         level0 += 1;
         return level0 * level0 * 300;
      }
      
      public function getTrainCoinNum_M(level0:int, type0:String) : int
      {
         level0 += 1;
         if(level0 > 500)
         {
            level0 = 500;
         }
         if(type0 == "all")
         {
            return (int((level0 - 1) / 5) + 1) * 10;
         }
         return 0;
      }
      
      public function getAllTrainCoinNum_M(level0:int) : Number
      {
         var m0:int = 0;
         for(var i:int = 0; i < level0; i++)
         {
            m0 += this.getTrainCoinNum_M(level0,"all");
         }
         return m0;
      }
      
      public function getTrainLevelNum(level0:int, type0:String) : int
      {
         var lv0:int = 1;
         if(type0 == "all")
         {
            if(level0 >= 400)
            {
               lv0 = 100;
            }
            else if(level0 >= 300)
            {
               lv0 = 80;
            }
            else if(level0 >= 200)
            {
               lv0 = 61;
            }
            else
            {
               lv0 = 1;
            }
         }
         else
         {
            lv0 = level0 + 1;
         }
         return lv0;
      }
      
      public function getSkillCoinNum(level0:int, name0:String) : int
      {
         return this[name0 + "SkillCoinNum"][level0];
      }
      
      public function getSkillLevelNum(level0:int, name0:String) : int
      {
         return this[name0 + "SkillLevelNum"][level0];
      }
      
      public function getAchieve(num0:int) : int
      {
         var rank0:int = Math.max(1,num0);
         if(num0 >= 24)
         {
            return 600000;
         }
         if(num0 >= 19)
         {
            return 500000;
         }
         if(num0 >= 15)
         {
            return 400000;
         }
         if(num0 >= 14)
         {
            return 300000;
         }
         return rank0 * rank0 * 500;
      }
      
      public function getAllAchieve(num0:int) : int
      {
         var n:int = 0;
         var value0:int = 0;
         var num1:int = num0 + 1;
         if(num0 >= 29)
         {
            value0 = 8410000;
         }
         else
         {
            for(n = 0; n < num1; n++)
            {
               value0 += this.getAchieve(n);
            }
         }
         return value0;
      }
      
      public function getRankName(num0:int) : String
      {
         return this.rankNameArr[num0];
      }
      
      public function getExp(num0:int) : Number
      {
         var _loc3_:int = 0;
         if(num0 >= 79)
         {
            return 500 * (num0 + 1) * (num0 + 1) * (num0 + 1) + 500 * (num0 + 1) + 500;
         }
         return 100 * (num0 + 1) * (num0 + 1) * (num0 + 1) + 100 * (num0 + 1) + 100;
      }
      
      public function getAllExp(num0:int) : Number
      {
         var exp0:Number = 0;
         for(var n:int = 0; n < num0; n++)
         {
            exp0 += this.getExp(n);
         }
         return exp0;
      }
      
      public function getLife(num0:int) : int
      {
         var num1:int = num0 + 1;
         if(num1 <= 60)
         {
            return 5 * num1 * num1 + 100;
         }
         return 20 * num1 * num1 + 1000;
      }
      
      public function getDefence(num0:int) : int
      {
         var num1:int = num0 + 1;
         return num1 * num1 + 20;
      }
      
      public function getDefence_ra(num0:int) : Number
      {
         return 50;
      }
      
      public function getCarLife(num0:int) : Point
      {
         var num1:int = num0 + 1;
         var p0:Point = new Point();
         p0.x = 30 * num1 * num1 + 100;
         p0.y = 300 * num1 / 7;
         return new Point(p0.x,p0.y);
      }
      
      public function test_getEnemyLevel(lv0:int, lock0:Array, lock1:Array, lock2:Array, max0:int = 31, max1:int = 13, max2:int = 10) : Array
      {
         var arr0:Array = [];
         var arr1:Array = this.test_getOneEnemyLevel(max0,"",lock0);
         var arr2:Array = this.test_getOneEnemyLevel(max1,"knowing",lock1);
         var arr3:Array = this.test_getOneEnemyLevel(max2,"ghost",lock2);
         arr0 = arr1.concat(arr2);
         arr0 = arr0.concat(arr3);
         return this.find5Level(lv0,arr0);
      }
      
      public function test_getOneEnemyLevel(lvMax:int, lp0:String, unlock_arr:Array) : Array
      {
         var n:* = undefined;
         var loopNum0:int = 0;
         var unlockNum0:int = 0;
         var i:int = 0;
         var arr0:Array = [[],[],[],[]];
         for(n in arr0)
         {
            loopNum0 = lvMax;
            unlockNum0 = int(unlock_arr[n]);
            if(unlockNum0 < lvMax)
            {
               loopNum0 = unlockNum0;
            }
            if(n == 0 && lp0 == "" && loopNum0 <= 1)
            {
               loopNum0 = 2;
            }
            for(i = 0; i < loopNum0; i++)
            {
               arr0[n][i] = this.test_getEnemyLevel_byLevel(i,n,lp0);
            }
         }
         return arr0;
      }
      
      public function find5Level(lv0:int, arr0:Array) : Array
      {
         var j:* = undefined;
         var arr01:Array = null;
         var arr_3:Array = null;
         var i:int = 0;
         var lv33:int = 0;
         var obj0:Object = null;
         var obj2:Object = null;
         var obj3:Object = null;
         var maxLv0:int = 0;
         for(j in arr0)
         {
            arr01 = arr0[j];
            if(arr01.length > 0)
            {
               maxLv0 = int(arr01[arr01.length - 1]);
            }
         }
         if(lv0 > maxLv0)
         {
            lv0 = maxLv0;
         }
         var lv1:int = lv0;
         if(lv0 < 25)
         {
            lv1 = lv0 - 5;
         }
         else
         {
            lv1 = lv0 - 3;
         }
         var findMaxB:Boolean = false;
         var arr1:Array = [];
         var bak_arr1:Array = [];
         for(var n:int = arr0.length - 1; n >= 0; n--)
         {
            arr_3 = arr0[n];
            for(i = arr_3.length - 1; i >= 0; i--)
            {
               lv33 = int(arr_3[i]);
               if(lv33 <= lv0 && lv33 > lv1)
               {
                  if(n > 3 || i != 0)
                  {
                     obj0 = new Object();
                     obj0.diff = n;
                     obj0.level = i;
                     obj0.taskLevel = lv33;
                     arr1.push(obj0);
                  }
               }
               if((lv33 <= lv0 || findMaxB) && bak_arr1.length < 5)
               {
                  findMaxB = true;
                  if(n > 3 || i != 0)
                  {
                     obj2 = new Object();
                     obj2.diff = n;
                     obj2.level = i;
                     obj2.taskLevel = lv33;
                     bak_arr1.push(obj2);
                  }
               }
            }
         }
         var all_arr1:Array = arr1;
         if(arr1.length == 0)
         {
            if(bak_arr1.length > 0)
            {
               all_arr1 = bak_arr1;
            }
            else
            {
               obj3 = new Object();
               obj3.diff = 0;
               obj3.level = 1;
               obj3.taskLevel = 1;
               all_arr1 = [obj3];
            }
         }
         for(var m:int = 0; m < Math.abs(5 - all_arr1.length); i++)
         {
            if(all_arr1.length < 5)
            {
               all_arr1.push(all_arr1[int(all_arr1.length * Math.random())]);
            }
            else
            {
               all_arr1.splice(int(all_arr1.length * Math.random()),1);
            }
         }
         return all_arr1;
      }
      
      public function test_getEnemyLevel_byLevel(level0:int, diff0:int, levelPack0:String = "") : int
      {
         return this.level.getEnemyLevel_byLevel(level0,diff0,levelPack0);
      }
      
      public function test_getEnemyLife_byLevel(num0:int, diffict:int = 0) : Number
      {
         var num1:int = num0 + 1;
         if(num1 < 3)
         {
            num1 = 3;
         }
         var chipRa:Number = 0;
         var subRa:Number = 1;
         if(num1 < 11)
         {
            chipRa = 0.15;
            subRa = 1;
         }
         else if(num1 < 21)
         {
            chipRa = 0.3;
            subRa = 2;
         }
         else if(num1 < 31)
         {
            chipRa = 0.45;
            subRa = 3;
         }
         else if(num1 < 41)
         {
            chipRa = 0.6;
            subRa = 4;
         }
         else if(num1 < 51)
         {
            chipRa = 1;
            subRa = 4;
         }
         else if(num1 < 61)
         {
            chipRa = 1.5;
            subRa = 5;
         }
         else if(num1 < 71)
         {
            chipRa = 2;
            subRa = 6;
         }
         else if(num1 < 81)
         {
            chipRa = 3;
            subRa = 7;
         }
         else if(num1 < 91)
         {
            chipRa = 4;
            subRa = 8;
         }
         else if(num1 < 101)
         {
            chipRa = 5;
            subRa = 8;
         }
         else if(num1 < 111)
         {
            chipRa = 5.5;
            subRa = 8;
         }
         else if(num1 < 121)
         {
            chipRa = 6;
            subRa = 8;
         }
         else if(num1 < 131)
         {
            chipRa = 6.5;
            subRa = 8;
         }
         else
         {
            chipRa = 7;
            subRa = 8;
         }
         var k0:Number = 10;
         var num2:Number = (4 * 1.2 * k0 * Math.sqrt(num1 * num1 * num1) * 1.5 * (1 + num1 * 0.02 + chipRa) + 1.15 * 1.2 * k0 * Math.sqrt(num1 * num1 * num1) * 1.5 * (1 + num1 * 0.02 + chipRa) * subRa) / 2 * 1.2 * 0.8;
         return Math.ceil(num2);
      }
      
      public function test_getEnemyLife_byLevel2(num0:int) : Number
      {
         var num1:int = num0 + 1;
         if(num1 < 3)
         {
            num1 = 3;
         }
         var chipRa:Number = 0;
         var subRa:Number = 1;
         if(num1 < 11)
         {
            chipRa = 0.15;
            subRa = 1;
         }
         else if(num1 < 21)
         {
            chipRa = 0.3;
            subRa = 2;
         }
         else if(num1 < 31)
         {
            chipRa = 0.45;
            subRa = 3;
         }
         else if(num1 < 41)
         {
            chipRa = 0.6;
            subRa = 4;
         }
         else if(num1 < 51)
         {
            chipRa = 0.8;
            subRa = 4;
         }
         else if(num1 < 61)
         {
            chipRa = 1.2;
            subRa = 5;
         }
         else if(num1 < 71)
         {
            chipRa = 1.6;
            subRa = 6;
         }
         var k0:Number = 10;
         var num2:Number = (4 * 1.2 * k0 * Math.sqrt(num1 * num1 * num1) * 1.5 * (1 + num1 * 0.02 + chipRa) + 1.15 * 1.2 * k0 * Math.sqrt(num1 * num1 * num1) * 1.5 * (1 + num1 * 0.02 + chipRa) * subRa) / 2 * 1.3;
         return Math.ceil(num2);
      }
      
      public function getChipSubRa(num1:int) : Array
      {
         var chipRa:Number = 0;
         var subRa:Number = 1;
         if(num1 <= 10)
         {
            chipRa = 1;
            subRa = 1;
         }
         else if(num1 < 26)
         {
            chipRa = 1.2;
            subRa = 2;
         }
         else if(num1 < 41)
         {
            chipRa = 1.4;
            subRa = 3;
         }
         else if(num1 < 51)
         {
            chipRa = 1.6;
            subRa = 4;
         }
         else if(num1 < 65)
         {
            chipRa = 2;
            subRa = 6;
         }
         else
         {
            chipRa = 2.8;
            subRa = 6;
         }
         return [chipRa,subRa];
      }
      
      public function test_getEnemyHurt_byLevel(num0:int, diffict:int = 0) : Number
      {
         return this.test_getEnemyHurt_byLevel2(num0,diffict);
      }
      
      public function test_getEnemyHurt_byLevel2(num0:int, diffict:int = 0) : Number
      {
         var num1:int = num0 + 1;
         var p0:Point = this.getCarLife(num0);
         var chipRa:Number = 1;
         if(num1 < 11)
         {
            chipRa = 0.2;
         }
         else if(num1 < 21)
         {
            chipRa = 0.5;
         }
         else if(num1 < 31)
         {
            chipRa = 1;
         }
         else if(num1 < 41)
         {
            chipRa = 1.5;
         }
         else if(num1 < 51)
         {
            chipRa = 2;
         }
         else if(num1 < 61)
         {
            chipRa = 3;
         }
         else if(num1 < 71)
         {
            chipRa = 4;
         }
         else if(num1 < 81)
         {
            chipRa = 5;
         }
         else if(num1 < 91)
         {
            chipRa = 6;
         }
         else if(num1 < 101)
         {
            chipRa = 7;
         }
         else if(num1 < 111)
         {
            chipRa = 8;
         }
         else if(num1 < 121)
         {
            chipRa = 9;
         }
         else if(num1 < 131)
         {
            chipRa = 10;
         }
         else
         {
            chipRa = 11;
         }
         var k0:Number = 5;
         var k1:Number = 100;
         if(num1 > 60)
         {
            k0 = 20;
            k1 = 1000;
         }
         var num2:Number = 2 * (k0 * num1 * num1 + k1 + p0.x * 2) * (1 + num1 * 0.02 + chipRa) / 166;
         if(diffict == 3)
         {
            return Math.ceil(num2 * 2);
         }
         if(diffict == 2)
         {
            return Math.ceil(num2 * 1.5);
         }
         return Math.ceil(num2);
      }
      
      public function test_getEnemyExp_byLevel(num0:int) : int
      {
         if(num0 > 68)
         {
            return (47700 + (num0 - 69) * 100) * 1.5 * 2;
         }
         return (10 * (num0 + 1) * (num0 + 1) + 10) * 1.5 * 1.2 * 2;
      }
      
      public function test_getEnemyCoin_byLevel(num0:int) : int
      {
         return (num0 + 1) * 5 + 10;
      }
      
      public function getNowDifficult_ra(level0:int, index0:int, levelPack0:String = "") : Number
      {
         var ra0:Number = 1;
         return index0 + 1;
      }
      
      public function getEnemyAchieve_byLevel(e_lv0:int, b_lv0:int, enemyType0:String) : int
      {
         var cx:int = e_lv0 - b_lv0;
         var num1:int = 0;
         if(enemyType0 == "boss")
         {
            num1 = 12;
         }
         else if(enemyType0 == "champion")
         {
            num1 = 6;
         }
         else if(enemyType0 == "super")
         {
            num1 = 4;
         }
         else
         {
            num1 = 2;
         }
         return num1;
      }
      
      public function getRecommendLevel(level0:int, diff0:int) : String
      {
         return this.recommendLevelArr[diff0][level0];
      }
      
      public function getKnowingMustLevel(diff0:int) : int
      {
         if(diff0 == 0)
         {
            return 25;
         }
         if(diff0 == 1)
         {
            return 50;
         }
         return 50;
      }
      
      public function getKnowingMustLv(lv0:int) : int
      {
         var arr0:Array = [25,28,30,32,35,40,45,50,50,50,60,60,60,60];
         if(lv0 > arr0.length - 1)
         {
            lv0 = arr0.length - 1;
         }
         return arr0[lv0];
      }
      
      public function getKnowingUnlockLevel(lv0:int, maxLevel0:int) : int
      {
         var must_lv0:int = 0;
         for(var i:int = 0; i < maxLevel0; i++)
         {
            must_lv0 = this.getKnowingMustLv(i);
            if(lv0 + 1 < must_lv0)
            {
               return i;
            }
         }
         return i;
      }
      
      public function getGhostMustLevel(diff0:int) : int
      {
         if(diff0 == 0)
         {
            return 60;
         }
         if(diff0 == 1)
         {
            return 60;
         }
         return 60;
      }
      
      public function getGhostMustLv(lv0:int) : int
      {
         var arr0:Array = [60,60,60,60,60,60,60,60,60,60,60,60,60,60,60,60,60,60,60,60,60,60,60,60,60,60,60,60,60];
         if(lv0 > arr0.length - 1)
         {
            lv0 = arr0.length - 1;
         }
         return arr0[lv0];
      }
      
      public function getEnemyHeroHurt(level0:int) : Number
      {
         return 5;
      }
      
      public function dropString_byLevel(lv0:int) : String
      {
         lv0++;
         var maxlv2:int = lv0;
         var minLv2:int = lv0 - 3;
         if(minLv2 < 1)
         {
            minLv2 = 1;
         }
         var m_arr:Array = [1,21,41,51,61,81,101];
         var m_f_arr:Array = ["初级","中级","高级","大师级","专家级","史诗级","宗师级"];
         var c_arr:Array = [1];
         var c_f_arr:Array = ["1级"];
         var m_str:String = "材料（";
         var m_index1:int = this._getMaxIndex(maxlv2,m_arr);
         var m_index2:int = this._getMaxIndex(minLv2,m_arr);
         if(m_index1 != m_index2)
         {
            m_str += m_f_arr[m_index2] + "~" + m_f_arr[m_index1];
         }
         else
         {
            m_str += m_f_arr[m_index1];
         }
         m_str += "）";
         var c_str:String = "晶体（";
         var c_index1:int = this._getMaxIndex(maxlv2,c_arr);
         var c_index2:int = this._getMaxIndex(minLv2,c_arr);
         if(c_index1 != c_index2)
         {
            c_str += c_f_arr[c_index2] + "~" + c_f_arr[c_index1];
         }
         else
         {
            c_str += c_f_arr[c_index1];
         }
         c_str += "）";
         var chip_str:String = "芯片（" + minLv2 + "级~" + maxlv2 + "级）";
         return m_str + "\n" + c_str + "\n" + chip_str + "\n" + "超合金\n超合金Z";
      }
      
      private function _getMaxIndex(lv0:int, arr0:Array) : int
      {
         var n:* = undefined;
         var lv2:int = 0;
         var index0:int = 0;
         for(n in arr0)
         {
            lv2 = int(arr0[n]);
            if(lv0 < lv2)
            {
               if(n == 0)
               {
                  return 0;
               }
               return n - 1;
            }
         }
         return arr0.length - 1;
      }
      
      public function getCrystalUpgradeCoin(num:int, isCrystalB:Boolean = true) : int
      {
         var crystalUpgradeCoinArr:Array = [0,4000,8000,40000,80000,160000,320000,640000,1280000];
         var materialUpgradeCoinArr:Array = [0,500,1000,2000,4000,8000,16000];
         if(isCrystalB)
         {
            return crystalUpgradeCoinArr[num - 1];
         }
         return materialUpgradeCoinArr[num - 1];
      }
      
      public function getCrystalUpgradeLevel(num:int, isCrystalB:Boolean = true) : int
      {
         var crystalUpgradeLevelArr:Array = [0,1,1,1,1,1,1,1,1];
         var materialUpgradeLevelArr:Array = [0,1,1,1,1,1,1];
         if(isCrystalB)
         {
            return crystalUpgradeLevelArr[num - 1];
         }
         return materialUpgradeLevelArr[num - 1];
      }
      
      public function addSuperalloy(num0:int) : Object
      {
         var n:* = undefined;
         var i:int = 0;
         var m:* = undefined;
         var q:* = undefined;
         var index0:int = 0;
         var num4:int = 0;
         var arr0:Array = ["s","x","y","z"];
         var arr_txt:Array = ["超合金","超合金X","超合金Y","超合金Z"];
         var colorArr:Array = ["#FFFFFF","#00FF00","#FF9900","#FF33FF"];
         var arr1:Array = [6,3,2.5,2];
         var perArr:Array = [0,0.8,0.2,0];
         var obj0:Object = new Object();
         for(n in arr0)
         {
            obj0[arr0[n]] = 0;
         }
         for(i = 0; i < num0; i++)
         {
            index0 = StringToDefine.getPro_byArr(perArr);
            obj0[arr0[index0]] += arr1[index0] * 2;
         }
         var arr2:Array = [];
         for(m in arr0)
         {
            num4 = int(obj0[arr0[m]]);
            if(num4 > 0)
            {
               arr2.push(StringToDefine.getFontColor(arr_txt[m],colorArr[m]) + StringToDefine.getFontColor(" " + num4,"#FFFF00") + "个");
            }
         }
         obj0.text = "";
         for(q in arr2)
         {
            obj0.text += arr2[q];
            if(q < arr2.length - 1)
            {
               obj0.text += "，";
            }
         }
         return obj0;
      }
      
      public function getChipPrice(name0:String, affixLevel:int) : int
      {
         affixLevel++;
         var ra:Number = 2;
         if(name0 == "white_chip")
         {
            ra = 1;
         }
         else if(name0 == "blue_chip")
         {
            ra = 1.25;
         }
         else if(name0 == "yellow_chip")
         {
            ra = 1.5;
         }
         else if(name0 == "orange_chip")
         {
            ra = 1.75;
         }
         else if(name0 == "green_chip")
         {
            ra = 2;
         }
         return (10 * affixLevel + 20) * ra;
      }
      
      public function getTestB() : Boolean
      {
         if(this.nowLevel > 1)
         {
            return true;
         }
         return false;
      }
      
      public function getTaskExp(level0:int) : int
      {
         return this.taskDefine.getTaskExp(level0);
      }
      
      public function getTaskGCoin(level0:int) : int
      {
         return this.taskDefine.getGCoin(level0);
      }
      
      public function getTaskGiftArr(level0:int, star0:int, type0:* = "soldier", color0:String = "") : Array
      {
         var arr0:Array = [];
         var multiple0:Number = 1;
         if(type0 == "super")
         {
            multiple0 = 1.1;
         }
         var exp0:int = this.getTaskExp(level0) * 1.2;
         var exp1:int = exp0 * (star0 + 1) * multiple0;
         var coin0:int = this.getTaskGCoin(level0) * multiple0 * 1.2;
         var coin1:int = coin0 * (star0 / 2 + 1);
         var crystalLevel0:int = this.drop.getTaskCrystalLevel(level0);
         var crystalNum0:int = star0 + 1;
         if(level0 > 200)
         {
            crystalLevel0++;
         }
         else
         {
            arr0.push("exp," + exp1 + ",1");
         }
         arr0.push("GCoin," + coin1 + ",1");
         arr0.push("materials,\tsuperalloy_X,\t2");
         arr0.push("red_crystal,\t3,\t\t\t\t1");
         return arr0;
      }
      
      public function getTaskUpStar_M(star0:int) : NormalMustDefine
      {
         var nmd0:NormalMustDefine = new NormalMustDefine();
         nmd0.MCoin = (star0 + 1) * 2;
         return nmd0;
      }
      
      public function getTaskFleshList_M() : NormalMustDefine
      {
         var nmd0:NormalMustDefine = new NormalMustDefine();
         nmd0.MCoin = 1;
         return nmd0;
      }
      
      public function getTaskUpUseNum_M(maxNum0:int) : NormalMustDefine
      {
         var nmd0:NormalMustDefine = new NormalMustDefine();
         nmd0.MCoin = (int((maxNum0 - 10) / 5) + 1) * 10;
         if(nmd0.MCoin < 1)
         {
            nmd0.MCoin = 1;
         }
         return nmd0;
      }
      
      public function getChipCubeMustCoin(chipName0:String) : int
      {
         var arr0:Array = ["white_chip","blue_chip","yellow_chip","orange_chip"];
         var arr1:Array = [1000,2000,3000,4000,5000];
         var num0:int = arr0.indexOf(chipName0);
         return arr1[num0];
      }
      
      public function getGroupScore(time0:int, index0:int) : Number
      {
         var mul_arr:Array = [0.1,0.15,0.3,0.4,0.6,0.8,1,2,4,4,5,6,6,6];
         var baseScore0:int = 0;
         if(time0 < 20)
         {
            baseScore0 = 100;
         }
         else if(time0 < 60)
         {
            baseScore0 = 70;
         }
         else if(time0 < 120)
         {
            baseScore0 = 50;
         }
         else if(time0 < 180)
         {
            baseScore0 = 30;
         }
         else if(time0 < 600)
         {
            baseScore0 = 10;
         }
         else
         {
            baseScore0 = 0;
         }
         return int(baseScore0 * mul_arr[index0]);
      }
      
      public function getStatistics(time0:Number, hitRate:Number, nowHurtNum0:Number) : Array
      {
         var t_s:int = 50 - Math.ceil((time0 - 4 * 60) / 10);
         if(t_s > 50)
         {
            t_s = 50;
         }
         if(t_s < 0)
         {
            t_s = 0;
         }
         var h_s:int = 20 - Math.ceil((0.8 - hitRate) / 0.02);
         if(h_s > 20)
         {
            h_s = 20;
         }
         if(h_s < 0)
         {
            h_s = 0;
         }
         var n_s:int = 50 - Math.ceil((nowHurtNum0 - 20) / 1);
         if(n_s > 50)
         {
            n_s = 50;
         }
         if(n_s < 0)
         {
            n_s = 0;
         }
         var a_s:int = t_s + n_s;
         var grade0:String = this.getPassGrade(a_s);
         return [t_s,h_s,n_s,a_s,grade0];
      }
      
      public function getPassGrade(a_s:int) : String
      {
         var arr0:Array = [" 无"," D 级"," C 级"," B 级"," A 级"," S 级"," SS 级"," SSS 级"];
         return arr0[this.getPassGradeIndex(a_s)];
      }
      
      public function getPassGradeIndex(a_s:int) : int
      {
         var grade0:int = 0;
         if(a_s >= 10000)
         {
            return 1;
         }
         return 0;
      }
      
      public function getCarUpgradeLife(lv0:int, type0:String) : Number
      {
         var lv1:int = 0;
         var uparr:Array = this["CarUpgradeLife_" + type0];
         var num0:Number = 0;
         if(lv0 >= 10)
         {
            lv1 = lv0 / 5 - 2;
            num0 = int(TextWay.getText(uparr[lv1]));
         }
         return num0;
      }
      
      public function getCarUpgradeDefence(lv0:int, type0:String) : Number
      {
         var lv1:int = 0;
         var uparr:Array = this["CarUpgradeDefence_" + type0];
         var num0:Number = 0;
         if(lv0 >= 10)
         {
            lv1 = lv0 / 5 - 2;
            num0 = int(TextWay.getText(uparr[lv1]));
         }
         return num0;
      }
      
      public function getCarUpgradeMust(lv0:int, type0:String) : Number
      {
         var lv1:int = 0;
         var uparr:Array = this["CarUpgradeMust_" + type0];
         var num0:Number = 0;
         if(lv0 >= 5)
         {
            lv1 = lv0 / 5 - 1;
            num0 = int(TextWay.getText(uparr[lv1]));
         }
         return num0;
      }
   }
}

